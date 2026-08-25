local E = require("ejoysdk_lua.ejoysdk")
local FRIEND = require("ejoysdk_lua.native.modules.friends")
local CHAT = require("ejoysdk_lua.native.modules.chat")
local ET = require("ejoysdk_lua.ejoysdk_topic")
local CHAT_STATES = require("ejoysdk_lua.chat.ejoysdk_chat_states")
local ejoysdk_chat = require("ejoysdk_lua.chat.ejoysdk_chat")
local EM = require("ejoysdk_lua.ejoysdk_module")
local TAG = EM.MODULE.NATIVE .. "friend_chat_handler"
local M = {}
M.info_friend_apply = FRIEND.msg_new_friend_apply
M.info_personal_msg = CHAT.receive_personal_msg
M.on_connected = CHAT.on_connected
M.on_disconnect = CHAT.on_disconnect
M.on_error = CHAT.on_error
M.on_connect_lost = CHAT.on_connect_lost
ET.subscribe(ET.chat.UPDATE_STATE, function(state)
  E.LOG.debug(TAG, "当前聊天状态： " .. state)
  if state == CHAT_STATES.ERROR then
    local last_error_msg = ejoysdk_chat.get_last_error_msg()
    E.LOG.debug(TAG, "上次错误信息： " .. last_error_msg)
  end
end)
return M
