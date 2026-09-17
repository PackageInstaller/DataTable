local this = {}

function this:showNormalMsgByKey(str, param, overrideLen)
  local msg
  local langStr = L_WordsTpl:getValue(str, param)
  if string.isEmpty(langStr) then
    self:showNormalMsg(str, overrideLen)
    return
  end
  self:showNormalMsg(langStr, overrideLen)
end

function this:showNormalMsg(str, overrideLen)
  AzurWorld.FlymsgManager:Enqueue(L_ShowQueueConst.flyMsgType.normalMsg, str)
end

return this
