local E = require("ejoysdk_lua.ejoysdk")
local cloud_config = require("ejoysdk_lua.cloud_game.cloud_config")
local ejoysdk = require("ejoysdk_lua.ejoysdk")
local EM = require("ejoysdk_lua.ejoysdk_module")
local EC = require("ejoysdk_lua.ejoysdk_constants")
local CSTAT = require("ejoysdk_lua.cloud_game.cloud_stat")
local CIPM = require("ejoysdk_lua.cloud_game.cloud_install_pkg_manager")
local TAG = EM.MODULE.CLOUD_GAME .. "download_utils"
local M = {}
local MAX_RETRY_CNT = 3
local RETRY_TIME_DELAY = 1
M.download_folder = nil
M.temp_folder = nil
local suffix = "_dl_bak_"
M.URL_CONF = "_cloud_game_url.json"
M.RES_FILE_LIST = "game_resource_files.json"
M.RES_STATE_CACHE = E.LazyKeyStore:New("CLOUD_GAME_RES_STATE_INFO", false, true, false)
local is_download_file_pause = false
local file_recv_bytes = {}
local file_complete_temp_list = {}
local last_calc_recv_bytes = 0
local last_calc_speed_time = 0
local current_download_speed = 0
local remote_res_url_sp = E.SPKeyStore:New("com.ejoy.cloud_config", "remote_url")
local download_speed_change_listener
local assets_state_info = {}
local download_pause_listener

local function log(s)
  E.LOG.debug(TAG, s)
end

M.STATE_KEY = {STATE = "state", VERSION_NAME = "ver_name"}
M.CLOUD_RES_STATE = {
  FINISH = "finish",
  DOWNLOADING = "downloading",
  UPDATING = "updating",
  DISABLE = "disable"
}

function M.check_file_valid(path, file_size)
  local file = io.open(path, "rb")
  if file then
    local len = assert(file:seek("end"))
    file:close()
    if M.get_os() == "windows" then
      return true
    end
    return len == file_size
  end
end

local function create_dir(dir)
  if E.Sysinfo.os() ~= "windows" then
    return
  end
  dir = string.sub(dir, 1, #dir - 1)
  local file = io.open(dir)
  if not file then
    local cmd
    if "windows" == M.get_os() then
      cmd = "mkdir " .. dir
    else
      cmd = "mkdir -p " .. dir
    end
    os.execute(cmd)
  else
    file:close()
  end
end

function M.get_os()
  do return end
  return E.Sysinfo.os, nil
end

local function calc_total_bytes()
  local recv_bytes_count = 0
  for _file_name, file_bytes in pairs(file_recv_bytes) do
    recv_bytes_count = recv_bytes_count + file_bytes
  end
  return recv_bytes_count
end

local function on_download_received_bytes_changed(file, received_bytes, total)
  if total and total <= 0 then
    E.LOG.error(TAG, "on_download_received_bytes_changed, total bytes <= 0, return")
    return
  end
  file_recv_bytes[file] = received_bytes
  if received_bytes == total then
    file_complete_temp_list[file] = received_bytes
  end
  local cur_time = E.time()
  if 0 == last_calc_speed_time then
    last_calc_speed_time = cur_time
  end
  local diff_time = cur_time - last_calc_speed_time
  if diff_time >= 1 then
    local total_recv_bytes = calc_total_bytes()
    local diff_bytes = total_recv_bytes - last_calc_recv_bytes
    local speed = math.floor(diff_bytes / diff_time)
    last_calc_speed_time = cur_time
    if file_complete_temp_list and next(file_complete_temp_list) ~= nil then
      local total_bytes = total_recv_bytes
      for f, f_size in pairs(file_complete_temp_list) do
        total_bytes = total_bytes - f_size
        file_recv_bytes[f] = nil
      end
      last_calc_recv_bytes = total_bytes
    else
      last_calc_recv_bytes = total_recv_bytes
    end
    file_complete_temp_list = {}
    if speed > 0 and current_download_speed ~= speed then
      current_download_speed = speed
      if nil ~= download_speed_change_listener then
        download_speed_change_listener(current_download_speed)
      end
    end
  end
end

local function request_file(url, file, cb, file_size, file_md5, on_download_progress)
  local temp_file = M.temp_folder .. file .. suffix
  if M.get_os() ~= "windows" then
    local function down_cb(ret)
      if ret.status == 200 or 0 == ret.status then
        if not file_size or M.check_file_valid(temp_file, file_size) then
          os.remove(M.download_folder .. file)
          
          os.rename(temp_file, M.download_folder .. file)
          cb(true)
        else
          log("[cloud game] request_file size error " .. file)
          cb(false, EC.DOWNLOAD_ERROR_CODES.DOWNFINISH_FILE_INVALID)
        end
      else
        if ret.status == EC.EJOYSDK_ERROR_CODES.RES_DOWNLOAD_MD5_MISMATCH then
          log("[cloud game] file md5 check mismatch")
          CSTAT.stat_action_fail("mini_request_file_md5_mismatch", url)
        end
        local message = ret.message or ""
        cb(false, ret.status, message)
      end
    end
    
    local recv_present = 0
    
    local function progress(_, _file, recv, total)
      local p = math.floor(recv / total * 100)
      if p ~= recv_present then
        recv_present = p
        if on_download_progress then
          on_download_progress(recv_present)
        end
      end
      on_download_received_bytes_changed(_file, recv, total)
    end
    
    E.HTTP.get(url, {
      file = temp_file,
      kps_limit = cloud_config.get_http_kps_limit() or -1,
      interval_limit = cloud_config.HttpIntervalLimit,
      progress = progress,
      checksum = file_md5
    }, down_cb)
  else
    local function down_cb_body(ret)
      if ret.status == 200 then
        log("[cloud game] finish down body " .. file .. " " .. ret.status)
        
        local f = io.open(temp_file, "w")
        f:write(ret.body)
        f:close()
        if not file_size or M.check_file_valid(temp_file, file_size) then
          os.rename(temp_file, M.download_folder .. file)
          cb(true)
        else
          log("[cloud game] request_file size error pc" .. file)
          cb(false, EC.DOWNLOAD_ERROR_CODES.DOWNFINISH_FILE_INVALID)
        end
      else
        cb(false, ret.status)
      end
    end
    
    E.HTTP.get(url, {}, down_cb_body)
  end
end

function M.init(download_folder)
  log("[cloud game] init download_dir " .. tostring(download_folder))
  M.download_folder = download_folder
  M.finish_flg_folder = M.get_parent_folder(M.download_folder)
  log("[cloud game] finish_flg_folder " .. M.finish_flg_folder)
  M.temp_folder = download_folder
  create_dir(M.download_folder)
  create_dir(M.temp_folder)
end

function M.register_download_speed_changed(listener)
  download_speed_change_listener = listener
end

function M.set_donwload_pause(is_pause)
  is_download_file_pause = is_pause
  if download_pause_listener then
    download_pause_listener(is_pause)
  end
  E.LOG.debug(TAG, "[cloud game] set_donwload_pause " .. tostring(is_pause))
end

function M.is_download_paused()
  return is_download_file_pause
end

function M.register_download_pause_listener(listener)
  download_pause_listener = listener
end

function M.down_file(url, file, ok_cb, fail_cb, file_size, file_md5, on_download_progress)
  local retry_cnt = 0
  local down_cb, down_file_wrap
  
  function down_file_wrap()
    if is_download_file_pause then
      ejoysdk.Timer.once(1, down_file_wrap)
      return
    end
    E.LOG.debug(TAG, "request_file:  begin:" .. tostring(url) .. ", is_pause:" .. tostring(is_download_file_pause))
    request_file(url, file, down_cb, file_size, file_md5, on_download_progress)
  end
  
  function down_cb(is_ok, ...)
    if is_ok then
      E.LOG.debug(TAG, "request_file:  end:" .. tostring(url))
      ok_cb(file)
    else
      retry_cnt = retry_cnt + 1
      if retry_cnt <= MAX_RETRY_CNT then
        E.Timer.once(RETRY_TIME_DELAY, function()
          log(string.format("[cloud game] down_file fail,retry cnt=%s file=%s", retry_cnt, file))
          down_file_wrap()
        end)
      else
        local code, msg = ...
        fail_cb(code, msg)
      end
    end
  end
  
  down_file_wrap()
end

function M.split_url(full_url)
  local temp = string.reverse(full_url)
  local _, i = string.find(temp, "/")
  local offset = string.len(full_url) - i + 1
  return string.sub(full_url, 1, offset), string.sub(full_url, offset + 1, string.len(full_url))
end

function M.get_parent_folder(path)
  if string.sub(path, string.len(path)) == "/" then
    path = string.sub(path, 1, string.len(path) - 1)
  end
  path = M.split_url(path)
  return path
end

function M.down_file_by_urls(urls, ok_cb, fail_cb)
  local _index
  
  local function get_next()
    local id, url = next(urls, _index)
    _index = id
    return url
  end
  
  local down_cfg_fun
  
  function down_cfg_fun(full_url)
    local url, file = M.split_url(full_url)
    E.LOG.debug(TAG, "[cloud game] down cfg from " .. tostring(url) .. tostring(file))
    E.LOG.debug(TAG, "[cloud game] down cfg from test " .. tostring(url) .. tostring(file))
    M.down_file(full_url, file, function()
      ok_cb(url, file)
    end, function()
      local next_url = get_next()
      if next_url then
        E.LOG.debug(TAG, "[cloud game] try other url " .. tostring(next_url))
        down_cfg_fun(next_url)
      else
        fail_cb("can't find file:" .. file)
      end
    end)
  end
  
  down_cfg_fun(get_next())
end

function M.set_finish_down_assets()
  local app_version_name = E.get_pkg_info().versions.app_version_name
  local state_info = {
    [M.STATE_KEY.STATE] = M.CLOUD_RES_STATE.FINISH,
    [M.STATE_KEY.VERSION_NAME] = app_version_name
  }
  E.LOG.debug(TAG, "save state info >> " .. tostring(state_info[M.STATE_KEY.STATE]))
  M.RES_STATE_CACHE:set(state_info)
end

function M.set_not_finish_down_assets()
  local app_version_name = E.get_pkg_info().versions.app_version_name
  local state_info = {
    [M.STATE_KEY.STATE] = M.CLOUD_RES_STATE.DOWNLOADING,
    [M.STATE_KEY.VERSION_NAME] = app_version_name
  }
  E.LOG.debug(TAG, "save state info >> " .. tostring(state_info[M.STATE_KEY.STATE]))
  M.RES_STATE_CACHE:set(state_info)
end

function M.remove_game_res_config_files()
  E.LOG.debug(TAG, "remove_game_res_config_files begin")
  local game_file_list_path = M.download_folder .. M.RES_FILE_LIST
  os.remove(game_file_list_path)
  remote_res_url_sp:set("")
end

function M.get_file_content(file_path)
  local rfile = io.open(file_path, "r")
  if rfile then
    local content = rfile:read("*all")
    rfile:close()
    local CJSON = require("ejoysdk_lua.ejoysdk_cjson")
    local cfg = CJSON.decode(content)
    if cfg then
      return cfg, content
    end
  end
  return nil
end

function M.check_game_res_config_files()
  local res_config_files = {}
  if M.is_file_exist(M.RES_FILE_LIST) then
    res_config_files.res_file_list = M.download_folder .. M.RES_FILE_LIST
    res_config_files.remote_res_url = remote_res_url_sp:get()
  else
    E.LOG.debug(TAG, "check_game_res_config_files not exists，clear all config files")
    M.remove_game_res_config_files()
  end
  return res_config_files
end

function M.get_backup_file_name(file_name)
  return file_name .. ".bak"
end

function M.backup_clear_game_res_config_files()
  E.LOG.debug(TAG, "backup_clear_game_res_config_files")
  local game_file_list_path = M.download_folder .. M.RES_FILE_LIST
  local game_file_list_path_bak = M.download_folder .. M.get_backup_file_name(M.RES_FILE_LIST)
  local origin_file_list = io.open(game_file_list_path, "r")
  if origin_file_list then
    os.remove(game_file_list_path_bak)
    local content = origin_file_list:read("*all")
    origin_file_list:close()
    local bak_file = io.open(game_file_list_path_bak, "w")
    bak_file:write(content)
    bak_file:close()
  end
  M.remove_game_res_config_files()
end

function M.current_assets_down_state()
  return assets_state_info or {}
end

function M.check_assets_down_state(cb)
  local state_info = M.RES_STATE_CACHE:get() or {}
  local cur_app_ver_name = E.get_pkg_info().versions.app_version_name
  if next(state_info) == nil then
    local finish_file = io.open(M.finish_flg_folder .. "__finish_down_asset_.flg", "r")
    finish_file = finish_file or io.open(M.download_folder .. "__finish_down_asset_.flg", "r")
    if finish_file then
      E.LOG.debug(TAG, "[cloud game] is_finish_down_assets")
      state_info[M.STATE_KEY.STATE] = M.CLOUD_RES_STATE.UPDATING
      state_info[M.STATE_KEY.VERSION_NAME] = cur_app_ver_name
      M.backup_clear_game_res_config_files()
      finish_file:close()
    else
      state_info[M.STATE_KEY.STATE] = M.CLOUD_RES_STATE.DOWNLOADING
      state_info[M.STATE_KEY.VERSION_NAME] = cur_app_ver_name
      M.backup_clear_game_res_config_files()
    end
  else
    local state = state_info.state
    local last_ver_name = state_info.ver_name
    E.LOG.debug(TAG, "read assets_down_state_file, state:" .. tostring(state) .. ", last_ver_name:" .. tostring(last_ver_name))
    E.LOG.debug(TAG, state_info)
    if last_ver_name ~= cur_app_ver_name then
      if state == M.CLOUD_RES_STATE.FINISH then
        state_info[M.STATE_KEY.STATE] = M.CLOUD_RES_STATE.UPDATING
        state_info[M.STATE_KEY.VERSION_NAME] = cur_app_ver_name
      elseif state == M.CLOUD_RES_STATE.UPDATING then
        state_info[M.STATE_KEY.STATE] = M.CLOUD_RES_STATE.UPDATING
        state_info[M.STATE_KEY.VERSION_NAME] = cur_app_ver_name
      elseif state == M.CLOUD_RES_STATE.DOWNLOADING then
        state_info[M.STATE_KEY.STATE] = M.CLOUD_RES_STATE.DOWNLOADING
        state_info[M.STATE_KEY.VERSION_NAME] = cur_app_ver_name
      else
        state_info[M.STATE_KEY.STATE] = M.CLOUD_RES_STATE.DOWNLOADING
        state_info[M.STATE_KEY.VERSION_NAME] = cur_app_ver_name
      end
      M.backup_clear_game_res_config_files()
    else
      E.LOG.debug(TAG, "not override install, do normal startup")
    end
  end
  E.LOG.debug(TAG, "state_info, after >> ")
  E.LOG.debug(TAG, state_info)
  M.RES_STATE_CACHE:set(state_info)
  assets_state_info = state_info
  if cb then
    cb(state_info)
  end
end

function M.check_assets_down_state_odr(cb)
  local state_info = {}
  local cur_app_ver_name = E.get_pkg_info().versions.app_version_name
  state_info[M.STATE_KEY.VERSION_NAME] = cur_app_ver_name
  local odr_config = cloud_config.ODRConfig or {}
  local tags = {}
  for _, tag_items in pairs(odr_config) do
    for _, tag in ipairs(tag_items) do
      table.insert(tags, tag[cloud_config.ODR_TAG_CONFIG_KEYS.NAME])
    end
  end
  local demand_res = require("ejoysdk_lua.odr.demand_res_manager")
  demand_res.check_res_available(tags, function(available)
    E.LOG.debug(TAG, "odr res state >> " .. tostring(available))
    if available then
      state_info[M.STATE_KEY.STATE] = M.CLOUD_RES_STATE.FINISH
    elseif M.check_odr_download_finish() then
      E.LOG.debug(TAG, "odr downloaded finish in the history")
      state_info[M.STATE_KEY.STATE] = M.CLOUD_RES_STATE.FINISH
    else
      state_info[M.STATE_KEY.STATE] = M.CLOUD_RES_STATE.DOWNLOADING
    end
    if cb then
      cb(state_info)
    end
  end)
end

function M.check_pkg_install_state(cb)
  local state_info = {}
  local cur_app_ver_name = E.get_pkg_info().versions.app_version_name
  state_info[M.STATE_KEY.VERSION_NAME] = cur_app_ver_name
  local is_install = CIPM.is_pkg_installed()
  if is_install then
    state_info[M.STATE_KEY.STATE] = M.CLOUD_RES_STATE.FINISH
  else
    state_info[M.STATE_KEY.STATE] = M.CLOUD_RES_STATE.DOWNLOADING
  end
  if cb then
    cb(state_info)
  end
end

M.ODR_DOWNLOAD_STATE = E.LazyKeyStore:New("CLOUD_GAME_ODR_DOWNLOAD_STATE", false, true, false)
M.ODR_DOWNLOAD_STATE_KEY = "cloud_game_odr_download_state"

function M.save_odr_download_finish()
  E.LOG.debug(TAG, "save cloud odr res download finish")
  local state_info = {
    [M.ODR_DOWNLOAD_STATE_KEY] = true
  }
  M.ODR_DOWNLOAD_STATE:set(state_info)
end

function M.check_odr_download_finish()
  local state_info = M.ODR_DOWNLOAD_STATE:get()
  if state_info then
    local state = state_info[M.ODR_DOWNLOAD_STATE_KEY]
    if state then
      return true
    end
  end
  return false
end

function M.is_file_exist(file)
  if not file then
    return
  end
  if not M.download_folder then
    return false
  end
  local f = io.open(M.download_folder .. file, "r")
  if f then
    f:close()
    return true
  end
end

function M.read_file_content(file)
  local f = io.open(M.download_folder .. file, "r")
  if f then
    local content = f:read("*all")
    f:close()
    return content
  end
end

function M.create_empty_file(file)
  local f = io.open(M.download_folder .. file, "w")
  f:close()
end

return M
