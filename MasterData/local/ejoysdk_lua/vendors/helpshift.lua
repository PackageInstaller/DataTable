local E = require("ejoysdk_lua.ejoysdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local UNI = require("ejoysdk_lua.vendors.unisdk")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local EM = require("ejoysdk_lua.ejoysdk_module")
local CHANNEL = "HELPSHIFT"
local M = Vendor:Inherit(CHANNEL)
local TAG = EM.MODULE.VENDORS.HELP_SHIFT
local CAST_SHOW_FAQ = "CAST_SHOW_FAQ"
local CAST_LOGIN_SUCCESS = "CAST_LOGIN_SUCCESS"
local CAST_LOGOUT_SUCCESS = "CAST_LOGOUT_SUCCESS"

function M.show_faq(tags, custom_issue_fields, meta_data)
  local params = {
    tags = tags,
    custom_issue_fields = custom_issue_fields,
    meta_data = meta_data
  }
  UNI.cast(CHANNEL, CAST_SHOW_FAQ, params)
end

local function login_handler(user_info)
  local params = {
    uid = user_info.uid
  }
  UNI.cast(CHANNEL, CAST_LOGIN_SUCCESS, params)
end

local function logout_handler()
  UNI.cast(CHANNEL, CAST_LOGOUT_SUCCESS, {})
end

function M.init(_opt, cb)
  E.LOG.debug(TAG, "helpshift start init!")
  ET.subscribe(ET.gangplank.LOGIN, login_handler)
  ET.subscribe(ET.gangplank.LOGOUT, logout_handler)
  cb(true)
end

function M.show_custom_service(params, cb)
  params = params or {}
  M.show_faq(params.tags, params.custom_issue_fields, params.meta_data)
  cb(true)
end

return M
