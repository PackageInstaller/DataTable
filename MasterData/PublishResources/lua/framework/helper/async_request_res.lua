_class("AsyncRequestRes", Object)
AsyncRequestRes = AsyncRequestRes

function AsyncRequestRes:Constructor()
  self.m_call_err = CallResultType.OtherErr
  self.m_result = -1
end

function AsyncRequestRes:GetCallErr()
  return self.m_call_err
end

function AsyncRequestRes:SetCallErr(value)
  self.m_call_err = value
end

function AsyncRequestRes:GetCallSucc()
  return self.m_call_err == CallResultType.Normal
end

function AsyncRequestRes:GetResult()
  return self.m_result
end

function AsyncRequestRes:SetResult(value)
  self.m_result = value
end

function AsyncRequestRes:GetSucc()
  return self.m_call_err == CallResultType.Normal and self.m_result == 0
end

function AsyncRequestRes:SetSucc(value)
  if value == true then
    self.m_call_err = CallResultType.Normal
    self.m_result = 0
  elseif self.m_result == 0 then
    self.m_result = -1
  end
end
