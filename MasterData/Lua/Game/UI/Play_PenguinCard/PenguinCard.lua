local PenguinCard = class("PenguinCard")
local PenguinCardUtils = require("Game.UI.Play_PenguinCard.PenguinCardUtils")

function PenguinCard:ctor(nId)
  self:Clear()
  self:Init(nId)
end

function PenguinCard:Upgrade(nAddLevel)
  local nAfter = self.nLevel + nAddLevel
  if nAfter > self.nMaxLevel then
    nAfter = self.nMaxLevel
  elseif nAfter < 1 then
    nAfter = 1
  end
  local nId = self:GetIdByLevel(self.nGroupId, nAfter)
  local nCacheGrowthLayer = 0
  if self.nGrowthType ~= GameEnum.PenguinCardGrowthType.None and not self.bUpgradeResetGrowth then
    nCacheGrowthLayer = self.nGrowthLayer
  end
  self:Clear()
  self:Init(nId, nCacheGrowthLayer)
end

function PenguinCard:Clear()
  self.nId = nil
  self.nSlotIndex = nil
  self.nGroupId = nil
  self.sName = nil
  self.sIcon = nil
  self.nRarity = nil
  self.nLevel = nil
  self.nMaxLevel = nil
  self.nSoldPrice = nil
  self.nTendencyGroup = nil
  self.nTendencyScore = nil
  self.nTriggerPhase = nil
  self.nTriggerType = nil
  self.tbTriggerParam = nil
  self.nTriggerProbability = nil
  self.nTriggerLimit = nil
  self.tbTriggerLimitParam = nil
  self.nEffectType = nil
  self.tbEffectParam = nil
  self.nGrowthType = nil
  self.bUpgradeResetGrowth = nil
  self.nGrowthTriggerPhase = nil
  self.nGrowthTriggerType = nil
  self.tbGrowthTriggerParam = nil
  self.tbGrowthEffectParam = nil
  self.nTriggerCount = nil
  self.nRoundTriggerCount = nil
  self.nGrowthLayer = nil
  self.bHighLight = nil
end

function PenguinCard:Init(nId, nGrowthLayer)
  self.nId = nId
  self:ParseConfigData(nId)
  self.nGrowthLayer = nGrowthLayer or 0
  if self.nGrowthLimit ~= nil and 0 < self.nGrowthLimit and self.nGrowthLayer > self.nGrowthLimit then
    self.nGrowthLayer = self.nGrowthLimit
  end
end

function PenguinCard:ParseConfigData(nId)
  local mapCfg = ConfigTable.GetData("PenguinCard", nId)
  if nil == mapCfg then
    return
  end
  self.nGroupId = mapCfg.GroupId
  self.sName = mapCfg.Title
  self.sIcon = mapCfg.Icon
  self.nRarity = mapCfg.Rarity
  self.nLevel = mapCfg.Level
  self.nMaxLevel = mapCfg.MaxLevel
  self.nSoldPrice = mapCfg.SoldPrice
  self.nTendencyGroup = mapCfg.TendencyGroup
  self.nTendencyScore = mapCfg.TendencyScore
  self.nTriggerPhase = mapCfg.TriggerPhase
  self.nTriggerType = mapCfg.TriggerType
  self.tbTriggerParam = decodeJson(mapCfg.TriggerParam)
  self.nTriggerProbability = mapCfg.TriggerProbability
  self.nTriggerLimit = mapCfg.TriggerLimit
  self.tbTriggerLimitParam = mapCfg.TriggerLimitParam
  self.nEffectType = mapCfg.EffectType
  self.tbEffectParam = decodeJson(mapCfg.EffectParam)
  self.nGrowthType = mapCfg.GrowthType
  self.bUpgradeResetGrowth = mapCfg.UpgradeResetGrowth
  self.nGrowthTriggerPhase = mapCfg.GrowthTriggerPhase
  self.nGrowthTriggerType = mapCfg.GrowthTriggerType
  self.tbGrowthTriggerParam = decodeJson(mapCfg.GrowthTriggerParam)
  self.tbGrowthEffectParam = decodeJson(mapCfg.GrowthEffectParam)
  self.nGrowthLimit = mapCfg.GrowthLimit
end

function PenguinCard:SetSlotIndex(nSlotIndex)
  self.nSlotIndex = nSlotIndex
end

function PenguinCard:SetHighLight(bHighLight)
  self.bHighLight = bHighLight
end

function PenguinCard:GetDesc()
  local mapCfg = ConfigTable.GetData("PenguinCard", self.nId)
  if nil == mapCfg then
    return ""
  end
  return PenguinCardUtils.SetEffectDesc(mapCfg, self.nGrowthLayer)
end

function PenguinCard:GetActiveState()
  if self.nGrowthType == GameEnum.PenguinCardGrowthType.FullGame and self.tbGrowthEffectParam[1] < 0 then
    local nEffectValue = self.tbEffectParam[1] + self.nGrowthLayer * self.tbGrowthEffectParam[1]
    if nEffectValue <= 0 then
      return false
    end
  end
  return true
end

function PenguinCard:ResetAllTrigger()
  self:ResetGameTrigger()
  self:ResetRoundTrigger()
  self:ResetTurnTrigger()
end

function PenguinCard:ResetGameTrigger()
  if self.nTriggerLimit == GameEnum.PenguinCardTriggerLimit.Game then
    self.nTriggerCount = 0
  end
  if self.nTriggerLimit == GameEnum.PenguinCardTriggerLimit.TurnAndRound then
    self.nTriggerCount = 0
    self.nRoundTriggerCount = 0
  end
end

function PenguinCard:ResetRoundTrigger()
  if self.nTriggerLimit == GameEnum.PenguinCardTriggerLimit.Round then
    self.nTriggerCount = 0
  end
  if self.nTriggerLimit == GameEnum.PenguinCardTriggerLimit.TurnAndRound then
    self.nRoundTriggerCount = 0
  end
end

function PenguinCard:ResetTurnTrigger()
  if self.nTriggerLimit == GameEnum.PenguinCardTriggerLimit.Turn then
    self.nTriggerCount = 0
  end
  if self.nTriggerLimit == GameEnum.PenguinCardTriggerLimit.TurnAndRound then
    self.nTriggerCount = 0
    self.nRoundTriggerCount = 0
  end
  if self.nGrowthType == GameEnum.PenguinCardGrowthType.CurTurn then
    self.nGrowthLayer = 0
  end
end

function PenguinCard:Trigger(nTriggerPhase, mapTriggerSource, callback)
  if not PenguinCardUtils.CheckTriggerLimit(self.nTriggerLimit, self.tbTriggerLimitParam, self.nTriggerCount, self.nRoundTriggerCount) then
    return false
  end
  if nTriggerPhase ~= self.nTriggerPhase then
    return false
  end
  local bAble = PenguinCardUtils.CheckTriggerAble(self.nTriggerType, self.tbTriggerParam, self.nTriggerProbability, mapTriggerSource, self.nEffectType)
  if not bAble then
    return false
  end
  local mapEffectValue
  if PenguinCardUtils.SingleValueEffect[self.nEffectType] then
    if self.nGrowthType == GameEnum.PenguinCardGrowthType.None then
      mapEffectValue = self.tbEffectParam[1]
    else
      mapEffectValue = self.tbEffectParam[1] + self.nGrowthLayer * self.tbGrowthEffectParam[1]
      if mapEffectValue < 0 then
        mapEffectValue = 0
      end
    end
  else
    mapEffectValue = self.tbEffectParam
  end
  if type(mapEffectValue) == "number" and mapEffectValue == 0 then
    return false
  end
  if self.nTriggerLimit == GameEnum.PenguinCardTriggerLimit.TurnAndRound then
    self.nTriggerCount = (self.nTriggerCount or 0) + 1
    self.nRoundTriggerCount = (self.nRoundTriggerCount or 0) + 1
  elseif self.nTriggerLimit ~= GameEnum.PenguinCardTriggerLimit.None then
    self.nTriggerCount = self.nTriggerCount + 1
  end
  if callback then
    if NovaAPI.IsEditorPlatform() then
      printLog("企鹅牌触发：" .. "  " .. self.sName .. "  " .. self:GetDesc())
    end
    callback(self.nEffectType, mapEffectValue)
  end
  EventManager.Hit("PenguinCardTriggered", self.nSlotIndex)
  return true
end

function PenguinCard:Growth(nTriggerPhase, mapTriggerSource)
  if self.nGrowthType == GameEnum.PenguinCardGrowthType.None then
    return false
  end
  if nTriggerPhase ~= self.nGrowthTriggerPhase then
    return false
  end
  local nAdd = PenguinCardUtils.CheckGrowthLayer(self.nGrowthTriggerType, self.tbGrowthTriggerParam, mapTriggerSource)
  if nAdd == 0 then
    return false
  end
  if self.nGrowthTriggerType == GameEnum.PenguinCardGrowthTriggerType.LevelCount then
    self.nGrowthLayer = nAdd
  else
    self.nGrowthLayer = self.nGrowthLayer + nAdd
  end
  if 0 < self.nGrowthLimit and self.nGrowthLayer > self.nGrowthLimit then
    self.nGrowthLayer = self.nGrowthLimit
  end
  EventManager.Hit("PenguinCardGrowth", self.nSlotIndex)
  return true
end

function PenguinCard:GetIdByLevel(nGroupId, nLevel)
  return nGroupId * 100 + nLevel
end

function PenguinCard:Serialize()
  return {
    nId = self.nId,
    nSlotIndex = self.nSlotIndex,
    nTriggerCount = self.nTriggerCount,
    nRoundTriggerCount = self.nRoundTriggerCount,
    nGrowthLayer = self.nGrowthLayer,
    bHighLight = self.bHighLight
  }
end

function PenguinCard:Deserialize(mapData)
  self:Init(mapData.nId, mapData.nGrowthLayer)
  self.nSlotIndex = mapData.nSlotIndex
  self.nTriggerCount = mapData.nTriggerCount
  self.nRoundTriggerCount = mapData.nRoundTriggerCount
  self.bHighLight = mapData.bHighLight
end

return PenguinCard
