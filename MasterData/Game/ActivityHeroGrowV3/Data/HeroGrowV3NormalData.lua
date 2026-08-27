local HeroGrowV3NormalData = class("HeroGrowV3NormalData")
local FmtEnum = require("Game.Formation.FmtEnum")
local HeroGrowV3Enum = require("Game.ActivityHeroGrowV3.Data.HeroGrowV3Enum")

function HeroGrowV3NormalData:ctor(normalCfg, actId)
  self.__normalCfg = normalCfg
  self.__actId = actId
  self.__moduleId = nil
  if self:GetHGV3NormalDataType() == HeroGrowV3Enum.HGV3NormalQuestType.officialTeam then
    self.__moduleId = proto_csmsg_SystemFunctionID.SystemFunctionID_herolite_normal
  elseif self:GetHGV3NormalDataType() == HeroGrowV3Enum.HGV3NormalQuestType.freeTeam then
    self.__moduleId = proto_csmsg_SystemFunctionID.SystemFunctionID_herolite_normal_free
  end
  self.__DunShowCfgDic = ConfigData.activity_herolite_dungeon_list[actId]
end

function HeroGrowV3NormalData:GetHGV3NormalDataType()
  return self.__normalCfg.tpye
end

function HeroGrowV3NormalData:GetHGV3NormalDataName()
  return LanguageUtil.GetLocaleText(self.__normalCfg.dungeon_name)
end

function HeroGrowV3NormalData:GetHGV3NormalDataDes()
  return LanguageUtil.GetLocaleText(self.__normalCfg.dungeon_des)
end

function HeroGrowV3NormalData:GetHGV3NormalDataTeamDes()
  return LanguageUtil.GetLocaleText(self.__normalCfg.team_des)
end

function HeroGrowV3NormalData:GetHGV3NormalDataRewards()
  return self.__normalCfg.main_reward
end

function HeroGrowV3NormalData:GetHGV3NormalLevels()
  return self.__normalCfg.stage_group_id
end

function HeroGrowV3NormalData:GetHGV3NormalDunLevelItemShowCfg(dunStagId)
  return self.__DunShowCfgDic[dunStagId]
end

function HeroGrowV3NormalData:GetHGV3DyncDunData()
  return PlayerDataCenter.dungeonDyncData:GetDungeonDyncData(self.__moduleId)
end

function HeroGrowV3NormalData:GetHGV3CurLvProgress()
  local DunDyncData = self:GetHGV3DyncDunData()
  if DunDyncData ~= nil then
    return DunDyncData.idx
  end
  return 0
end

function HeroGrowV3NormalData:GetHGV3StageIndex(dunStagId)
  local list = self:GetHGV3NormalLevels()
  return table.indexof(list, dunStagId)
end

function HeroGrowV3NormalData:GetHGV3IsRewardPicked(dunStagId)
  return PlayerDataCenter:GetTotalBattleTimes(dunStagId) > 0
end

function HeroGrowV3NormalData:GetHGVFirstClearRewards(dunStagId)
  local dungeonStageCfg = ConfigData.battle_dungeon[dunStagId]
  return dungeonStageCfg.first_reward_ids, dungeonStageCfg.first_reward_nums
end

function HeroGrowV3NormalData:GetHGV3ChipSuitLimitNum()
  return self.__normalCfg.chip_select_max
end

function HeroGrowV3NormalData:GetHGV3ChipSuitPool()
  return self.__normalCfg.chip_pool, self.__normalCfg.chip_quality
end

function HeroGrowV3NormalData:GetHGV3RecommendChipSuit()
  return self.__normalCfg.chipSuitRecommendDic
end

function HeroGrowV3NormalData:GetHGV3SuitNumDic()
  return self.__normalCfg.chipSuitNumMaxDic
end

function HeroGrowV3NormalData:GetHGV3SuitNumDicDungeonType()
  if self:GetHGV3NormalDataType() == HeroGrowV3Enum.HGV3NormalQuestType.officialTeam then
    return proto_csmsg_DungeonType.DungeonType_HeroLite
  elseif self:GetHGV3NormalDataType() == HeroGrowV3Enum.HGV3NormalQuestType.freeTeam then
    return proto_csmsg_DungeonType.DungeonType_HeroLiteFree
  end
end

function HeroGrowV3NormalData:GetHGV3FmtFromType()
  if self:GetHGV3NormalDataType() == HeroGrowV3Enum.HGV3NormalQuestType.officialTeam then
    return FmtEnum.eFmtFromModule.HGV3Normal
  elseif self:GetHGV3NormalDataType() == HeroGrowV3Enum.HGV3NormalQuestType.freeTeam then
    return FmtEnum.eFmtFromModule.HGV3NormalFree
  end
end

function HeroGrowV3NormalData:GetHGV3ModuleId()
  return self.__moduleId
end

return HeroGrowV3NormalData
