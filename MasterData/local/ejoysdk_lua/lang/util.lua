local EM = require("ejoysdk_lua.ejoysdk_module")
local M = {}
local TAG = EM.MODULE.LANG .. "util"

local function load_const(lang)
  local succ, desc_const = pcall(function()
    do return require end
    return require, "ejoysdk_lua.lang.const." .. tostring(lang), tostring(lang), lang
  end)
  if succ then
    return desc_const
  end
end

function M.getString(key, fallback)
  local LC = {}
  local E = require("ejoysdk_lua.ejoysdk")
  local safeKey = key or ""
  local langKey = E.CONFIG.get_config("lang"):lower() or ""
  E.LOG.debug(TAG, "langConfig:" .. tostring(langKey))
  if langKey and "" ~= langKey then
    LC = load_const(langKey)
  end
  local result = (LC or {})[safeKey]
  if result or fallback then
    return result or fallback
  end
  local publish_area = E.CONFIG.get_config(E.CONFIG.KEY.PUBLISH_AREA)
  if publish_area then
    local area_lang = require("ejoysdk_lua.lang.area_default_lang")
    local area_lang_key = area_lang[publish_area]
    if langKey ~= area_lang_key then
      LC = load_const(area_lang_key)
      if LC and LC[safeKey] then
        return LC[safeKey]
      end
    end
  end
  LC = load_const("zh-hans")
  return LC[safeKey] or ""
end

function M.getStringSuitCNOverseas(key, fallback)
  local value = M.getString(key, fallback)
  local UTILS = require("ejoysdk_lua.ejoysdk_utils")
  if UTILS.STR.is_empty(value) then
    local E = require("ejoysdk_lua.ejoysdk")
    if E.CONFIG.get_config(E.CONFIG.KEY.MULTI_REGIONS_ENABLED) then
      local LC_overseas = load_const("en")
      value = LC_overseas[key]
    else
      local LC_CN = load_const("zh-hans")
      value = LC_CN[key]
    end
  end
  return value or ""
end

return M
