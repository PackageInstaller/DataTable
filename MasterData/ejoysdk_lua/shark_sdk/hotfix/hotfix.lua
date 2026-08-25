local logger = require("ejoysdk_lua.shark_sdk.util.logger")
local client_config = require("ejoysdk_lua.shark_sdk.config.client_config")
local version_checker = require("ejoysdk_lua.shark_sdk.hotfix.version_checker")
local config_fetcher = require("ejoysdk_lua.shark_sdk.hotfix.config_fetcher")
local file_downloader = require("ejoysdk_lua.shark_sdk.hotfix.file_downloader")
local download_task = require("ejoysdk_lua.shark_sdk.hotfix.download_task")
local hotfix_event = require("ejoysdk_lua.shark_sdk.hotfix.hotfix_event")
local ejoysdk = require("ejoysdk_lua.ejoysdk")
local M = {}
local state = {
  is_running = false,
  next_fetch_time = 0,
  hotfix_config = nil,
  old_config = nil,
  download_queue = {},
  current_download_task = nil,
  version_task = nil,
  config_task = nil,
  on_finished_callback = nil,
  on_failed_callback = nil
}

local function notify_failed(err_msg)
  logger.error("热更失败: %s", tostring(err_msg))
  if state.on_failed_callback then
    state.on_failed_callback(err_msg)
  end
end

local function notify_finished()
  logger.info("版本检查完成")
  if not state.on_finished_callback then
    return
  end
  local changed_list = state.hotfix_config and state.hotfix_config.changed_list or {}
  state.on_finished_callback(state.old_config, state.hotfix_config, changed_list)
end

local function download_resource_files()
  if state.config_task then
    return
  end
  local hotfix_dir = client_config.get_hotfix_dir()
  local temp_dir = client_config.get_hotfix_temp_dir()
  
  local function download_next()
    local next_item = table.remove(state.download_queue, 1)
    if not next_item then
      logger.info("本次热更文件下载完成")
      state.current_download_task = nil
      state.download_queue = {}
      notify_finished()
      return
    end
    local task = download_task.create_task_with_raw_urls(next_item.urls, next_item.file_name, function()
      state.current_download_task = nil
      hotfix_event.report(hotfix_event.EVENT.DOWNLOAD_FILE_SUCCESS, {
        filename = next_item.file_name
      })
      download_next()
    end, function()
      state.current_download_task = nil
      state.download_queue = {}
      hotfix_event.report(hotfix_event.EVENT.DOWNLOAD_FILE_FAILED, {
        filename = next_item.file_name
      })
      notify_failed(string.format("文件下载失败: %s", next_item.file_name))
    end, hotfix_dir, temp_dir)
    state.current_download_task = task
    logger.info("开始下载文件: %s", next_item.file_name)
    task:start()
  end
  
  hotfix_event.report(hotfix_event.EVENT.DOWNLOAD_START, {
    file_count = #state.download_queue
  })
  download_next()
end

local function resource_file_diff()
  local new_config, err = config_fetcher.parse_downloaded_config()
  if nil ~= err then
    logger.error("解析新hotfix_cfg.json失败, %s", err)
    notify_failed(err)
    return
  end
  if nil == new_config then
    local msg = "新hotfix_cfg.json不存在或无效，本次更新终止"
    logger.error(msg)
    notify_failed(msg)
    return
  end
  local old_config = config_fetcher.parse_local_config()
  if nil == old_config then
    logger.warn("本地hotfix config不存在或无效，设置为nil")
  end
  state.old_config = old_config
  local old_list
  if nil ~= old_config then
    old_list = old_config.hotfix_list
  end
  local changed_list = config_fetcher.diff_hotfix_list(old_list, new_config.hotfix_list)
  state.hotfix_config = new_config
  state.hotfix_config.changed_list = changed_list
  if 0 == #changed_list then
    logger.info("所有文件已是最新")
    notify_finished()
  else
    state.download_queue = file_downloader.build_download_list(changed_list)
    download_resource_files()
  end
end

local function fetch_config()
  logger.info("正在拉取hotfix_cfg文件")
  if not state.is_running then
    return
  end
  if state.config_task then
    logger.info("配置拉取已在进行中")
    return
  end
  local hotfix_dir = client_config.get_hotfix_dir()
  local temp_dir = client_config.get_hotfix_temp_dir()
  
  local function on_finish()
    state.config_task = nil
    logger.info("配置拉取完成")
    hotfix_event.report(hotfix_event.EVENT.CONFIG_FETCH_SUCCESS)
    resource_file_diff()
  end
  
  local function on_error()
    state.config_task = nil
    local errmsg = "配置拉取失败"
    logger.error(errmsg)
    hotfix_event.report(hotfix_event.EVENT.CONFIG_FETCH_FAILED)
    notify_failed(errmsg)
  end
  
  local urls = config_fetcher.get_config_url_list()
  local task = download_task.create_task_with_raw_urls(urls, config_fetcher.get_hotfix_cfg_filename(), on_finish, on_error, hotfix_dir, temp_dir)
  state.config_task = task
  hotfix_event.report(hotfix_event.EVENT.CONFIG_FETCH_START)
  task:start()
end

local function fetch_version()
  if not state.is_running then
    return
  end
  if state.version_task or state.config_task or state.current_download_task or state.download_queue and #state.download_queue > 0 then
    logger.debug("热更流程进行中，跳过本次版本检查")
    return
  end
  logger.info("执行版本检查，正在拉取version文件")
  local hotfix_dir = client_config.get_hotfix_dir()
  local temp_dir = client_config.get_hotfix_temp_dir()
  
  local function on_finish(task)
    state.version_task = nil
    logger.info("version.json文件下载完成")
    if version_checker.is_version_up_to_date() then
      logger.debug("版本未变化")
      local local_config = config_fetcher.parse_local_config()
      state.old_config = local_config
      state.hotfix_config = local_config
      if state.hotfix_config then
        state.hotfix_config.changed_list = {}
      end
      notify_finished()
    else
      logger.info("版本存在差异, 开始拉取hotfix_cfg.json文件")
      fetch_config()
    end
  end
  
  local function on_error()
    state.version_task = nil
    local errmsg = "version.json文件下载失败"
    logger.error(errmsg)
    hotfix_event.report(hotfix_event.EVENT.CONFIG_FETCH_FAILED)
    notify_failed(errmsg)
  end
  
  local urls = version_checker.get_version_url_list()
  local task = download_task.create_task_with_raw_urls(urls, version_checker.get_version_filename(), on_finish, on_error, hotfix_dir, temp_dir)
  state.version_task = task
  task:start()
end

local function check_remote_version()
  if not state.is_running then
    return
  end
  ejoysdk.Timer.once(client_config.get_fetch_interval(), check_remote_version)
  local now = os.time()
  logger.debug("定时器检查，当前时间 %s, 版本检查时间 %s", now, state.next_fetch_time)
  if now < state.next_fetch_time then
    return
  end
  state.next_fetch_time = now + client_config.get_fetch_interval()
  fetch_version()
end

function M.on_fetch_hotfix_finished(callback)
  function state.on_finished_callback(old_hotfix_list, new_hotfix_list, changed_list)
    logger.info("执行资源文件覆盖")
    
    local hotfix_dir = client_config.get_hotfix_dir()
    local temp_dir = client_config.get_hotfix_temp_dir()
    for _, file_cfg in ipairs(changed_list) do
      local file_name = file_downloader.build_file_name(file_cfg)
      local src = temp_dir .. "/" .. file_name
      local dst = hotfix_dir .. "/" .. file_name
      local succ, code, msg = ejoysdk.File.copy(src, dst, {override = true})
      if succ then
        logger.debug("资源文件已覆盖: %s", file_name)
      else
        logger.error("资源文件覆盖失败: %s, code=%s, msg=%s", file_name, tostring(code), tostring(msg))
        hotfix_event.report(hotfix_event.EVENT.APPLY_FAILED, {
          error = tostring(msg)
        })
        return
      end
    end
    local cfg_src = config_fetcher.get_config_temp_path()
    local cfg_dst = config_fetcher.get_config_file_path()
    local cfg_succ, _, cfg_msg = ejoysdk.File.copy(cfg_src, cfg_dst, {override = true})
    if cfg_succ then
      logger.debug("hotfix_cfg.json 已覆盖")
    else
      logger.error("hotfix_cfg.json 覆盖失败: %s", tostring(cfg_msg))
      return
    end
    local ver_src = version_checker.get_version_temp_path()
    local ver_dst = version_checker.get_version_file_path()
    local ver_succ, _, ver_msg = ejoysdk.File.copy(ver_src, ver_dst, {override = true})
    if ver_succ then
      logger.debug("version.json 已覆盖")
    else
      logger.error("version.json 覆盖失败: %s", tostring(ver_msg))
      return
    end
    hotfix_event.report(hotfix_event.EVENT.APPLY_START)
    local xok, ok, err = xpcall(callback, function(e)
      logger.error("业务层完成回调异常: %s", tostring(e))
      hotfix_event.report(hotfix_event.EVENT.APPLY_FAILED, {
        error = tostring(e)
      })
    end, old_hotfix_list, new_hotfix_list)
    if not xok then
      return
    end
    if not ok then
      if err then
        logger.error("业务层回调返回失败: %s", tostring(err))
      end
      hotfix_event.report(hotfix_event.EVENT.APPLY_FAILED, {
        error = tostring(err)
      })
    else
      hotfix_event.report(hotfix_event.EVENT.APPLY_SUCCESS)
    end
  end
end

function M.on_fetch_hotfix_failed(callback)
  function state.on_failed_callback(err_msg)
    xpcall(callback, function(e)
      logger.error("业务层失败回调异常: %s", tostring(e))
    end, err_msg)
  end
end

function M.start()
  if state.is_running then
    logger.info("热更轮询已在运行中，跳过")
    return
  end
  logger.info("热更轮询启动运行")
  state.is_running = true
  check_remote_version()
end

function M.fetch()
  if state.version_task or state.config_task then
    logger.info("热更正在检查更新，跳过")
    return
  end
  fetch_version()
end

function M.stop()
  if not state.is_running then
    return
  end
  state.is_running = false
  state.version_task = nil
  state.config_task = nil
  state.download_queue = {}
  logger.info("热更轮询已停止")
end

return M
