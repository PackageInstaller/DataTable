local base = require("Game.PlayerData.Hero.FixedFmtHeroData")
local OfficialSupportHeroData = class("OfficialSupportHeroData", base)

function OfficialSupportHeroData:ctor(data)
  self.isOfficialSupport = true
  self.__officialSupportCfgId = nil
end

function OfficialSupportHeroData.GenOfficialSupportHeroData(heroId, assisLvCfg, power, isBrotato)
  if assisLvCfg == nil then
    error("assisLvCfg is nil")
  end
  local heroData = base._GenHeroDataBase(OfficialSupportHeroData, heroId, assisLvCfg)
  if isBrotato and heroData.heroCfg ~= nil then
    heroData.skinId = heroData.heroCfg.default_skin
  end
  heroData.__power = power
  return heroData
end

function OfficialSupportHeroData:SetOfficialSupportCfgId(officialSupportCfgId)
  self.__officialSupportCfgId = officialSupportCfgId
end

function OfficialSupportHeroData:GetOfficialSupportCfgId()
  return self.__officialSupportCfgId
end

function OfficialSupportHeroData:AbleUpLevel()
  return false
end

function OfficialSupportHeroData:GenHeroCanQuickLevelUp()
  return false
end

function OfficialSupportHeroData:AbleUpgradeStar()
  return false
end

function OfficialSupportHeroData:AbleUpgrade2FullStar()
  return false, false
end

function OfficialSupportHeroData:GetFightingPower(attrDic, fairyData)
  return self.__power or base.GetFightingPower(self, attrDic, fairyData)
end

return OfficialSupportHeroData
