local ET = require("ejoysdk_lua.ejoysdk_topic")
local EJOYSDK_CONFIG = require("ejoysdk_lua.ejoysdk_config")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local LANG_KEYSTORE_NAME = "EJOYSDK_CONFIG_LANG"
local LANG_CONFIG_KEY = "lang"
local TAG = EM.MODULE.EJOYSDK_BASE_MODULE .. "ejoysdk_lang"
local lang_list, default_lang, _lang_keystore

local function get_lang_keystore()
  if nil == _lang_keystore then
    local E = require("ejoysdk_lua.ejoysdk")
    _lang_keystore = E.LazyKeyStore:New(LANG_KEYSTORE_NAME, false, false, false)
  end
  return _lang_keystore
end

local function lang_config_changed(value)
  if not value or type(value) ~= "string" then
    return
  end
  if value == get_lang_keystore():get() then
    _ejoysdk.log("lang config changed, but same lang, return")
    return
  end
  _ejoysdk.log("lang config changed, value: " .. tostring(value))
  get_lang_keystore():set(value:lower())
end

ET.subscribe(ET.config.CONFIG_CHANGED .. "_" .. LANG_CONFIG_KEY, lang_config_changed)

local function get_system_lang()
  local E = require("ejoysdk_lua.ejoysdk")
  do return E.Sysinfo.language_and_script().lower end
  return E.Sysinfo.language_and_script().lower, (E.Sysinfo.language_and_script())
end

local function find_match_lang()
  _ejoysdk.log("find_match_lang called")
  local system_lang = get_system_lang()
  _ejoysdk.log("first, system_lang = " .. tostring(system_lang))
  if _ejoysdk.os() == "windows" then
    local STEAM = require("ejoysdk_lua.vendors.steam")
    local EPIC = require("ejoysdk_lua.vendors.epic")
    if STEAM.is_support_channel_sdk() and STEAM.get_steam_language() then
      system_lang = STEAM.get_steam_language()
      _ejoysdk.log("second, get_steam_language = " .. tostring(system_lang))
    elseif EPIC.is_support_channel_sdk() and EPIC.get_epic_language() then
      system_lang = EPIC.get_epic_language()
      _ejoysdk.log("second, get_epic_language = " .. tostring(system_lang))
    end
  end
  local match_lang = system_lang
  if lang_list then
    local function escape_lang(lang)
      do return lang.gsub, lang, "%-" end
      
      return lang.gsub, lang, "%-", ""
    end
    
    system_lang = escape_lang(system_lang)
    local longest_len = 0
    local longest_lang
    for _, lang in ipairs(lang_list) do
      local elang = escape_lang(lang)
      local find_result = {
        system_lang:find(elang)
      }
      if find_result[1] and find_result[2] then
        longest_len = longest_len < find_result[2] and find_result[2] or longest_len
        longest_lang = lang
      end
    end
    if longest_lang then
      _ejoysdk.log("使用最长匹配语言: " .. tostring(longest_lang))
      match_lang = longest_lang
    elseif default_lang then
      _ejoysdk.log("使用默认语言: " .. tostring(longest_lang))
      match_lang = default_lang
    end
  end
  return match_lang
end

function M.get_startup_lang()
  local last_lang = get_lang_keystore():get()
  if last_lang then
    _ejoysdk.log("last lang: " .. tostring(last_lang))
    return last_lang
  else
    local match_lang = find_match_lang()
    _ejoysdk.log("has no last lang, match lang: " .. tostring(match_lang))
    return match_lang
  end
end

function M.set_lang_list(lang_list_param, default_lang_param)
  lang_list = lang_list_param
  default_lang = default_lang_param
  _ejoysdk.log(TAG .. "#set_lang_list finished, default_lang_param:" .. tostring(default_lang_param))
end

function M.get()
  do return EJOYSDK_CONFIG.get_config end
  return EJOYSDK_CONFIG.get_config, LANG_CONFIG_KEY
end

function M.set(value)
  _ejoysdk.log(TAG .. "#set with value:" .. tostring(value))
  EJOYSDK_CONFIG.set_config(LANG_CONFIG_KEY, value:lower())
end

return M
