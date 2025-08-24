local M = Util.create_class()

function M:_init()
  self.__is_component__ = true
  self.v_msg_handles = {}
  self.v_ui_msg_handles = {}
  self.v_is_destroy = false
  self.v_enable = true
end

function M:is_component()
  return self.__is_component__
end

function M:after_add_component()
end

function M:set_enable(v)
  self.v_enable = v
end

function M:on_before_destroy()
end

function M:on_destroy()
  self.v_is_destroy = true
  self:on_before_destroy()
  self:mgr_all_mq_unbind()
end

function M:on_destroy_gameobj()
end

function M:mgr_bind_auto_mq(msg_type, callback, cbdata)
  local msg_handle = MsgGame:mq_bind(msg_type, callback, cbdata)
  self.v_msg_handles[msg_handle] = msg_type
  return msg_handle
end

function M:mgr_unbind_auto_mq(msg_handle)
  self.v_msg_handles[msg_handle] = nil
  MsgGame:mq_unbind(msg_handle)
end

function M:mgr_all_mq_unbind()
  for msg_handle, _ in pairs(self.v_msg_handles) do
    MsgGame:mq_unbind(msg_handle)
  end
  self.v_msg_handles = {}
end

function M:is_destroy()
  return self.v_is_destroy
end

return M
