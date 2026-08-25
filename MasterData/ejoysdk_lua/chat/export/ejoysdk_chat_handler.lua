local Class = require("ejoysdk_lua.ejoysdk_class")
local EM = require("ejoysdk_lua.ejoysdk_module")
local M = Class:Inherit("chat_base_handler")
local _TAG = EM.MODULE.CHAT .. "chat_base_handler"

function M.createSubClass()
  do return Class.Impl, Class end
  return Class.Impl, Class, M
end

function M:info_chat_state(_state, _body)
end

function M:info_chat_rpc_result(_task_id, _task_name, _result)
end

function M:info_chat_session_change(_adds, _updates, _removes)
end

function M:info_chat_msgs(_session_type, _session_id, _msgs, _session_from)
end

function M:info_group_changes(_adds, _updates, _removes)
end

function M:info_group_system_msg(_body)
end

function M:on_connect_state_change(_state_event, _err_msg)
end

function M:on_handlers_error(_err_msg)
end

return M
