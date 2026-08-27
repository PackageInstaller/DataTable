local ArithmeticData = class("ArithmeticData")
local AthEnum = require("Game.Arithmetic.ArthmeticEnum")
local affixQuality = 4

function ArithmeticData:ctor(dataTab)
  self.uid = dataTab.uid
  self.id = dataTab.uid >> 32
  self:UpdateAthData(dataTab)
  local itemCfg = ConfigData.item[self.id]
  if itemCfg == nil then
    error("Can't find itemCfg by arithmetic.id, id = " .. tostring(self.id))
    return
  end
  self.itemCfg = itemCfg
  local athCfg = ConfigData.arithmetic[self.id]
  if athCfg == nil then
    error("Can't arithmetic cfg, id = " .. tostring(self.id))
    return
  end
  self.athCfg = athCfg
  self.size = athCfg.size
  self.quality = itemCfg.quality
  self.area_type = athCfg.area_type
  self.suit = athCfg.suit
end

function ArithmeticData:UpdateAthData(dataTab)
  self.mainAttrCfgId = dataTab.mainAttrCfgId
  local athMainAttrCfg = ConfigData.ath_attribute_pool[self.mainAttrCfgId]
  if athMainAttrCfg == nil then
    error("Cant get ath_attribute_pool, id = " .. tostring(self.mainAttrCfgId))
  end
  self.athMainAttrCfg = athMainAttrCfg
  self.affixList = dataTab.affix
  self:_GenSubAffixValue()
  self.bindInfo = dataTab.bindInfo
  self._signHeroId = dataTab.heroSign
  self.lockUnlock = dataTab.lockUnlock
  self.athTs = dataTab.ts
  self.__fightPower = nil
end

function ArithmeticData:GetAthMainAttrId(notMerge)
  for k, attrId in ipairs(self.athMainAttrCfg.attrtibute_id) do
    local attrCfg = ConfigData.attribute[attrId]
    if attrCfg == nil then
      error("Cant get attrCfg, attrId = " .. tostring(attrId))
      return
    end
    if attrCfg.merge_attribute == 0 or notMerge then
      return attrId
    else
      return attrCfg.merge_attribute
    end
  end
end

function ArithmeticData:GetAthSubAttrIdList()
  local attrList = {}
  for k, elem in ipairs(self.affixList) do
    local cfg = ConfigData.ath_affix_pool[elem.id]
    if cfg == nil then
      error("Cant't find ath_affix_pool, id = " .. tostring(elem.id))
    else
      local attrId = cfg.affix_para
      local attrCfg = ConfigData.attribute[attrId]
      if attrCfg == nil then
        error("Cant get attrCfg, attrId = " .. tostring(attrId))
        return
      end
      if attrCfg.merge_attribute ~= 0 then
        attrId = attrCfg.merge_attribute
      end
      table.insert(attrList, attrId)
    end
  end
  return attrList
end

function ArithmeticData:GetColor()
  return ItemQualityColor[self.itemCfg.quality]
end

function ArithmeticData:GetAthColor()
  return AthEnum.AthColor[self.itemCfg.quality]
end

function ArithmeticData:GetAthSize()
  return self.athCfg.size
end

function ArithmeticData:GetAthSuit()
  return self.athCfg.suit, self.athCfg.conflict
end

function ArithmeticData:GetAthAreaType()
  return self.athCfg.area_type
end

function ArithmeticData:GetAthQuality()
  return self.itemCfg.quality
end

function ArithmeticData:IsAthLock()
  return self.lockUnlock
end

function ArithmeticData:GetIcon()
  return self.itemCfg.icon
end

function ArithmeticData:GetName()
  return LanguageUtil.GetLocaleText(self.itemCfg.name)
end

local powerDic = {}

function ArithmeticData:GetAthSubAttrQualityWeight()
  local weight = 0
  for k, affix in ipairs(self.affixList) do
    local w = powerDic[affix.quality] or 10 ^ affix.quality
    powerDic[affix.quality] = w
    weight = weight + w
  end
  return weight
end

function ArithmeticData:GetAthFightPower()
  if self.__fightPower == nil then
    local athAttr = self:GetAthAttr()
    self.__fightPower = PlayerDataCenter.allAthData:GetAthFightPower(athAttr)
  end
  return self.__fightPower
end

function ArithmeticData:GetAthDensity()
  local athAttr = self:GetAthAttr()
  return PlayerDataCenter.allAthData:GetAthDensity(athAttr, self.size)
end

function ArithmeticData:GetAthAttr()
  local athAttr = setmetatable({}, {
    __index = function(tab, key)
      return 0
    end
  })
  for k, attrId in ipairs(self.athMainAttrCfg.attrtibute_id) do
    local attrValue = self.athMainAttrCfg.attrtibute_num[k]
    athAttr[attrId] = athAttr[attrId] + attrValue
  end
  for k, affix in ipairs(self.affixList) do
    local cfg = ConfigData.ath_affix_pool[affix.id]
    if cfg == nil then
      error("Can't find ath_affix_pool, id = " .. tostring(affix.id))
    else
      athAttr[cfg.affix_para] = athAttr[cfg.affix_para] + affix.value
    end
  end
  return athAttr
end

function ArithmeticData:IsHaveThisAttr(attrId)
  for index, id in ipairs(self.athMainAttrCfg.attrtibute_id) do
    if id == attrId then
      return true
    end
  end
  return false
end

function ArithmeticData:IsHaveThisViceAttr(attrId)
  for index, attr in ipairs(self.affixList) do
    if attr.id == attrId then
      return true
    end
  end
  return false
end

function ArithmeticData:CanAthOptimize()
  for index, attr in ipairs(self.affixList) do
    local affixcfg = ConfigData.ath_affix_pool[attr.id]
    if affixcfg == nil then
      error("Cant't find ath_affix_pool, id = " .. tostring(attr.id))
      return
    end
    local maxLevel = ConfigData.ath_affix_lv.maxAffixLevel
    if attr.quality == affixQuality and maxLevel > attr.level then
      return true
    end
  end
  return false
end

function ArithmeticData:_GenSubAffixValue()
  for k, affixElem in ipairs(self.affixList) do
    local value = PlayerDataCenter.allAthData:GenAthAffixValue(affixElem.id, affixElem.quality, affixElem.level)
    if value ~= nil then
      affixElem.value = value
    end
  end
end

function ArithmeticData:GetAthDataUID()
  return self.uid
end

function ArithmeticData:IsConflictAthSuit(otherAthData)
  return PlayerDataCenter.allAthData:IsAthSuitConflict(self, otherAthData)
end

function ArithmeticData:GetAthSuitConflictId()
  return self.athCfg.conflict
end

function ArithmeticData:GetAthDataSuitNum()
  local suitCfg = ConfigData.ath_suit[self.athCfg.suit]
  if suitCfg == nil then
    return 0
  end
  return #suitCfg
end

function ArithmeticData:GetAthSignHeroId()
  return self._signHeroId
end

function ArithmeticData:CanSignAth()
  if not FunctionUnlockMgr:ValidateUnlock(proto_csmsg_SystemFunctionID.SystemFunctionID_Algorithm_Sign) then
    return false
  end
  local strengthenEnable = AthEnum.StrengthenQuality == self:GetAthQuality() and self:GetAthSize() == 2
  if not strengthenEnable then
    return false
  end
  if self._signHeroId > 0 then
    return false
  end
  return true
end

function ArithmeticData:GetAthBindHeroId()
  local heroId = self.bindInfo and self.bindInfo.id or 0
  return heroId
end

return ArithmeticData
