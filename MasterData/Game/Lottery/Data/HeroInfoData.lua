local HeroInfoData = class("HeroInfoData")
local HeroData = require("Game.PlayerData.Hero.HeroData")
local HeroTalentData = require("Game.HeroTalent.HeroTalentData")

function HeroInfoData:ctor()
end

function HeroInfoData:InitData(heroId)
  self.heroId = heroId
  self.heroCfg = ConfigData.hero_data[heroId]
  self.career = self.heroCfg.career
  self.camp = self.heroCfg.camp
  local dataDic = {}
  dataDic.basic = {
    id = self.heroId
  }
  dataDic.basic.potentialLvl = ConfigData.game_config.heroMaxPotential
  dataDic.basic.level = ConfigData.game_config.heroMaxLevel
  dataDic.basic.star = ConfigData.hero_rank.maxStar
  local isContain = PlayerDataCenter:ContainsHeroData(heroId)
  local name
  if isContain then
    local outsideHeroData = PlayerDataCenter:GetHeroData(heroId)
    name = outsideHeroData:GetHeroName(true)
  end
  dataDic.basic.name = name
  self.heroData = HeroData.New(dataDic)
  self.rankCfg = self.heroData.rankCfg
  self.heroData.isRemoveAllBounce = true
  self.__notHaveLegalSkin = nil
  self:RefreshData()
end

function HeroInfoData:GenMaxTalent()
  if ConfigData.buildinConfig.HeroTalentForbid then
    return
  end
  local talentCfg = ConfigData.hero_talent[self.heroId]
  if talentCfg == nil then
    error(" talent is NIL")
    return
  end
  local fackerTalent = HeroTalentData.CreateWithMaxLevel(talentCfg)
  self.heroData:BindHeroDataTalent(fackerTalent)
end

function HeroInfoData:GenSpecWeaopn()
  local weaponId = PlayerDataCenter.allSpecWeaponData:GetHeroSpecWeaponId(self.heroId)
  if 0 < (weaponId or 0) then
    local weaponData = PlayerDataCenter.allSpecWeaponData:CreateVistualMaxWeapon(weaponId)
    self.heroData:BindHeroSpecWeapon(weaponData)
    self.heroData:ReplaceHeroSkill()
  end
end

function HeroInfoData:RefreshData()
  self:UpdateSkin()
end

function HeroInfoData:UpdateSkin()
  self.skinId = PlayerDataCenter.skinData:DealNotSelfHaveHeroSkinOverraid(0, self.heroId)
  self.__notHaveLegalSkin = self.skinId == nil
  local skinCtr = ControllerManager:GetController(ControllerTypeId.Skin, true)
  self.resCfg = skinCtr:GetResModel(self.heroId, self.skinId)
end

function HeroInfoData:GetResPicName()
  return self.resCfg.src_id_pic or self.resCfg.res_Name
end

function HeroInfoData.GetHeroInfoMaxLevel(heroId, potential)
  local hero_max_potentialCfg = ConfigData.hero_potential[heroId][potential]
  if hero_max_potentialCfg == nil then
    return ConfigData.game_config.heroMaxLevel
  end
  return hero_max_potentialCfg.level_max
end

function HeroInfoData:GetHeroInfoIsNotHaveLegalSkin()
  return self.__notHaveLegalSkin
end

return HeroInfoData
