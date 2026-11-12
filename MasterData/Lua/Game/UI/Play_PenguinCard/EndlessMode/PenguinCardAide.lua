local PenguinCardAide = class("PenguinCardAide")
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")
local PenguinCard = require("Game.UI.Play_PenguinCard.PenguinCard")

function PenguinCardAide:ctor(nId, mapAideLevel)
  self:Clear()
  self:Init(nId, mapAideLevel)
end

function PenguinCardAide:Clear()
  self.nId = nil
  self.nSlotIndex = nil
  self.nLevel = nil
  self.sName = nil
  self.nMaxLevel = nil
  self.tbScore = nil
  self.nCardGroupId = nil
  self.tbUpgradeGroupId = nil
  self.sIcon = nil
  self.nCharId = nil
  if self.mapPenguinCard ~= nil then
    self.mapPenguinCard:Clear()
  end
end

function PenguinCardAide:Init(nId, mapAideLevel)
  self.nId = nId
  self.nLevel = mapAideLevel and mapAideLevel.nLevel or 1
  self.mapUpgradeCount = mapAideLevel and clone(mapAideLevel.mapUpgradeCount) or {}
  self:ParseConfigData(nId)
  self:ParsePenguinCard()
end

function PenguinCardAide:ParseConfigData(nId)
  local mapCfg = ConfigTable.GetData("PenguinCardAide", nId)
  if nil == mapCfg then
    return
  end
  self.sName = mapCfg.Title
  self.nMaxLevel = mapCfg.MaxLevel
  self.tbScore = mapCfg.Score
  self.nCardGroupId = mapCfg.CardGroup
  self.tbUpgradeGroupId = mapCfg.UpgradeGroup
  self.sIcon = mapCfg.Icon
  self.nCharId = mapCfg.CharId
  local bNoneCount = next(self.mapUpgradeCount) == nil
  self.mapUpgradeNeed = {}
  local tbNeed = mapCfg.UpgradeNeed
  for i, nGroup in ipairs(self.tbUpgradeGroupId) do
    if bNoneCount then
      self.mapUpgradeCount[tostring(nGroup)] = 0
    end
    self.mapUpgradeNeed[nGroup] = tbNeed[i]
  end
end

function PenguinCardAide:ParsePenguinCard()
  if not self.nCardGroupId then
    return
  end
  local nId1 = self.nCardGroupId * 100 + 1
  local mapCfg = ConfigTable.GetData("PenguinCard", nId1)
  local nMaxLevel = mapCfg.MaxLevel
  local nLevel = self.nLevel
  if nMaxLevel < nLevel then
    nLevel = nMaxLevel
  end
  local nId = self.nCardGroupId * 100 + nLevel
  if self.mapPenguinCard == nil then
    self.mapPenguinCard = PenguinCard.new(nId)
  else
    self.mapPenguinCard:Init(nId)
  end
end

function PenguinCardAide:SetSlotIndex(nSlotIndex)
  self.nSlotIndex = nSlotIndex
end

function PenguinCardAide:CheckUpgradeGroup(nGroup)
  if not self.mapUpgradeNeed[nGroup] then
    return false
  end
  if self.mapUpgradeCount[tostring(nGroup)] >= self.mapUpgradeNeed[nGroup] then
    return false
  end
  return true
end

function PenguinCardAide:SetUpgradeGroup(nGroup, nCount)
  if not self.mapUpgradeNeed[nGroup] then
    return false
  end
  local sGroup = tostring(nGroup)
  if self.mapUpgradeCount[sGroup] >= self.mapUpgradeNeed[nGroup] then
    return false
  end
  nCount = nCount or 1
  self.mapUpgradeCount[sGroup] = self.mapUpgradeCount[sGroup] + nCount
  if self.mapUpgradeCount[sGroup] < self.mapUpgradeNeed[nGroup] then
    return false
  end
  local nAfter = self.nLevel + 1
  nAfter = nAfter > self.nMaxLevel and self.nMaxLevel or nAfter
  local nAfterAdd = nAfter - self.nLevel
  if nAfterAdd <= 0 then
    return false
  end
  self.nLevel = nAfter
  if self.mapPenguinCard ~= nil then
    self.mapPenguinCard:Upgrade(nAfterAdd)
    self.mapPenguinCard:ResetAllTrigger()
  end
  return true
end

function PenguinCardAide:GetDesc()
  if nil == self.mapPenguinCard then
    return ""
  end
  return self.mapPenguinCard:GetDesc()
end

function PenguinCardAide:GetScore()
  local tbScore = self.tbScore
  if nil == tbScore then
    return 0
  end
  return tbScore[self.nLevel] or 0
end

function PenguinCardAide:GetUpgradeGroup()
  local tbGroup = {}
  if self.nLevel == self.nMaxLevel then
    return tbGroup
  end
  return clone(self.tbUpgradeGroupId)
end

function PenguinCardAide:GetActiveState()
  if nil == self.mapPenguinCard then
    return false
  end
  return self.mapPenguinCard:GetActiveState()
end

function PenguinCardAide:ResetAllTrigger()
  if nil == self.mapPenguinCard then
    return
  end
  self.mapPenguinCard:ResetAllTrigger()
end

function PenguinCardAide:ResetGameTrigger()
  if nil == self.mapPenguinCard then
    return
  end
  self.mapPenguinCard:ResetGameTrigger()
end

function PenguinCardAide:ResetRoundTrigger()
  if nil == self.mapPenguinCard then
    return
  end
  self.mapPenguinCard:ResetRoundTrigger()
end

function PenguinCardAide:ResetTurnTrigger()
  if nil == self.mapPenguinCard then
    return
  end
  self.mapPenguinCard:ResetTurnTrigger()
end

function PenguinCardAide:Trigger(nTriggerPhase, mapTriggerSource, callback)
  if nil == self.mapPenguinCard then
    return
  end
  local bTriggered = self.mapPenguinCard:Trigger(nTriggerPhase, mapTriggerSource, callback)
  if bTriggered then
    EventManager.Hit("PenguinCardAideTriggered", self.nSlotIndex)
  end
end

function PenguinCardAide:Growth(nTriggerPhase, mapTriggerSource)
  if nil == self.mapPenguinCard then
    return
  end
  local bGrowth = self.mapPenguinCard:Growth(nTriggerPhase, mapTriggerSource)
  if bGrowth then
    EventManager.Hit("PenguinCardAideGrowth", self.nSlotIndex)
  end
end

function PenguinCardAide:Serialize()
  local mapPenguinCard = self.mapPenguinCard
  return {
    nId = self.nId,
    nSlotIndex = self.nSlotIndex,
    nLevel = self.nLevel,
    mapUpgradeCount = clone(self.mapUpgradeCount),
    mapPenguinCard = mapPenguinCard and mapPenguinCard:Serialize() or nil
  }
end

function PenguinCardAide:Deserialize(mapData)
  local mapAideLevel = {
    nLevel = mapData.nLevel,
    mapUpgradeCount = clone(mapData.mapUpgradeCount)
  }
  self:Init(mapData.nId, mapAideLevel)
  self.nSlotIndex = mapData.nSlotIndex
  local mapPenguinCard = self.mapPenguinCard
  if mapData.mapPenguinCard and mapPenguinCard then
    mapPenguinCard:Deserialize(mapData.mapPenguinCard)
  end
end

return PenguinCardAide
