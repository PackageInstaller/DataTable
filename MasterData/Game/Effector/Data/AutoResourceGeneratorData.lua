local AutoResourceGeneratorData = class("AutoResourceGeneratorData")

function AutoResourceGeneratorData:ctor()
  self.itemId = nil
  self.startTm = nil
  self.frag = 0
  self.ceiling = 0
  self.genSpeed = 0
  self.originalValue = 0
  self.newGenValue = 0
end

function AutoResourceGeneratorData:UpdateItem(ARGBase)
  self.itemId = ARGBase.itemId
  self.startTm = ARGBase.startTm
  self.frag = ARGBase.frag
  self.originalValue = PlayerDataCenter:GetItemCount(self.itemId, true)
  self.ceiling = PlayerDataCenter.playerBonus:GetWarehouseCapcity(self.itemId)
  self.genSpeed = PlayerDataCenter.playerBonus:GetAutoRecoverItemSpeed(self.itemId)
  if self.itemId == ConstGlobalItem.SKey then
    PlayerDataCenter.stamina:BroadcastStamina()
  end
end

function AutoResourceGeneratorData:UpdateItemCeil()
  self.ceiling = PlayerDataCenter.playerBonus:GetWarehouseCapcity(self.itemId)
  if self.itemId == ConstGlobalItem.SKey then
    PlayerDataCenter.stamina:BroadcastStamina()
  end
end

function AutoResourceGeneratorData:UpdateItemSpeed()
  if self.accRate == nil then
    self.genSpeed = PlayerDataCenter.playerBonus:GetAutoRecoverItemSpeed(self.itemId)
  else
    self.genSpeed = PlayerDataCenter.playerBonus:GetAutoRecoverItemSpeed(self.itemId) * (1 + self.accRate)
  end
  if self.itemId == ConstGlobalItem.SKey then
    PlayerDataCenter.stamina:BroadcastStamina()
  end
end

function AutoResourceGeneratorData:SetAccRate(accRate)
  self.accRate = accRate
  local oringSpeed = PlayerDataCenter.playerBonus:GetAutoRecoverItemSpeed(self.itemId)
  self.genSpeed = oringSpeed * (1 + accRate)
  if self.itemId == ConstGlobalItem.SKey then
    PlayerDataCenter.stamina:BroadcastStamina()
  end
end

function AutoResourceGeneratorData:GetCurrentNum()
  if self.startTm == nil or self.genSpeed == nil then
    return 0, 0
  end
  local num = self.originalValue
  local remainSecond = 0
  if num >= self.ceiling then
    return num, remainSecond
  end
  local timestamp = PlayerDataCenter.timestamp
  local interval = timestamp - self.startTm
  if interval < -1 then
    return num, remainSecond
  end
  local frag = self.frag + interval * self.genSpeed
  local num = num + math.floor(frag / 100000)
  if num >= self.ceiling then
    num = self.ceiling
  elseif self.genSpeed == 0 then
    remainSecond = 0
  else
    local remainFrag = 100000 - frag % 100000
    remainSecond = math.ceil(remainFrag / self.genSpeed)
  end
  return num, remainSecond
end

function AutoResourceGeneratorData:GetARGCeiling()
  return self.ceiling
end

function AutoResourceGeneratorData:GetARGGenSpeedPerSecond(isBase)
  if isBase then
    local oringSpeed = PlayerDataCenter.playerBonus:GetAutoRecoverItemSpeed(self.itemId)
    return oringSpeed / 100000
  end
  return self.genSpeed / 100000
end

return AutoResourceGeneratorData
