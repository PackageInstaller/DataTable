local UNI = require("ejoysdk_lua.vendors.unisdk")
local Vendor = require("ejoysdk_lua.vendors.vendor")
local CHANNEL = "CAFE"
local CAST_SHOW_CAFE_PAGE = "CAST_SHOW_CAFE_PAGE"
local CAST_DISMISS_CAFE_PAGE = "CAST_DISMISS_CAFE_PAGE"
local CAST_SHOW_CAFE_WIDGET_BUTTON = "CAST_SHOW_CAFE_WIDGET_BUTTON"
local CAST_DISMISS_CAFE_WIDGET_BUTTON = "CAST_DISMISS_CAFE_WIDGET_BUTTON"
local EM = require("ejoysdk_lua.ejoysdk_module")
local _TAG = EM.MODULE.VENDORS.CAFE
local M = Vendor:Inherit(CHANNEL)

function M.show_cafe_page()
  UNI.cast(CHANNEL, CAST_SHOW_CAFE_PAGE, {})
end

function M.dismiss_cafe_page()
  UNI.cast(CHANNEL, CAST_DISMISS_CAFE_PAGE, {})
end

function M.show_cafe_widget_button(params)
  UNI.cast(CHANNEL, CAST_SHOW_CAFE_WIDGET_BUTTON, params or {})
end

function M.dismiss_cafe_widget_button()
  UNI.cast(CHANNEL, CAST_DISMISS_CAFE_WIDGET_BUTTON, {})
end

return M
