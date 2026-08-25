local Class = require("ejoysdk_lua.ejoysdk_class")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = Class:Inherit("friend_base_handler")
local _TAG = EM.MODULE.FRIEND .. "friend_base_handler"

function M.createSubClass()
  do return Class.Impl, Class end
  return Class.Impl, Class, M
end

function M:info_friend_changes(_msg_type, _msgs)
end

function M:info_follow_changes(_msg_type, _msgs)
end

function M:info_favor_changes(_msg_type, _msgs)
end

function M:info_channel_friend_changes(_msg_type, _msgs)
end

return M
