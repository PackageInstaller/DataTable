local EffectorResourceData = class("EffectorResourceData")
local EffectorUtil = require("Game.Effector.EffectorUtil")

function EffectorResourceData:InitEffectorRes(data)
  self:__UpdateBase(data)
  self.fitPeriodCount = false
  local itemCfg = ConfigData.item[self.itemId]
  if itemCfg == nil then
    error("Can't find itemCfg, id = " .. tostring(self.itemId))
  end
  self.itemCfg = itemCfg
end

function EffectorResourceData:__UpdateBase(data)
  self.uid = data.uid
  self.functionId, self.logicId = EffectorUtil.ConvertEffectorUid(self.uid)
  self.itemId = data.itemId
  self.originalStartTm = data.originalStartTm
  self.relativeStartTm = data.relativeStartTm
  self.containNum = data.containNum
  self.extraNum = data.extraNum
  self.keepNum = data.keepNum
  self.resMax = false
end

function EffectorResourceData:UpdateEffectorRes(data)
  self:__UpdateBase(data)
  self.nextUpdateTime = self.originalStartTm
end

function EffectorResourceData:GetName()
  return LanguageUtil.GetLocaleText(self.itemCfg.name)
end

function EffectorResourceData:GetResCount(speed, period)
  local resCount = self.containNum
  local extraNum = self.extraNum
  local outputCeiling = PlayerDataCenter.playerBonus:GetResOutputCeiling(self.logicId)
  if outputCeiling == 0 then
    error(string.format("Resource output ceiling is 0, itemId = %s, logicId = %s", self.itemId, self.logicId))
  end
  local outputEfficiency = PlayerDataCenter.AllBuildingData:GetResOutputEfficiency(self.itemId)
  local currentTime = math.floor(PlayerDataCenter.timestamp)
  if currentTime > self.relativeStartTm then
    local effectiveTime = currentTime - self.relativeStartTm
    resCount = resCount + effectiveTime * speed
    extraNum = extraNum + effectiveTime * speed * outputEfficiency // 1000
  end
  local onePeriodCount = speed * period
  local notFullPeriodCount = resCount % onePeriodCount
  local notFullPeriodExtraCount = outputEfficiency == 0 and 0 or extraNum % (onePeriodCount * outputEfficiency // 1000)
  self.fitPeriodCount = self.keepNum ~= 0 or resCount // onePeriodCount ~= 0
  extraNum = extraNum - notFullPeriodExtraCount
  resCount = resCount - notFullPeriodCount
  local progress = math.min(notFullPeriodCount / onePeriodCount, 1)
  resCount = (resCount + extraNum + self.keepNum) // 100000
  local resMax = outputCeiling <= resCount
  if resMax then
    resCount = outputCeiling
  end
  local effSpeed = speed * PlayerDataCenter.AllBuildingData:GetResOutputEfficiency(self.itemId) / 1000
  self.resMax = resMax
  if GuideManager.collectResGuideUnComplete and self.logicId == 1003 then
    self.fitPeriodCount = true
    resCount = resCount + 1
  end
  return resCount, progress, resMax, effSpeed, outputCeiling
end

return EffectorResourceData
