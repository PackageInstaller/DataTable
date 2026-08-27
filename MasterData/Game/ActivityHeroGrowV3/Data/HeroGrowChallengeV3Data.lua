local DungeonLevelBase = require("Game.DungeonCenter.Data.DungeonLevelBase")
local HeroGrowChallengeV3Data = class("HeroGrowChallengeV3Data", DungeonLevelBase)
local base = DungeonLevelBase
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function HeroGrowChallengeV3Data:ctor(stageId, levelCfg, maxScore, maxDamage)
  self.levelCfg = levelCfg
  self.maxScore = maxScore
  self.maxDamage = maxDamage
end

function HeroGrowChallengeV3Data:GetDungeonLevelPic()
  if self.levelCfg == nil then
    return ""
  end
  return self.levelCfg.dungeon_pic
end

function HeroGrowChallengeV3Data:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.HeroGrowChallenge
end

function HeroGrowChallengeV3Data:GetDungeonInfoDesc()
  if self.levelCfg == nil then
    return ""
  end
  return LanguageUtil.GetLocaleText(self.levelCfg.dungeon_des)
end

function HeroGrowChallengeV3Data:GetHeroGrowMaxScore()
  return self.maxScore
end

function HeroGrowChallengeV3Data:GetHeroGrowMaxDamage()
  return self.maxDamage
end

function HeroGrowChallengeV3Data:GetIsShowDunRank()
  return true
end

function HeroGrowChallengeV3Data:GetIsShowDamageNum()
  return true
end

return HeroGrowChallengeV3Data
