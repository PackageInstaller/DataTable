local AttributeBonus = class("AttributeBonus")

function AttributeBonus:ctor()
  self._attriMetatable = {
    __index = function(tab, key)
      return 0
    end
  }
  self._nestMetatable = {
    __index = function(tab, key)
      tab[key] = setmetatable({}, self._attriMetatable)
      return tab[key]
    end
  }
  self.camp = setmetatable({}, self._nestMetatable)
  self.career = setmetatable({}, self._nestMetatable)
  self.allHero = setmetatable({}, self._attriMetatable)
  self.heroAth = {}
  self.SingleHeroBonus = {}
end

function AttributeBonus:AddCampBonus(campId, attrId, attrValue)
  local bonus = self.camp[campId]
  bonus[attrId] = bonus[attrId] + attrValue
end

function AttributeBonus:AddCareerBonus(careerId, attrId, attrValue)
  local bonus = self.career[careerId]
  bonus[attrId] = bonus[attrId] + attrValue
end

function AttributeBonus:AddAllBonus(attrId, attrValue)
  local bonus = self.allHero
  bonus[attrId] = bonus[attrId] + attrValue
end

function AttributeBonus:RemoveCampBonus(campId, attrId, attrValue)
  local bonus = self.camp[campId]
  bonus[attrId] = bonus[attrId] - attrValue
end

function AttributeBonus:RemoveCareerBonus(careerId, attrId, attrValue)
  local bonus = self.career[careerId]
  bonus[attrId] = bonus[attrId] - attrValue
end

function AttributeBonus:RemoveAllBonus(attrId, attrValue)
  local bonus = self.allHero
  bonus[attrId] = bonus[attrId] - attrValue
end

function AttributeBonus:GetHeroAthBonus(heroId)
  if heroId == nil then
    return table.emptytable
  end
  local athBonus = self.heroAth[heroId]
  if athBonus == nil then
    athBonus = PlayerDataCenter.allAthData:GetHeroAthAttr(heroId)
    self.heroAth[heroId] = athBonus
  end
  return athBonus
end

function AttributeBonus:DirtyHeroAthBonus(heroId)
  self.heroAth[heroId] = nil
  MsgCenter:Broadcast(eMsgEventId.OnHeroAthChange, heroId)
end

function AttributeBonus:SetSingleHroeBonus(heroId, attrId, value)
  if self.SingleHeroBonus[heroId] == nil then
    self.SingleHeroBonus[heroId] = {}
  end
  if self.SingleHeroBonus[heroId][attrId] == nil then
    self.SingleHeroBonus[heroId][attrId] = value
  else
    self.SingleHeroBonus[heroId][attrId] = self.SingleHeroBonus[heroId][attrId] + value
  end
end

function AttributeBonus:__GetSingleHroeBonus(heroId, attrId)
  if self.SingleHeroBonus[heroId] == nil then
    return 0
  end
  if self.SingleHeroBonus[heroId][attrId] == nil then
    return 0
  end
  return self.SingleHeroBonus[heroId][attrId]
end

function AttributeBonus:GetAtrBonus(attrId, campId, careerId, athHeroId)
  local athBonusDic = self:GetHeroAthBonus(athHeroId)
  local singleHeroBonus = self:__GetSingleHroeBonus(athHeroId, attrId)
  local bonus = self.allHero[attrId] + self.camp[campId][attrId] + self.career[careerId][attrId] + (athBonusDic[attrId] or 0) + singleHeroBonus
  return bonus
end

function AttributeBonus:AtrBonusAdd(isRemoveAllBounce, attrValue, baseAttrId, attrId, campId, careerId, athHeroId, heroStarExtraValue)
  local atrCfg = ConfigData.attribute[attrId]
  if atrCfg == nil then
    return 0
  end
  local baseAtrCfg = ConfigData.attribute[baseAttrId]
  if baseAtrCfg == nil then
    return 0
  end
  local bonus
  if isRemoveAllBounce or PlayerDataCenter.heroDic[athHeroId] == nil then
    bonus = 0
    bonus = bonus + (heroStarExtraValue or 0)
  else
    bonus = self:GetAtrBonus(attrId, campId, careerId, athHeroId)
    bonus = bonus + (heroStarExtraValue or 0)
  end
  if atrCfg.num_type == 1 or baseAtrCfg.num_type == 2 then
    attrValue = attrValue + bonus
  else
    attrValue = attrValue * (1000 + bonus) // 1000
  end
  return attrValue
end

return AttributeBonus
