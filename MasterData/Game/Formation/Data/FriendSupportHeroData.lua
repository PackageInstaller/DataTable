local base = require("Game.PlayerData.Hero.HeroData")
local FriendSupportHeroData = class("FriendSupportHeroData", base)
local SkinEnum = require("Game.Skin.SkinEnum")
local attrIdOffset = 100

function FriendSupportHeroData:ctor(data)
  self.isFriendSupport = true
  self.athDic = {}
  self.athSkills = {}
  self.skillLevelDic = {}
  self.attrAddDic = {}
  self._defaultPow = nil
  self._pow = nil
  self.userInfo = nil
end

function FriendSupportHeroData.GenSupportHeroData(userInfoData, briefId, fixCfg)
  local supportHeroData = userInfoData:GetSupportHeroDataById(briefId)
  local assistsBrief = supportHeroData.assistsBrief
  local assistsRandom = supportHeroData.assistsRandom
  local data = FriendSupportHeroData.CreatSupportHeroDataBase(assistsBrief, assistsRandom, fixCfg)
  data.userInfo = userInfoData
  return data
end

function FriendSupportHeroData.CreatSupportHeroDataBase(assistsBrief, assistsRandom, fixCfg)
  local basic = {}
  local skillLevelData = {}
  basic.id = assistsBrief.id
  basic.level = assistsBrief.level
  basic.exp = 0
  basic.ts = nil
  basic.potentialLvl = assistsBrief.potential
  basic.archive = nil
  basic.audio = nil
  basic.star = assistsBrief.star
  basic.skinId = assistsBrief.skin
  basic.name = assistsBrief.name
  basic.vowed = assistsBrief.vowed
  if fixCfg ~= nil then
    basic.level = fixCfg.fixLv
    basic.potentialLvl = fixCfg.fixPotential
  end
  if assistsRandom ~= nil then
    skillLevelData = assistsRandom.skills
  end
  local fakeData = {}
  fakeData.basic = basic
  fakeData.skill = {}
  fakeData.skill.data = skillLevelData
  if assistsRandom ~= nil and assistsRandom.specWeapon ~= nil then
    fakeData.spWeapon = assistsRandom.specWeapon
  end
  local data = FriendSupportHeroData.New(fakeData)
  data._defaultPow = assistsBrief.power
  data.__fixCfg = fixCfg
  if fixCfg ~= nil then
    data.__fixAlgAttr = fixCfg.fixAlgAttr / 1000
  else
    data.__fixAlgAttr = 1
  end
  if fixCfg ~= nil then
    for skillId, skillData in pairs(data.skillDic) do
      if (skillData:IsNormalSkill() or skillData:IsPassiveSkill()) and fixCfg.fixSkillLv < skillData.level then
        skillData:UpdateSkill(fixCfg.fixSkillLv)
      end
    end
  end
  if assistsRandom ~= nil then
    data.skillLevelDic = assistsRandom.skills
    data.athDic = assistsRandom.athLoc
    data.athSkills = assistsRandom.athSkills
    data.talentSkillDic = assistsRandom.talentSkills
    data.attrAddDic = {}
    for attrId, attrVal in pairs(assistsRandom.athAttr) do
      data.attrAddDic[attrId] = attrVal
    end
    for attrId, attrVal in pairs(assistsRandom.talentAttr) do
      local count = data.attrAddDic[attrId] or 0
      data.attrAddDic[attrId] = count + attrVal
    end
  end
  data.isRemoveAllBounce = true
  data._assistsBrief = assistsBrief
  data._assistsRandom = assistsRandom
  data:CalSupporterPow()
  data:CalAthSuit(fixCfg)
  return data
end

function FriendSupportHeroData:OnSupporterLevelChange(level)
  self.level = level
  self:__UpdateBaseArriDic()
  self:CalSupporterPow()
end

function FriendSupportHeroData:CalSupporterPow()
  self._pow = self:GetFightingPower()
end

function FriendSupportHeroData:GetSupporterPow()
  return self._pow or 0
end

function FriendSupportHeroData:GetFightingPower(attrDic, fairyData)
  local power = base.GetFightingPower(self, attrDic, fairyData)
  power = power + self._assistsRandom.talentEfficiency
  return power
end

function FriendSupportHeroData:CalAthSuit(fixCfg)
  local suitDic = {}
  if fixCfg ~= nil and fixCfg.fixAlgSuit <= 0 then
    self.athSuitDic = suitDic
    return
  end
  for _, athId in pairs(self.athDic) do
    local athCfg = ConfigData.arithmetic[athId]
    if athCfg ~= nil then
      local suitId = athCfg.suit
      if (suitId or 0) ~= 0 then
        local count = suitDic[suitId] or 0
        suitDic[suitId] = count + 1
      end
    end
  end
  for suitId, count in pairs(suitDic) do
    local athSuitCfg = ConfigData.ath_suit[suitId]
    if count < athSuitCfg[1].num then
      suitDic[suitId] = nil
    end
  end
  self.athSuitDic = suitDic
end

function FriendSupportHeroData:GetAthSlotInfo(index)
  local res = {}
  for key, athId in pairs(self.athDic) do
    local tempIndex = key >> 16
    if tempIndex == index then
      local slot = key & 65535
      res[slot] = athId
    end
  end
  return res
end

function FriendSupportHeroData:GetAthSuit()
  return self.athSuitDic
end

function FriendSupportHeroData:GetSkillFightingPower(heroPower)
  local fightingPower = 0
  for skillId, skillLevel in pairs(self.athSkills) do
    local battleCfg = ConfigData.battle_skill[skillId]
    fightingPower = PlayerDataCenter:GetBattleSkillFightPower(skillId, skillLevel, heroPower) + fightingPower
  end
  return base.GetSkillFightingPower(self, heroPower) + fightingPower
end

function FriendSupportHeroData:GetUserInfo()
  return self.userInfo
end

function FriendSupportHeroData:UseFixCfg2ChangeSupportorAttr(fixCfg)
  if self.__fixCfg ~= fixCfg then
  else
    return
  end
  local fakeData = {
    basic = {
      level = fixCfg.fixLv,
      potentialLvl = fixCfg.fixPotential
    }
  }
  self:UpdateHeroData(fakeData)
  for skillId, skillData in pairs(self.skillDic) do
    if (skillData:IsNormalSkill() or skillData:IsPassiveSkill()) and fixCfg.fixSkillLv < skillData.level then
      skillData:UpdateSkill(fixCfg.fixSkillLv)
    end
  end
  self:CalSupporterPow()
end

function FriendSupportHeroData:__CalBaseAttr(attrId, withoutAth, athHeroId)
  local baseAttrId = attrId + attrIdOffset
  local specWeaponDic = self._specWeaponDic
  self._specWeaponDic = nil
  local res = base.__CalBaseAttr(self, attrId, withoutAth, athHeroId) + math.floor((self.attrAddDic[baseAttrId] or 0) * self.__fixAlgAttr)
  self._specWeaponDic = specWeaponDic
  return res
end

function FriendSupportHeroData:__CalRatioAttr(atrValue, attrId, withoutAth, athHeroId)
  local ratioAttrId = attrId + attrIdOffset * 2
  local specWeaponDic = self._specWeaponDic
  self._specWeaponDic = nil
  local res = base.__CalRatioAttr(self, atrValue, attrId, withoutAth, athHeroId, math.floor((self.attrAddDic[ratioAttrId] or 0) * self.__fixAlgAttr))
  self._specWeaponDic = specWeaponDic
  return res
end

function FriendSupportHeroData:__CalExtraAttr(atrValue, attrId, withoutAth, athHeroId)
  local specWeaponDic = self._specWeaponDic
  self._specWeaponDic = nil
  local res = base.__CalExtraAttr(self, atrValue, attrId, withoutAth, athHeroId) + math.floor((self.attrAddDic[attrId] or 0) * self.__fixAlgAttr)
  self._specWeaponDic = specWeaponDic
  return res
end

function FriendSupportHeroData:GetMaxPotential()
  return math.max(5, self.potential)
end

function FriendSupportHeroData:GetSkinResFromWhere()
  return SkinEnum.fromWhere.otherPlayerHero
end

function FriendSupportHeroData:GetAthSlotList(isFull)
  return base.GetAthSlotList(self, isFull, self._assistsBrief.star, self._assistsBrief.potential, self._assistsBrief.level)
end

function FriendSupportHeroData:GetSupportHerotalentLevel()
  return self._assistsBrief.talent or 0
end

function FriendSupportHeroData:GetHeroName(flag)
  if string.IsNullOrEmpty(self._assistsBrief.name) then
    return base.GetHeroName(self, flag)
  end
  return self._assistsBrief.name
end

function FriendSupportHeroData:GetHeroIsVowed()
  return self._assistsBrief.vowed
end

return FriendSupportHeroData
