local StaminaData = class("StaminaData")

function StaminaData:ctor()
end

function StaminaData:GetCurrentStamina()
  local ARGData = PlayerDataCenter.allEffectorData.AutoResourceGeneratorDic[ConstGlobalItem.SKey]
  if ARGData ~= nil then
    return ARGData:GetCurrentNum()
  else
    return 0, 0
  end
end

function StaminaData:GetStaminaCeiling()
  local ARGData = PlayerDataCenter.allEffectorData.AutoResourceGeneratorDic[ConstGlobalItem.SKey]
  if ARGData ~= nil then
    return ARGData:GetARGCeiling()
  else
    return 0
  end
end

function StaminaData:StartTimer(time)
  if self.__TimerId ~= nil then
    TimerManager:StopTimer(self.__TimerId)
    self.__TimerId = nil
  end
  self.__TimerId = TimerManager:StartTimer(time, self.BroadcastStamina, self, true)
end

function StaminaData:BroadcastStamina()
  self.__TimerId = nil
  MsgCenter:Broadcast(eMsgEventId.StaminaUpdate)
  local stamina, remainSecond = self:GetCurrentStamina()
  if 0 < remainSecond then
    self:StartTimer(remainSecond + 1)
  elseif stamina < self:GetStaminaCeiling() then
    self:StartTimer(1)
  end
end

return StaminaData
