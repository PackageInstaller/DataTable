local DynPlayerData = class("DynPlayerData")
local ExplorationEnum = require("Game.Exploration.ExplorationEnum")

function DynPlayerData:ctor(data)
  self.data = data
  self.baseAttr = {}
  self.ratioAttr = {}
  self.extraAttr = {}
  self.originAttr = {}
  if self.data ~= nil then
    self:__updateBaseAttr(self.data)
  end
  self.intensity = 0
  self.hpPer = ExplorationEnum.eHeroHpPercent
  self.moveSpeed = 0
  self.attackRange = 10
end

function DynPlayerData:RefreshDynData(data)
  self.data = data
  if self.data ~= nil then
    self:__updateBaseAttr(self.data)
  end
end

function DynPlayerData:__updateBaseAttr(data)
  if data ~= nil and data.attr ~= nil then
    local attrData = self.data.attr
    for i = 2, eHeroAttr.max_property_count + 1 do
      self.originAttr[i - 1] = attrData[i]
    end
  end
end

function DynPlayerData:GetOriginAttr(attrId)
  return self.originAttr[attrId] or 0
end

function DynPlayerData:GetRatioAttr(attrId)
  return self.ratioAttr[attrId] or 0
end

function DynPlayerData:GetExtraAttr(attrId)
  return self.extraAttr[attrId] or 0
end

function DynPlayerData:GetRealAttr(attrId)
  return ((self.originAttr[attrId] or 0) + (self.baseAttr[attrId] or 0)) * (eHeroAttrPercent + (self.ratioAttr[attrId] or 0)) // eHeroAttrPercent + (self.extraAttr[attrId] or 0)
end

function DynPlayerData:GetBaseAttr(attrId)
  return self.baseAttr[attrId] or 0
end

function DynPlayerData:SetBaseAttr(attrId, value)
  self.baseAttr[attrId] = value
end

function DynPlayerData:SetRatioAttr(attrId, value)
  self.ratioAttr[attrId] = value
  if attrId == eHeroAttr.maxHp then
    self.maxHp = self:GetRealAttr(eHeroAttr.maxHp)
  end
end

function DynPlayerData:SetExtraAttr(attrId, value)
  self.extraAttr[attrId] = value
  if attrId == eHeroAttr.maxHp then
    self.maxHp = self:GetRealAttr(eHeroAttr.maxHp)
  end
end

return DynPlayerData
