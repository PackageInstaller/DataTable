local M = Util.create_class()
local OVERTIME = 1

function M:_init(mask_obj)
  self.v_mask_obj = mask_obj
  self.v_is_overtime = true
  self.v_session_to_call_info = nil
  self.v_first_call_time = false
end

function M:on_uibase_show()
  self.v_mask_obj:SetActive(false)
  self.v_is_overtime = false
  self.v_session_to_call_info = {}
  self.v_first_call_time = math.maxinteger
  self.v_call_hd = MsgGame:mq_bind(Const.MSG_NETWORK_CLIENT_SEND, self.on_network_call, self)
  self.v_response_hd = MsgGame:mq_bind(Const.MSG_NETWORK_SERVER_RESPONSE, self.on_network_response, self)
end

function M:on_uibase_hide()
  MsgGame:mq_unbind(self.v_call_hd)
  MsgGame:mq_unbind(self.v_response_hd)
end

function M:on_uibase_update()
  local is_overtime = false
  if self.v_first_call_time == math.maxinteger then
    is_overtime = false
  elseif Global.real_time - self.v_first_call_time < OVERTIME then
    is_overtime = false
  else
    is_overtime = true
  end
  if self.v_is_overtime ~= is_overtime then
    self.v_mask_obj:SetActive(is_overtime)
    self.v_is_overtime = is_overtime
  end
end

function M:on_network_call(msg)
  if not msg.has_response then
    return
  end
  local is_first_call = next(self.v_session_to_call_info) == nil
  local call_info = {
    spoto_name = msg.spoto_name,
    call_time = Global.real_time
  }
  self.v_session_to_call_info[msg.session] = call_info
  if is_first_call then
    self.v_first_call_time = call_info.call_time
  end
end

function M:on_network_response(msg)
  local call_info = self.v_session_to_call_info[msg.session]
  self.v_session_to_call_info[msg.session] = nil
  if call_info and call_info.call_time == self.v_first_call_time then
    self:cacul_first_call_time()
  end
end

function M:cacul_first_call_time()
  self.v_first_call_time = math.maxinteger
  for _, call_info in pairs(self.v_session_to_call_info) do
    if call_info.call_time < self.v_first_call_time then
      self.v_first_call_time = call_info.call_time
    end
  end
end

return M
