local logger = require("ejoysdk_lua.shark_sdk.util.logger")
local file_util = require("ejoysdk_lua.shark_sdk.util.file_util")
local client_config = require("ejoysdk_lua.shark_sdk.config.client_config")
local hotfix_event = require("ejoysdk_lua.shark_sdk.hotfix.hotfix_event")
local M = {}

function M.build_file_name(file_cfg)
  local file_name = file_cfg.fix_file_name
  local md5 = file_cfg.md5
  local file_prefix = file_name:match("^(.+)%.")
  local file_suffix = file_name:match("%.([^%.]+)$")
  return file_prefix .. "_" .. md5 .. "." .. file_suffix
end

function M.get_file_url_list(file_cfg)
  local cdn_urls = client_config.get_cdn_urls()
  local branch = client_config.get_branch()
  local version = client_config.get_version()
  local file_name = M.build_file_name(file_cfg)
  local url_list = {}
  for _, base_url in ipairs(cdn_urls) do
    url_list[#url_list + 1] = base_url .. "/" .. tostring(branch) .. "/" .. tostring(version) .. "/" .. file_name
  end
  return url_list
end

function M.get_file_paths(file_cfg)
  local file_name = M.build_file_name(file_cfg)
  local hotfix_dir = client_config.get_hotfix_dir()
  local temp_dir = client_config.get_hotfix_temp_dir()
  local dst_path = hotfix_dir .. "/" .. file_name
  local tmp_path = temp_dir .. "/" .. file_name
  return dst_path, tmp_path
end

function M.is_file_already_downloaded(file_cfg)
  local _, tmp_path = M.get_file_paths(file_cfg)
  if file_util.file_exists(tmp_path) then
    local local_md5, err = file_util.get_file_md5(tmp_path)
    if nil ~= err then
      logger.error("获取文件 md5 失败: " .. err)
      return false
    end
    if local_md5 == file_cfg.md5 then
      logger.info("文件已存在于临时目录且md5一致, 跳过: %s", file_cfg.fix_file_name)
      hotfix_event.report(hotfix_event.EVENT.FILE_DEDUP, {
        file_name = file_cfg.fix_file_name
      })
      return true
    end
    logger.info([[
local md5: %s 
 remote md5: %s]], local_md5, file_cfg.md5)
    logger.info("文件存在于临时目录但md5不一致, 需重新下载: %s", file_cfg.fix_file_name)
  end
  return false
end

function M.build_download_list(hotfix_list)
  local download_list = {}
  for _, file_cfg in ipairs(hotfix_list) do
    if not M.is_file_already_downloaded(file_cfg) then
      download_list[#download_list + 1] = {
        file_cfg = file_cfg,
        urls = M.get_file_url_list(file_cfg),
        file_name = M.build_file_name(file_cfg)
      }
    end
  end
  logger.info("下载列表构建完成, 待下载文件数: %s", #download_list)
  return download_list
end

return M
