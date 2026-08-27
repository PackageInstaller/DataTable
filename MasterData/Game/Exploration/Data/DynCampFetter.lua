local DynCampFetter = class("DynCampFetter")
local eCampFetterCoolDownType = require("Game.Exploration.ExplorationEnum").eCampFetterCoolDownType
local eCampFetterCDType = require("Game.Exploration.ExplorationEnum").eCampFetterCDType

function DynCampFetter:ctor(campId, campConCfg, campCount)
  self.campId = campId
  self.campConCfg = campConCfg
  self.campHeroNum = campCount or 0
  self.isActive = false
  self.activeId = nil
  self.couldUseActive = false
  self.activeCdValue = nil
  self:InitActiveFetterSkill()
end

function DynCampFetter:GetCampFetterCampId()
  return self.campId
end

function DynCampFetter:GetCampHeroNum()
  return self.campHeroNum
end

function DynCampFetter:InitActiveFetterSkill()
  self.isActive = self.campConCfg.is_active ~= 0 and self.campConCfg.is_show_active ~= 0
  if self.isActive then
    self.activeId = self.campConCfg.is_active
  end
end

function DynCampFetter:GetIsHaveActiveFetterSkill()
  return self.isActive
end

function DynCampFetter:GetActiveFetterSkillID()
  return self.activeId
end

function DynCampFetter:GetActiceFetterCDType()
  return self.campConCfg.cool_down_type
end

function DynCampFetter:GetActiveFetterUID()
  if not self.isActive then
    return nil
  end
  local uid = self.campId << 32 | self.campConCfg.fetters_num
  return uid, self.campId, self.campConCfg.fetters_num
end

function DynCampFetter:GetActiveFetterDes()
  if not self.isActive then
    return ""
  end
  return LanguageUtil.GetLocaleText(ConfigData.camp_active_skill[self:GetActiveFetterSkillID()].des)
end

function DynCampFetter:GetActiveFetterSkillCD(extraUID)
  if extraUID ~= nil then
    if self.extraCdValue == nil then
      return false
    else
      return self.extraCdValue[extraUID]
    end
  end
  return self.activeCdValue, self.campConCfg.cool_down_param - (self.activeCdValue or 1) + 1
end

function DynCampFetter:GetCouldeUseActiveFetterSkill(extraUID)
  if extraUID ~= nil then
    if self.couldUseExtraActive == nil then
      return false
    else
      return self.couldUseExtraActive[extraUID]
    end
  end
  return self.couldUseActive
end

function DynCampFetter:SetActiveValue(value, extraUID)
  if extraUID ~= nil then
    if self.couldUseExtraActive == nil then
      self.couldUseExtraActive = {}
      self.extraCdValue = {}
    end
    self.couldUseExtraActive[extraUID] = value <= 0
    self.extraCdValue[extraUID] = value
    return
  end
  if value <= 0 then
    self.couldUseActive = true
  else
    self.couldUseActive = false
  end
  self.activeCdValue = value
end

function DynCampFetter:GetAllCampFetter()
  local campFetterList = {}
  local usingNum = 0
  for _, unlockCount in ipairs(ConfigData.camp_connection.fetterList[self.campId]) do
    local isUsing = unlockCount <= self.campConCfg.fetters_num
    table.insert(campFetterList, {
      cfg = ConfigData.camp_connection[self.campId][unlockCount],
      isUsing = isUsing
    })
    if isUsing then
      usingNum = usingNum + 1
    end
  end
  return campFetterList, usingNum
end

return DynCampFetter
