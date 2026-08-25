local CONFIG = require("ejoysdk_lua.ejoysdk_config")
local M
if _ejoysdk.os and _ejoysdk.os() == "android" then
  M = require("ejoysdk_lua.ejoysdk_android")
  CONFIG.set_config("os", "android")
elseif _ejoysdk.os and _ejoysdk.os() == "harmonyos" then
  M = require("ejoysdk_lua.ejoysdk_harmonyos")
  CONFIG.set_config("os", "harmonyos")
elseif _ejoysdk.os and _ejoysdk.os() == "windows" then
  M = require("ejoysdk_lua.ejoysdk_windows")
  CONFIG.set_config("os", "windows")
elseif _ejoysdk.os and _ejoysdk.os() == "weixin" then
  M = require("ejoysdk_lua.ejoysdk_weixin")
  CONFIG.set_config("os", "weixin")
elseif _ejoysdk.os and _ejoysdk.os() == "douyin" then
  M = require("ejoysdk_lua.ejoysdk_douyin")
  CONFIG.set_config("os", "douyin")
else
  M = require("ejoysdk_lua.ejoysdk_ios")
  CONFIG.set_config("os", "ios")
end
M.UNISDK_EVENT_ID = {
  EVT_LOGIN = 1,
  EVT_LOGOUT = 2,
  EVT_PAY = 3,
  EVT_EVENT = 4,
  EVT_INIT = 5,
  EVT_EXIT = 6
}
local JSON = require("ejoysdk_lua.ejoysdk_json")
local Class = require("ejoysdk_lua.ejoysdk_class")
local COMPAT = require("ejoysdk_lua.compat.ejoysdk_compat")
local BitUtil = COMPAT.bitutil
local E_UTILS = require("ejoysdk_lua.ejoysdk_utils")
local ELOG = require("ejoysdk_lua.ejoysdk_log")
local UIM = require("ejoysdk_lua.user_info_manager")
local LANG = require("ejoysdk_lua.lang.util")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local ECC = require("ejoysdk_lua.ejoysdk_constants")
local Uri = require("ejoysdk_lua.libs.uri")
local UUID = require("ejoysdk_lua.ejoysdk_uuid")
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "ejoysdk"
local ejoysdk_log = _ejoysdk.log

local function log_with_tag(s)
  ejoysdk_log("[l]" .. tostring(s))
end

_ejoysdk.log = log_with_tag
if _ejoysdk.bin_version then
  CONFIG.set_config("bin_version", _ejoysdk.bin_version())
else
  CONFIG.set_config("bin_version", 1)
end
M.CONFIG = CONFIG
local HTTP = M.HTTP
M.Permission = M.Permission
M.Sysinfo = M.Sysinfo

local function file_delegate()
  do return require end
  return require, "ejoysdk_lua.libs.file"
end

local function path_delegate()
  do return require end
  return require, "ejoysdk_lua.libs.path"
end

local function ejoy_http_delegate()
  do return require end
  return require, "ejoysdk_lua.ejoysdk_http"
end

local Path = {}
M.Path = Path

function Path.join(base_path, ...)
  do return path_delegate().join, base_path, ... end
  return path_delegate().join, base_path, ...
end

function Path.uniform_sep(path)
  do return path_delegate().uniform_sep end
  return path_delegate().uniform_sep, path
end

function Path.trim_end_separator(path)
  do return path_delegate().trim_end_separator end
  return path_delegate().trim_end_separator, path
end

function Path.trim_separators(path)
  do return path_delegate().trim_separators end
  return path_delegate().trim_separators, path
end

function Path.trim_begin_separator(path)
  do return path_delegate().trim_begin_separator end
  return path_delegate().trim_begin_separator, path
end

function Path.get_ext_file_dir()
  do return end
  return path_delegate().get_ext_file_dir, nil
end

function Path.parent_dir(path)
  do return path_delegate().parent_dir end
  return path_delegate().parent_dir, path
end

function Path.ensure_parent_dir(path)
  do return path_delegate().ensure_parent_dir end
  return path_delegate().ensure_parent_dir, path
end

function Path.ensure_dir(dir)
  do return path_delegate().ensure_dir end
  return path_delegate().ensure_dir, dir
end

local File = M.File

function File.rename(src, dst, opts)
  do return file_delegate().rename, src, dst end
  return file_delegate().rename, src, dst, opts
end

function File.rename_fullpath(src_full_path, dst_full_path)
  do return file_delegate().rename_fullpath, src_full_path end
  return file_delegate().rename_fullpath, src_full_path, dst_full_path
end

function File.batch_rename(map, cb, opts)
  file_delegate().batch_rename(map, cb, opts)
end

function File.copy(src, dst, opts)
  do return file_delegate().copy, src, dst end
  return file_delegate().copy, src, dst, opts
end

function File.copy_fullpath(src, dst, opts)
  do return file_delegate().copy_fullpath, src, dst end
  return file_delegate().copy_fullpath, src, dst, opts
end

function File.batch_copy(map, cb, opts)
  file_delegate().batch_copy(map, cb, opts)
end

function File.remove(path)
  do return file_delegate().remove end
  return file_delegate().remove, path
end

function M.remove_full_path(path)
  do return File.remove_fullpath end
  return File.remove_fullpath, path
end

function File.remove_fullpath(path)
  do return file_delegate().remove_fullpath end
  return file_delegate().remove_fullpath, path
end

function File.batch_remove(list, cb, opts)
  file_delegate().batch_remove(list, cb, opts)
end

function File.exists(path, is_full_path)
  do return file_delegate().exists, path end
  return file_delegate().exists, path, is_full_path
end

function File.exists_fullpath(path)
  do return file_delegate().exists_fullpath end
  return file_delegate().exists_fullpath, path
end

function File.make_dirs(path)
  do return file_delegate().make_dirs end
  return file_delegate().make_dirs, path
end

function File.md5(file_path, is_full_path)
  do return file_delegate().md5, file_path end
  return file_delegate().md5, file_path, is_full_path
end

function File.md5_fullpath(file_path)
  do return file_delegate().md5_fullpath end
  return file_delegate().md5_fullpath, file_path
end

function File.batch_md5(file_list, cb, is_full_path, base_path)
  file_delegate().batch_md5(file_list, cb, is_full_path, base_path)
end

function File.batch_info(file_list, cb, opts)
  file_delegate().batch_info(file_list, cb, opts)
end

function File.is_directory(file_path, is_full_path)
  do return file_delegate().is_directory, file_path end
  return file_delegate().is_directory, file_path, is_full_path
end

function File.is_directory_fullpath(file_path)
  do return file_delegate().is_directory_fullpath end
  return file_delegate().is_directory_fullpath, file_path
end

function File.list_directory(dir_path, recursive, is_full_path, cb)
  file_delegate().list_directory(dir_path, recursive, is_full_path, cb)
end

function File.list_bundle(bundle_dir_path, recursive, cb)
  file_delegate().list_bundle(bundle_dir_path, recursive, cb)
end

M.META_CONFIG_KEY = {
  GAME_ID = "game_id",
  OVERSEAS = "overseas",
  PUBLISH_AREA = "publish_area",
  GAME_LANG = "game_lang",
  DISTRICT = "district",
  PRODUCT_CODE = "product_code",
  SERVER_DOMAIN = "server_domain",
  PARENT_PKG_ID = "parent_pkg_id",
  PARENT_PKG_RECORD_ID = "parent_pkg_record_id",
  APP_REVIEW_VERSION = "app_review_version",
  APP_VERSION_CODE = "app_version_code"
}
local meta_values_cache = {}
do
  local function pkg_fill_params_function(user_info)
    local pkg_info = M.get_pkg_info()
    
    local multi_regions_enabled = M.CONFIG.get_config(M.CONFIG.KEY.MULTI_REGIONS_ENABLED)
    if multi_regions_enabled then
      pkg_info.accountCh = "998236"
    else
      pkg_info.accountCh = user_info.ds_channel_id or user_info.platform or ""
    end
  end
  
  ET.subscribe(ET.gangplank.ACQUIRE, function(user_info)
    pkg_fill_params_function(user_info)
    M.log("acquire success---")
    M.log(M.get_pkg_info())
  end)
  ET.subscribe(ET.gangplank.SCAN_LOGIN, function(user_info)
    pkg_fill_params_function(user_info)
    M.log("scan_login success---")
    M.log(M.get_pkg_info())
  end)
  ET.subscribe(ET.gangplank.LOGOUT, function()
    local pkg_info = M.get_pkg_info()
    pkg_info.accountCh = ""
  end)
end

local function split_string(str, sep_opt)
  local sep, fields = sep_opt or " ", {}
  local pattern = string.format("([^%s]+)", sep)
  string.gsub(str, pattern, function(c)
    fields[#fields + 1] = c
  end)
  return fields
end

local function insert_string(src, opt, pos)
  src = src or ""
  opt = opt or ""
  if not pos or pos <= 0 or pos > #src then
    pos = #src + 1
  end
  return src:sub(1, pos - 1) .. opt .. src:sub(pos)
end

local function start_with(str, start)
  return str:sub(1, #start) == start
end

local function end_with(str, suffix)
  if not str or not suffix then
    return false
  end
  return str:sub(-string.len(suffix)) == suffix
end

local function trim_start(str, start)
  if type(str) == "string" and type(start) == "string" and #str >= #start and start_with(str, start) then
    do return str.sub, str end
    return str.sub, str, #start + 1
  end
  return str
end

local function trim_end(str, end_str)
  if not end_str or not str then
    return str
  end
  local result_str = str
  if end_with(str, end_str) then
    result_str = str:sub(1, -string.len(end_str) - 1)
  end
  return result_str
end

local function trim(s)
  if type(s) == "string" then
    return (s:gsub("^%s*(.-)%s*$", "%1"))
  else
    return s
  end
end

local function trim_chars(s, ch)
  if nil == ch then
    return s
  end
  if type(s) == "string" then
    if "." == ch or "%" == ch then
      ch = "%" .. ch
    end
    local pattern = "^" .. tostring(ch) .. "*(.-)" .. tostring(ch) .. "*$"
    return (s:gsub(pattern, "%1"))
  else
    return s
  end
end

local function table_size(data)
  local count = 0
  for _, _ in pairs(data) do
    count = count + 1
  end
  return count
end

HTTP.Header = {
  New = function(headers)
    do return ejoy_http_delegate().Header.New end
    return ejoy_http_delegate().Header.New, headers
  end
}

function HTTP.check_and_update_headers(headers)
  do return ejoy_http_delegate().check_and_update_headers end
  return ejoy_http_delegate().check_and_update_headers, headers
end

function HTTP.escape(str)
  do return Uri.escape end
  return Uri.escape, str
end

function HTTP.urlencode(query)
  do return Uri.encode_query_with_array_separate end
  return Uri.encode_query_with_array_separate, query
end

function HTTP.urlencode2(query)
  do return Uri.encode_query_with_array_concat end
  return Uri.encode_query_with_array_concat, query
end

function HTTP.encode_uri(uri)
  do return Uri.encode_uri end
  return Uri.encode_uri, uri
end

function HTTP.decode_uri(uri)
  do return Uri.decode_uri end
  return Uri.decode_uri, uri
end

function HTTP.parse_query(str, sep)
  do return Uri.parse_query, str end
  return Uri.parse_query, str, sep
end

function HTTP.parse(url)
  do return Uri.parse end
  return Uri.parse, url
end

function HTTP.url_query(url, query)
  do return Uri.url_query, url end
  return Uri.url_query, url, query
end

function HTTP.uri_join(...)
  do return Uri.uri_join, ... end
  return Uri.uri_join, ...
end

HTTP.FormData = {
  New = function()
    do return end
    return ejoy_http_delegate().FormData.New, nil
  end
}
HTTP.CT_URLENCODED = ECC.HTTP_CONTENT_TYPE.CT_URLENCODED
HTTP.CT_JSON = ECC.HTTP_CONTENT_TYPE.CT_JSON
HTTP.CT_FORMDATA = ECC.HTTP_CONTENT_TYPE.CT_FORMDATA

function HTTP.smart_content(body, content_type)
  do return ejoy_http_delegate().body_tostring, body end
  return ejoy_http_delegate().body_tostring, body, content_type
end

function HTTP.opentracing_enable()
  do return end
  return ejoy_http_delegate().opentracing_enable, nil
end

M.has_apus_vendor = HTTP.opentracing_enable

function HTTP.set_http_retry_list(params)
  ejoy_http_delegate().set_http_retry_list(params)
end

function HTTP.get(url, params, cb, opts)
  ejoy_http_delegate().get(url, params, cb, opts)
end

function HTTP.post(url, params, content_type, body, cb, opts)
  ejoy_http_delegate().post(url, params, content_type, body, cb, opts)
end

function HTTP.stop(_task_id_arr, params, cb)
  ejoy_http_delegate().stop(_task_id_arr, params, cb)
end

HTTP.NativeBuildFormData = {
  New = function()
    do return end
    return ejoy_http_delegate().NativeBuildFormData.New, nil
  end
}
M.NATIVE_SUPPORT_FUNCTION_NAMES = ECC.NATIVE_SUPPORT_FUNCTION_NAMES
M.Utils = {}
M.Utils.split_string = split_string
M.Utils.start_with = start_with
M.Utils.end_with = end_with
M.Utils.trim_start = trim_start
M.Utils.trim_end = trim_end
M.Utils.string_insert = insert_string
M.Utils.url_append_params = Uri.append_param
M.Utils.url_clipping = Uri.get_location
M.Utils.trim = trim
M.Utils.trim_chars = trim_chars
M.Utils.table_size = table_size

function M.Sysinfo.os()
  do return end
  return _ejoysdk.os, nil
end

function M.Sysinfo.bin_version()
  if _ejoysdk.bin_version then
    do return end
    return _ejoysdk.bin_version, nil
  else
    return "1.0.0"
  end
end

function M.Sysinfo.language_and_script()
  local lang = M.Sysinfo.language() or ""
  local script = M.Sysinfo.language_script()
  if not script or 0 == #script then
    script = E_UTILS.lang_util.get_script()
  end
  local lang_and_script
  if script and #script > 0 then
    lang_and_script = lang .. "-" .. script
  else
    lang_and_script = lang
  end
  do return lang_and_script.lower end
  return lang_and_script.lower, lang_and_script, script
end

local LazyKeyStore = Class:Inherit("LazyKeyStore")

function LazyKeyStore:_init(key, no_auto_save, is_json, permanent)
  self.is_json = is_json
  self.key = key
  self.value = nil
  self.auto_save = not no_auto_save
  if nil == permanent or true == permanent then
    self.keystore = M.KeyStore
  else
    self.keystore = M.UnRecoverKeyStore
  end
end

function LazyKeyStore:set(value)
  self.value = value
  if self.auto_save then
    self:save()
  end
end

function LazyKeyStore:save()
  local value = self.value
  if self.is_json then
    value = JSON.encode(value)
  end
  self.keystore.set(self.key, value)
end

function LazyKeyStore:get()
  if not self.value then
    self.value = self.keystore.get(self.key)
    if self.is_json and self.value then
      self.value = JSON.decode(self.value)
    end
  end
  return self.value
end

function LazyKeyStore:delete()
  self.value = nil
  self.keystore.delete(self.key)
end

M.LazyKeyStore = LazyKeyStore
local SPKeyStore = Class:Inherit("SPKeyStore")

function SPKeyStore:_init(name, key)
  self.name = name
  self.key = key
  self.keystore = M.SPRawKeyStore
end

function SPKeyStore:set(value, async_apply)
  do return self.keystore.set, self.name, self.key, value end
  return self.keystore.set, self.name, self.key, value, async_apply
end

function SPKeyStore:get()
  do return self.keystore.get, self.name end
  return self.keystore.get, self.name, self.key
end

function SPKeyStore:delete()
  self.keystore.delete(self.name, self.key)
end

function SPKeyStore:is_empty()
  local value = self:get()
  if not value or 0 == #value then
    return true
  else
    return false
  end
end

M.SPKeyStore = SPKeyStore

function M.get_env_info()
  local ejoysdk_stat = require("ejoysdk_lua.ejoysdk_stat")
  do return end
  return ejoysdk_stat.env_info
end

function M.get_pkg_info()
  do return end
  return UIM.get_pkg_info, nil
end

function M.async_get_pkg_info(cb)
  local result = M.get_pkg_info()
  if cb then
    cb(result)
  end
end

local function _channel_encode(channel)
  local int_arr = {}
  local channel_len = string.len(channel)
  for i = 1, channel_len do
    table.insert(int_arr, i, channel:byte(i))
  end
  local result = ""
  for i = 1, #int_arr do
    local val = int_arr[i]
    local hex_val = string.format("0x%02x", val)
    local num_hex_var = tonumber(hex_val)
    local revert_result = BitUtil.bxor(num_hex_var, 255)
    result = result .. string.format("%x", revert_result)
  end
  ejoysdk_log("channel encode origin:" .. channel .. ", result:" .. result)
  return result
end

local function _channel_decode(encode_channel)
  if nil == encode_channel or "" == encode_channel then
    ejoysdk_log("invalid encode channel, it's empty")
    return ""
  end
  local len = string.len(encode_channel)
  if 0 ~= len % 2 then
    ejoysdk_log("invalid encode channel length")
    return ""
  end
  local decode_result = ""
  for i = 1, len, 2 do
    local hex_revert_char = "0x" .. string.sub(encode_channel, i, i + 1)
    local num_hex_char = tonumber(hex_revert_char)
    local number_char = string.char(BitUtil.bxor(num_hex_char, 255))
    decode_result = decode_result .. number_char
  end
  ejoysdk_log("channel decode origin:" .. encode_channel .. ", result:" .. decode_result)
  return decode_result
end

local channel

function M.get_channel()
  local meta_data = M.CONFIG.get_config("unisdk_meta")
  if nil == meta_data then
    local _load = require("ejoysdk_lua.vendors.unisdk")
    meta_data = M.CONFIG.get_config("unisdk_meta")
  end
  if not channel then
    channel = _channel_decode(meta_data.channel)
  end
  if not channel or "" == channel then
    local multi_regions_enabled = M.CONFIG.get_config(M.CONFIG.KEY.MULTI_REGIONS_ENABLED)
    if multi_regions_enabled then
      channel = "998236"
    elseif _ejoysdk.os() == "windows" and meta_data.channel_id then
      channel = tostring(meta_data.channel_id)
    elseif M.Sysinfo.ds_channel_id then
      channel = M.Sysinfo.ds_channel_id()
    end
  end
  return channel
end

function M.reset_channel()
  channel = nil
end

function M.update_channel(accountCh)
  channel = accountCh
end

local apk_build_seq

function M.get_apk_build_seq()
  if not apk_build_seq then
    local meta_data = M.CONFIG.get_config("unisdk_meta")
    if nil ~= meta_data then
      apk_build_seq = meta_data.apk_build_seq
    else
      M.LOG.debug(TAG, "meta_data is nil")
    end
  end
  return apk_build_seq or ""
end

local ptid

function M.get_ptid()
  if not ptid then
    local UNI = require("ejoysdk_lua.vendors.unisdk")
    local sdk_info = UNI.get_sdk_info("JF") or {}
    local info_meta = sdk_info.meta or {}
    local jf_ptid = info_meta.LOGCOLLECT_JF_PTID
    if jf_ptid and "" ~= jf_ptid then
      M.LOG.debug(TAG, "get_ptid from jf sdk:" .. tostring(jf_ptid))
      ptid = jf_ptid
    else
      local meta_data = M.CONFIG.get_config("unisdk_meta")
      if nil ~= meta_data then
        ptid = meta_data.ptid
        M.LOG.debug(TAG, "get_ptid from unisdk_meta:" .. tostring(ptid))
      else
        M.LOG.debug(TAG, "meta_data is nil")
      end
    end
  end
  return ptid or ""
end

function M.get_meta_config(key)
  if nil == key or "" == key then
    M.LOG.debug(TAG, "get_meta_config failed for key is nil")
    return nil
  end
  local cache_value = meta_values_cache[key]
  if nil ~= cache_value then
    return cache_value
  end
  local meta_data = M.CONFIG.get_config("unisdk_meta")
  local value = meta_data[key]
  if nil ~= value then
    meta_data[key] = value
    meta_values_cache[key] = value
  end
  return value
end

function M.get_game_id()
  local game_id = M.get_meta_config(M.META_CONFIG_KEY.GAME_ID)
  if nil ~= game_id then
    M.log("get_game_id:" .. game_id)
  else
    ejoysdk_log("get_game_id return nil!")
  end
  return game_id
end

function M.get_parent_pkg_id()
  local parent_pkg_id = M.get_meta_config(M.META_CONFIG_KEY.PARENT_PKG_ID)
  if nil ~= parent_pkg_id then
    ejoysdk_log("get_parent_pkg_id:" .. parent_pkg_id)
  else
    ejoysdk_log("get_parent_pkg_id return nil!")
  end
  return parent_pkg_id
end

function M.get_parent_pkg_record_id()
  local parent_pkg_record_id = M.get_meta_config(M.META_CONFIG_KEY.PARENT_PKG_RECORD_ID)
  if nil ~= parent_pkg_record_id then
    ejoysdk_log("get_parent_pkg_record_id:" .. parent_pkg_record_id)
  else
    ejoysdk_log("get_parent_pkg_record_id return nil!")
  end
  return parent_pkg_record_id
end

local sdk_version_name_cache = {}

function M.get_sdk_version_name(sdk_name)
  if nil == sdk_version_name_cache[sdk_name] then
    sdk_version_name_cache[sdk_name] = M.Sdkinfo.getSDKVersionName(sdk_name)
  end
  return sdk_version_name_cache[sdk_name]
end

local cn_channel_version

function M.get_cn_channel_version()
  if not cn_channel_version then
    cn_channel_version = tostring(M.Sysinfo.manifest_meta_data("string", "cn.gosdk.channelVer"))
  end
  ejoysdk_log("cn_channel_version: " .. tostring(cn_channel_version))
  return cn_channel_version
end

local display_sdk_infos

function M.get_display_sdk_infos()
  if not display_sdk_infos then
    local uni = require("ejoysdk_lua.vendors.unisdk")
    display_sdk_infos = uni.get_sdk_infos() or {}
  end
  do return E_UTILS.deepcopy end
  return E_UTILS.deepcopy, display_sdk_infos
end

local time_diff = 0

function M.set_time_diff(diff)
  _ejoysdk.log("update time diff: " .. tostring(diff))
  diff = diff - diff % 1
  time_diff = diff
end

function M.time()
  return os.time() + time_diff
end

local sync_server_ms = 0
local sync_clock = 0
local _flag_sync_sever_time = false

function M.set_server_ms(server_ms)
  sync_server_ms = server_ms
  if _ejoysdk.os() == "windows" then
    local active_time_clock = os.clock()
    if active_time_clock > 0 then
      sync_clock = active_time_clock
    end
  else
    sync_clock = M.system_clock()
  end
  _flag_sync_sever_time = true
end

function M.did_sync_sever_time()
  return _flag_sync_sever_time
end

function M.time_ms()
  if 0 == sync_server_ms or 0 == sync_clock then
    return 0
  end
  if _ejoysdk.os() == "windows" then
    local active_time_clock = os.clock()
    if active_time_clock > 0 and sync_clock > 0 then
      do return math.floor end
      return math.floor, sync_server_ms + (active_time_clock - sync_clock) * 1000, (active_time_clock - sync_clock) * 1000
    else
      return 0
    end
  end
  do return math.floor end
  return math.floor, sync_server_ms + M.system_clock() - sync_clock, sync_clock, (active_time_clock - sync_clock) * 1000
end

function M.system_clock()
  return os.time() * 1000
end

function M.system_ms()
  if _ejoysdk.system_ms then
    do return math.floor, _ejoysdk.system_ms() end
    return math.floor, _ejoysdk.system_ms()
  else
    return os.time() * 1000
  end
end

local seed = M.system_ms()
UUID.randomseed(seed)
M.LOG = ELOG.LOG
M.LOG_LEVEL = ELOG.LOG_LEVEL
M.LOG_STYLE = ELOG.LOG_STYLE
M.open_log = ELOG.open_log
M.is_log_open = ELOG.is_log_open
M.set_log_level = ELOG.set_log_level
M.get_log_level = ELOG.get_log_level
M.open_log_block = ELOG.open_log_block
M.is_block_tag = ELOG.is_block_tag
M.add_block_tags = ELOG.add_block_tags
M.del_block_tags = ELOG.del_block_tags
M.get_block_tags = ELOG.get_block_tags
M.open_log_with_config = ELOG.open_log_with_config
M.open_log_from_cc = ELOG.open_log_from_cc
M.set_white_modules = ELOG.set_white_modules
M.get_white_modules = ELOG.get_white_modules
M.set_log_length_limit = ELOG.set_log_length_limit
M.set_log_max_length = ELOG.set_log_max_length
M.log = ELOG.log
M.log_traceback = ELOG.log_traceback
if "ios" == _ejoysdk.os() then
  if _ejoysdk.system_clock2 then
    M.system_clock = _ejoysdk.system_clock2
  end
elseif _ejoysdk.system_clock then
  M.system_clock = _ejoysdk.system_clock
end

function M.open_webview(url, hosts, params, screen_orientation, on_js_callback, on_close_callback)
  M.LOG.debug(TAG, "open_webview, url:" .. (url or "nil"))
  local WEB = require("ejoysdk_lua.ejoysdk_web")
  WEB.open_webview(url, hosts, params, screen_orientation, on_js_callback, on_close_callback)
end

function M.open_webview_with_options(url, hosts, params, options, on_js_callback, on_close_callback)
  M.LOG.debug(TAG, "open_webview, url:" .. (url or "nil"))
  local WEB = require("ejoysdk_lua.ejoysdk_web")
  WEB.open_webview_with_options(url, hosts, params, options, on_js_callback, on_close_callback)
end

function M.capture_webview(callback)
  local WEB = require("ejoysdk_lua.ejoysdk_web")
  WEB.capture_webview(callback)
end

function M.loadstring(lua_script)
  if lua_script and "" ~= lua_script then
    M.log("doscript: " .. lua_script)
    local func, syntaxError = load(lua_script, "ejoysdk.loadstring", "bt")
    if func then
      local status, err = pcall(func)
      if not status then
        M.LOG.debug(TAG, "run script status: " .. tostring(status) .. ", err: " .. (err or ""))
      end
    else
      M.LOG.debug(TAG, "loadstring fail: " .. (syntaxError or "nil"))
    end
  end
end

function M.kill_game_process()
  local crash_sdk = require("ejoysdk_lua.vendors.crashsdk")
  crash_sdk.exit()
  M.kill_app()
end

function M.open_app(package_name)
  M.log("open_app received:" .. tostring(package_name))
  do return M.Sysinfo.open_app end
  return M.Sysinfo.open_app, package_name, tostring(package_name), package_name
end

function M.Permission.permission_default_description(permission_list)
  local default_desc = M.Permission.get_default_desc()
  local title = ""
  local desc = ""
  local i = 1
  local util = require("ejoysdk_lua.ejoysdk_utils")
  local length = util.tablelength(permission_list)
  for p, d in pairs(permission_list) do
    local p_info = d
    if not p_info or not next(p_info) then
      p_info = default_desc[p or ""]
    end
    if p_info then
      if title and #title > 0 then
        title = title .. "、"
      end
      title = title .. (p_info[1] or "")
      if p_info[2] and "" ~= p_info[2] then
        if length > 1 then
          desc = desc .. i .. ". "
        end
        desc = desc .. (p_info[2] or "") .. "\n"
        i = i + 1
      end
    end
  end
  return title, desc
end

function M.Permission.get_default_desc()
  if _ejoysdk.os then
    local os = _ejoysdk.os()
    local default_lang = "zh-hans"
    local langKey = M.CONFIG.get_config("lang"):lower() or ""
    local succ, desc_consts = pcall(function()
      do return require end
      return require, "ejoysdk_lua.consts.permissions." .. langKey, langKey
    end)
    if not succ or not desc_consts then
      local area_lang = require("ejoysdk_lua.lang.area_default_lang")
      local publish_area = M.CONFIG.get_config(M.CONFIG.KEY.PUBLISH_AREA) or ""
      local area_lang_key = area_lang[publish_area] or ""
      succ, desc_consts = pcall(function()
        do return require end
        return require, "ejoysdk_lua.consts.permissions." .. area_lang_key, area_lang_key
      end)
    end
    desc_consts = succ and desc_consts or require("ejoysdk_lua.consts.permissions." .. default_lang)
    return desc_consts[os or ""]
  end
  return {}
end

function M.Permission.get_desc(permission)
  if not permission or "" == permission then
    return {}
  end
  local permission_list = M.Permission.get_default_desc()
  if permission_list then
    return permission_list[permission] or {}
  end
  return {}
end

function M.Permission.async_get_desc(permission, cb)
  if cb then
    cb(M.Permission.get_desc(permission))
  end
end

function M.Permission.setting_dialog(title, options)
  options = options or {}
  local permission_list = options.permissions
  local permission_size = permission_list and table_size(permission_list) or 0
  local default_desc = M.Permission.get_default_desc()
  if permission_size > 0 then
    for k, v in pairs(permission_list) do
      if k and (not v or next(v) == nil) and default_desc[k] then
        permission_list[k] = default_desc[k]
      end
    end
  elseif permission_size <= 0 then
    permission_list = {}
    local requested_permissions = M.Permission.get_requested_permissions()
    if requested_permissions and requested_permissions.value and #requested_permissions.value > 0 then
      for _, req_permission in pairs(requested_permissions.value) do
        permission_list[req_permission] = default_desc[req_permission]
      end
    else
      permission_list = default_desc
    end
  end
  local category_list = {}
  for req_permission, desc_array in pairs(permission_list) do
    if desc_array and #desc_array >= 2 then
      local category = desc_array[1]
      local description = desc_array[2]
      local permission_info = category_list[category or ""] or {}
      local desc = permission_info.desc
      if desc and "" ~= desc then
        desc = desc .. "\n"
      end
      permission_info.desc = (desc or "") .. description
      permission_info.category = category
      permission_info.permissions = permission_info.permissions or {}
      table.insert(permission_info.permissions, req_permission)
      category_list[category] = permission_info
    end
  end
  permission_list = {}
  for _, v in pairs(category_list) do
    table.insert(permission_list, v)
  end
  options.permissions = permission_list
  options.style = "setting"
  options.text = {
    authorized = LANG.getString("has_authorized", "已授权"),
    unauthorized = LANG.getString("to_settings_page", "前往设置>")
  }
  M.Modal.open(title, options)
end

function M.Permission.check_permission_list_v2(permissions, cb)
  local grant_ret = true
  local psize = permissions and #permissions or 0
  if 0 == psize then
    M.LOG.debug(TAG, "check_permission_list_v2 succ with size 0")
    cb(true)
    return
  end
  local p_index = 1
  local check_permission_cb
  local reject_permissions = {}
  local reject_resps = {}
  local current_check_permission
  
  function check_permission_cb(ret, resp)
    _ejoysdk.log("check_permission_v2 result:" .. tostring(ret) .. ", p_index:" .. tostring(p_index) .. ", size：" .. tostring(psize) .. ", permission:" .. tostring(current_check_permission))
    p_index = p_index + 1
    grant_ret = grant_ret and ret
    if not ret then
      reject_resps[current_check_permission] = resp
      table.insert(reject_permissions, current_check_permission)
    end
    if p_index > psize then
      _ejoysdk.log("check_permission_v2 return:" .. tostring(grant_ret) .. ", p_index:" .. tostring(p_index) .. ", size：" .. tostring(psize))
      cb(grant_ret, reject_permissions, reject_resps)
    else
      current_check_permission = permissions[p_index]
      M.Permission.check_permission_v2(current_check_permission, check_permission_cb)
    end
  end
  
  current_check_permission = permissions[p_index]
  M.Permission.check_permission_v2(current_check_permission, check_permission_cb)
end

local LAST_APP_VERSION_NAME = M.LazyKeyStore:New("EJOY_LAST_APP_VERSION_NAME", false, false, false)
local LAST_APP_VERSION_CODE = M.LazyKeyStore:New("EJOY_LAST_APP_VERSION_CODE", false, false, false)
local is_override_install

function M.is_override_install_startup()
  if nil ~= is_override_install then
    _ejoysdk.log(TAG .. "#is_override_install_startup cached: " .. tostring(is_override_install))
    return is_override_install
  end
  local app_version_name = M.Sysinfo.app_version_name()
  local app_version_code = M.Sysinfo.app_version_code()
  local last_app_version_name = LAST_APP_VERSION_NAME:get()
  local last_app_version_code = LAST_APP_VERSION_CODE:get()
  LAST_APP_VERSION_NAME:set(app_version_name)
  LAST_APP_VERSION_CODE:set(app_version_code)
  _ejoysdk.log(TAG .. "#is_override_install_startup an:" .. tostring(app_version_name) .. ", ac:" .. tostring(app_version_code) .. ", lan:" .. tostring(last_app_version_name) .. ", lac:" .. tostring(last_app_version_code))
  if last_app_version_name ~= app_version_name then
    _ejoysdk.log(TAG .. "#is_override_install result true, last_app_version_name:" .. tostring(last_app_version_name) .. ", cur app_version_name:" .. tostring(app_version_name))
    is_override_install = true
  else
    _ejoysdk.log(TAG .. "#app_version_name is same")
    if nil ~= last_app_version_code and tostring(last_app_version_code) ~= tostring(app_version_code) then
      _ejoysdk.log(TAG .. "#is_override_install result true, last_app_version_code:" .. tostring(last_app_version_code) .. ", cur app_version_code:" .. tostring(app_version_code))
      is_override_install = true
    else
      is_override_install = false
    end
  end
  _ejoysdk.log(TAG .. "#is_override_install_startup: " .. tostring(is_override_install))
  return is_override_install
end

local ej_scan_pkg

function M.is_scan_pkg()
  if nil == ej_scan_pkg then
    ej_scan_pkg = CONFIG.has_vendor_config("EJOY_SCAN") or false
  end
  return ej_scan_pkg
end

local SDK_URL_OPEN_DATAS

function M.get_url_data_keystore()
  if nil == SDK_URL_OPEN_DATAS then
    SDK_URL_OPEN_DATAS = M.LazyKeyStore:New("SDK_URL_OPEN_DATAS", false, true, false)
  end
  return SDK_URL_OPEN_DATAS
end

local PRE_ORDER_ITEMS = M.LazyKeyStore:New("EJOY_PRE_ORDER_ITEMS", false, true, false)

function M.get_pre_order_status(cb)
  cb = cb or function()
  end
  
  local function request_pre_order_status(request_data, cb2)
    local USER = require("ejoysdk_lua.user_center.usercenter_api")
    local items = request_data.items
    if request_data.type == "json" then
      items = request_data.origin_items
    end
    USER.get_pre_order_status(request_data.platform, request_data.type, items, function(succ2, ...)
      if true == succ2 then
        local data = (...)
        cb2(true, data or {})
      else
        cb2(false)
      end
    end)
  end
  
  local save_items = PRE_ORDER_ITEMS:get()
  if save_items and next(save_items) then
    request_pre_order_status(save_items, cb)
  else
    M.get_pre_order_items(function(succ, platform, ...)
      if true == succ then
        local items, origin_items, type = ...
        local item_cache = {
          platform = platform,
          type = type or nil,
          items = items,
          origin_items = origin_items
        }
        if not items or not next(items) then
          item_cache.items = {}
          M.LOG.debug(TAG, "get pre-order status succ: purchase items empty")
          cb(true, false)
        else
          request_pre_order_status(item_cache, cb)
        end
        PRE_ORDER_ITEMS:set(item_cache)
      else
        local code, msg = ...
        M.LOG.debug(TAG, "get pre-order status fail: " .. tostring(code or "-1") .. ", msg: " .. (msg or ""))
        cb(false)
      end
    end)
  end
end

function M.save_image_to_album(params, cb)
  params = params or {}
  
  local function callback(succ, code, msg)
    if not cb then
      return
    end
    if true == succ then
      cb(succ)
    else
      cb(succ, {code = code, msg = msg})
    end
  end
  
  if _ejoysdk.os() == "windows" then
    callback(false, {
      code = -1,
      msg = "not support"
    })
    return
  end
  if params.type ~= "url" and params.type ~= "base64" or type(params.data) ~= "string" or params.data == "" then
    callback(false, {
      code = -2,
      msg = "invalid params"
    })
    return
  end
  
  local function save_to_album(image_path)
    if type(image_path) == "string" and "" ~= image_path then
      M.save_to_album(image_path, true, function(ret)
        if ret and 1 == ret.code then
          callback(true)
        else
          callback(false, -8, "save albums failed")
        end
      end)
    else
      callback(false, -4, "save file failed,invalid file path")
    end
  end
  
  local image_file_name = os.time() * 1000 + math.random(1, 1000)
  if "url" == params.type then
    local EMM = require("ejoysdk_lua.res.ejoy_res_model_factory")
    local http_image_download = EMM.get_http_res_model("image_downloader")
    local file_ext = {name = image_file_name}
    local DM = require("ejoysdk_lua.res.model.ejoy_http_download_model")
    local task, err_code, err_msg = http_image_download:create_task(params.data, file_ext, nil, function(_state, _state_obj)
      if _state == DM.DOWNLOAD_STATE.COMPLETE then
        save_to_album(_state_obj.file_path)
      elseif _state ~= DM.DOWNLOAD_STATE.DOWNLOADING then
        callback(false, -4, "download fail, code:" .. tostring(_state_obj.err_code) .. ",msg:" .. tostring(_state_obj.err_msg))
      end
    end)
    if task then
      task:start_download()
    else
      callback(false, -4, "download fail, code:" .. tostring(err_code) .. ",msg:" .. tostring(err_msg))
    end
  elseif "base64" == params.type then
    local succ, save_path = M.File.writefile(image_file_name, params.data, false, true)
    if true == succ then
      save_to_album(save_path)
    else
      callback(false, -4, "save file failed")
    end
  end
end

function M.Sysinfo.async_get_static_params(cb)
  local env_info = M.get_env_info()
  local ret = {}
  ret.res = env_info.devInfo.res or ""
  ret.os = M.Sysinfo.os()
  ret.os_ver = M.Sysinfo.os_version()
  ret.cpu_model = M.Sysinfo.get_cpu_model() or ""
  ret.device = M.Sysinfo.brand() .. " " .. M.Sysinfo.model()
  local HOLO = require("ejoysdk_lua.ejoysdk_holo")
  HOLO.get_device_score(function(succ, ...)
    if succ then
      local score = (...)
      ret.cpu_score = score.cpu
      ret.gpu_score = score.gpu
    else
      ret.cpu_score = ""
      ret.gpu_score = ""
    end
    if cb then
      cb(ret)
    end
  end)
end

function M.Sysinfo.async_get_dynamic_params(cb)
  local cpu, cpu_total, memory, rss_mem, temperature, voltage, run_time, total_phys
  if M.Sysinfo.memory_info().TotalPhys then
    total_phys = M.Sysinfo.memory_info().TotalPhys / 1024
  end
  local total_virtual
  if M.Sysinfo.memory_info().TotalVirtual then
    total_virtual = M.Sysinfo.memory_info().TotalVirtual / 1024
  end
  local avail_phys
  if M.Sysinfo.memory_info().AvailPhys then
    avail_phys = M.Sysinfo.memory_info().AvailPhys / 1024
  end
  local avail_virtual
  if M.Sysinfo.memory_info().AvailVirtual then
    avail_virtual = M.Sysinfo.memory_info().AvailVirtual / 1024
  end
  local total_page_file
  if M.Sysinfo.memory_info().TotalPageFile then
    total_page_file = M.Sysinfo.memory_info().TotalPageFile / 1024
  end
  local avail_page_file
  if M.Sysinfo.memory_info().AvailPageFile then
    avail_page_file = M.Sysinfo.memory_info().AvailPageFile / 1024
  end
  local avail_extended_virtual
  if M.Sysinfo.memory_info().AvailExtendedVirtual then
    avail_extended_virtual = M.Sysinfo.memory_info().AvailExtendedVirtual / 1024
  end
  local gpu_infos = {}
  local storage_info, disk_info_list, network
  local device_info_filter = {"cpu", "memory"}
  local battery_ext_filter = {
    "temperature",
    "voltage"
  }
  local async_return_count = 0
  local total_async_return_count
  if M.Sysinfo.os() == "android" then
    total_async_return_count = 6
  elseif M.Sysinfo.os() == "ios" then
    total_async_return_count = 4
  else
    total_async_return_count = 5
  end
  local network_name
  if M.Sysinfo.os() == "windows" then
    network_name = {
      [-1] = "unsupport",
      [0] = "default",
      [1] = "unknown",
      [2] = "wifi",
      [3] = "wired"
    }
  else
    network_name = {
      [0] = "default",
      [1] = "unknown",
      [2] = "wifi",
      [3] = "2G",
      [4] = "3G",
      [5] = "4G",
      [6] = "5G"
    }
  end
  
  local function final_exe_callback()
    if async_return_count < total_async_return_count then
      return
    end
    if cb then
      local ret = {
        cpu = cpu,
        cpu_total = cpu_total,
        mem = memory,
        rss_mem = rss_mem,
        lua_mem = math.floor(collectgarbage("count") / 1024 + 0.5),
        temperature = temperature or "",
        voltage = voltage or "",
        runtime = run_time,
        mem_total_phys = total_phys or "",
        mem_total_virtual = total_virtual or "",
        mem_avail_phys = avail_phys or "",
        mem_avail_virtual = avail_virtual or "",
        mem_total_page_file = total_page_file or "",
        mem_avail_page_file = avail_page_file or "",
        mem_avail_extended_virtual = avail_extended_virtual or ""
      }
      if network then
        ret.network = network_name[network] or ""
      else
        ret.network = ""
      end
      local index = 1
      for _, gpu_info in pairs(gpu_infos) do
        ret["gpu" .. tostring(index)] = tostring(gpu_info.vendor) .. " " .. tostring(gpu_info.model)
        if gpu_info.memory then
          ret["gpu" .. tostring(index) .. "_memory"] = gpu_info.memory / 1024
        else
          ret["gpu" .. tostring(index) .. "_memory"] = ""
        end
        ret["gpu" .. tostring(index) .. "_driver_version"] = gpu_info.driver_version or ""
        ret["gpu" .. tostring(index) .. "_availability"] = gpu_info.availability or ""
      end
      if M.Sysinfo.os() == "windows" then
        if disk_info_list then
          for _, v in pairs(disk_info_list) do
            if v.total_size then
              ret["storage_info_" .. tostring(v.disk_symbol) .. "_total_size"] = v.total_size / 1024
            else
              ret["storage_info_" .. tostring(v.disk_symbol) .. "_total_size"] = ""
            end
            if v.free_size then
              ret["storage_info_" .. tostring(v.disk_symbol) .. "_available_size"] = v.free_size / 1024
            else
              ret["storage_info_" .. tostring(v.disk_symbol) .. "_available_size"] = ""
            end
            if v.free_to_caller_size then
              ret["storage_info_" .. tostring(v.disk_symbol) .. "_available_to_caller_size"] = v.free_to_caller_size / 1024
            else
              ret["storage_info_" .. tostring(v.disk_symbol) .. "_available_to_caller_size"] = ""
            end
          end
        end
      else
        if storage_info and storage_info.internal_total_storage_size then
          ret.storage_info_internal_total_size = storage_info.internal_total_storage_size / 1024
        else
          ret.storage_info_internal_total_size = ""
        end
        if storage_info and storage_info.internal_available_storage_size then
          ret.storage_info_internal_available_size = storage_info.internal_available_storage_size / 1024
        else
          ret.storage_info_internal_available_size = ""
        end
        if storage_info and storage_info.external_total_storage_size then
          ret.storage_info_external_total_size = storage_info.external_total_storage_size / 1024
        else
          ret.storage_info_external_total_size = ""
        end
        if storage_info and storage_info.external_available_storage_size then
          ret.storage_info_external_available_size = storage_info.external_available_storage_size / 1024
        else
          ret.storage_info_external_available_size = ""
        end
      end
      cb(ret)
    end
  end
  
  M.Sysinfo.device_info(device_info_filter, function(ok, result)
    if ok and type(result) == "table" then
      if "table" == type(result.cpu) then
        cpu = result.cpu.usage_solaris_mode
        cpu_total = result.cpu.usage
      end
      if "table" ~= type(result.memory) then
        async_return_count = async_return_count + 1
        final_exe_callback()
        return
      end
      if result.memory.appPSS and result.memory.appPSS > 0 then
        memory = result.memory.appPSS / 1024
      end
      if result.memory.VmRSS and result.memory.VmRSS > 0 then
        rss_mem = result.memory.VmRSS / 1024
      end
      async_return_count = async_return_count + 1
      final_exe_callback()
    else
      cpu = nil
      cpu_total = nil
      memory = nil
      rss_mem = nil
      async_return_count = async_return_count + 1
      final_exe_callback()
    end
  end)
  if "android" == M.Sysinfo.os() then
    M.Sysinfo.battery_ext(battery_ext_filter, function(ret)
      if not ret then
        async_return_count = async_return_count + 1
        final_exe_callback()
        return
      end
      if ret.temperature and ret.temperature >= 0 then
        temperature = ret.temperature
      end
      if ret.voltage and ret.voltage >= 0 then
        voltage = ret.voltage
      end
      async_return_count = async_return_count + 1
      final_exe_callback()
    end)
  end
  
  local function get_run_time()
    if M.Sysinfo.os() ~= "windows" then
      run_time = math.floor(M.Sysinfo.run_time() / 1000)
      async_return_count = async_return_count + 1
      final_exe_callback()
      return
    end
    M.Sysinfo.run_time_async(function(ret)
      if ret and ret.succ then
        run_time = math.floor(ret.run_time / 1000)
      end
      async_return_count = async_return_count + 1
      final_exe_callback()
    end)
  end
  
  get_run_time()
  
  local function get_gpu_info()
    if M.Sysinfo.os() == "ios" then
      return
    end
    M.Sysinfo.get_gpu_info(function(ret)
      if M.Sysinfo.os() == "android" then
        local gpu_info = {
          model = ret.model,
          vendor = ret.vendor,
          driver_version = ret.version,
          memory = 0,
          availability = ""
        }
        table.insert(gpu_infos, gpu_info)
      elseif M.Sysinfo.os() == "windows" and ret and ret.succ and ret.gpus then
        for _, item in pairs(ret.gpus) do
          local gpu_info = {
            model = item.model,
            vendor = item.vendor,
            driver_version = item.driver_version,
            memory = item.memory / 1024,
            availability = item.availability
          }
          table.insert(gpu_infos, gpu_info)
        end
      end
      async_return_count = async_return_count + 1
      final_exe_callback()
    end)
  end
  
  get_gpu_info()
  
  local function get_storage_info()
    if M.Sysinfo.os() == "android" then
      storage_info = M.Sysinfo.get_storage_info()
      async_return_count = async_return_count + 1
      final_exe_callback()
    elseif M.Sysinfo.os() == "ios" then
      storage_info = M.Sysinfo.get_storage_info()
      async_return_count = async_return_count + 1
      final_exe_callback()
    else
      M.Sysinfo.get_disk_info_async(function(succ, ...)
        if succ then
          disk_info_list = (...)
        else
          local _code, _msg = ...
          disk_info_list = nil
        end
        async_return_count = async_return_count + 1
        final_exe_callback()
      end)
    end
  end
  
  get_storage_info()
  
  local function get_network_type()
    M.Sysinfo.network_current_state_async(function(ret)
      if ret.succ then
        network = ret.state
      else
        network = nil
      end
      async_return_count = async_return_count + 1
      final_exe_callback()
    end)
  end
  
  get_network_type()
end

function M.cross_vm_require(module_name)
  local _ejoy_vm_module_mgr = require("ejoysdk_lua.ejoy_vm_channel")
  do return _ejoy_vm_module_mgr.cross_vm_require end
  return _ejoy_vm_module_mgr.cross_vm_require, module_name
end

function M.is_game_ui_invisible()
  local is_ui_opened = M.WebView.is_opened()
  if is_ui_opened then
    return true
  end
  is_ui_opened = M.Modal.is_opened()
  if is_ui_opened then
    return true
  end
  is_ui_opened = M.is_paused()
  return is_ui_opened
end

function M.async_is_game_ui_invisible(cb)
  cb = cb or function()
  end
  local is_ui_opened = M.is_game_ui_invisible()
  cb(is_ui_opened)
end

function M.clean_disk_cache(_opts)
  local ejoysdk_launcher = require("ejoysdk_lua.ejoysdk_launcher")
  ejoysdk_launcher.clean_disk_cache(_opts)
end

return M
