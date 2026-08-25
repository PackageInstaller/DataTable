local sdk_chat_handler_class = require("ejoysdk_lua.chat.export.ejoysdk_chat_handler")
local M = sdk_chat_handler_class:New()
local user_type = "account"

function M:_init(delegate_vm)
  self.delegate_vm = delegate_vm
end

function M:set_delegate_vm(delegate_vm)
  self.delegate_vm = delegate_vm
end

function M:info_chat_session_change(adds, updates, removes)
  if self.delegate_vm and self.delegate_vm.info_chat_session_change then
    self.delegate_vm.info_chat_session_change(user_type, adds, updates, removes)
  end
end

function M:info_chat_msgs(session_type, session_id, msgs, session_from)
  if not msgs or 0 == #msgs then
    return
  end
  if self.delegate_vm and self.delegate_vm.info_chat_msgs then
    self.delegate_vm.info_chat_msgs(user_type, session_type, session_id, msgs, session_from)
  end
end

function M:info_chat_rpc_result(task_id, task_name, result)
  if self.delegate_vm and self.delegate_vm.info_chat_rpc_result then
    self.delegate_vm.info_chat_rpc_result(user_type, task_id, task_name, result)
  end
end

function M:on_handlers_error(_err_msg)
  if self.delegate_vm and self.delegate_vm.on_handlers_error then
    self.delegate_vm.on_handlers_error(_err_msg)
  end
end

return M
