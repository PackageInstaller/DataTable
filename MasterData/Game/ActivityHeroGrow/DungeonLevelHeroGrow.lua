local DungeonLevelBase = require("Game.DungeonCenter.Data.DungeonLevelBase")
local DungeonLevelHeroGrow = class("DungeonLevelHeroGrow", DungeonLevelBase)
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function DungeonLevelHeroGrow:SetDungeonHeroGrowAct(activityHeroData)
  self._activityHeroData = activityHeroData
  self._extraCfg = ConfigData.activity_hero_level_detail[self.__stageId]
end

function DungeonLevelHeroGrow:GetDungeonHeroGrowActId()
  return self._activityHeroData:GetActId()
end

function DungeonLevelHeroGrow:GetDungeonActName()
  return self._activityHeroData:GetActivityName()
end

function DungeonLevelHeroGrow:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.HeroGrow
end

function DungeonLevelHeroGrow:GetDungeonLevelName()
  return LanguageUtil.GetLocaleText(self.__dungeonStageCfg.name)
end

function DungeonLevelHeroGrow:GetDungeonInfoDesc()
  return LanguageUtil.GetLocaleText(self._extraCfg.level_des)
end

function DungeonLevelHeroGrow:GetDungeonLevelPic()
  return self._extraCfg.level_pic
end

function DungeonLevelBase:GetEnterLevelCost()
  local costId = self.__dungeonStageCfg.cost_itemIds[1]
  if costId == nil then
    costId = ConstGlobalItem.SKey
  end
  return costId
end

function DungeonLevelBase:GetConsumeKeyNum()
  local costNum = self.__dungeonStageCfg.cost_itemNums[1]
  if costNum == nil then
    costNum = 0
  end
  return costNum
end

function DungeonLevelHeroGrow:GetCouldShowAutoPlay()
  return true
end

function DungeonLevelHeroGrow:GetCommonActDropData()
  return self._extraCfg.drop_show
end

function DungeonLevelHeroGrow:GetIsLevelCompleteNoSup()
  local isCompleted = PlayerDataCenter.dungeonComplectedWhithoutSupport[self:GetDungeonLevelStageId()] or false
  return isCompleted
end

return DungeonLevelHeroGrow
