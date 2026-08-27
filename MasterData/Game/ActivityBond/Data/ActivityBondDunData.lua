local base = require("Game.DungeonCenter.Data.DungeonLevelBase")
local ActivityBondDunData = class("ActivityBondDunData", base)
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function ActivityBondDunData:ctor(dunId, dunGroupData)
  self.__bondDunCfg = ConfigData.activity_bond_dunlist[dunId]
  self.__dunGroupData = dunGroupData
  self.__levelScore = 0
end

function ActivityBondDunData:ActBond_RefreshDunByMsg(stageElemMsg)
  self.__levelScore = stageElemMsg.dungeonScore or 0
end

function ActivityBondDunData:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.Bond
end

function ActivityBondDunData:GetDungeonLevelPic()
  return self.__bondDunCfg.dungeon_pic
end

function ActivityBondDunData:GetBondBuff()
  return self.__dunGroupData:ActBond_GetTransferBuffId()
end

function ActivityBondDunData:GetDunGroupData()
  return self.__dunGroupData
end

function ActivityBondDunData:GetDungeonInfoDesc()
  return LanguageUtil.GetLocaleText(self.__bondDunCfg.dungeon_des)
end

function ActivityBondDunData:GetIsClear()
  local isCompleted = 0 < (PlayerDataCenter.dungeonTotalBattleTimes[self:GetDungeonLevelStageId()] or 0)
  return isCompleted
end

function ActivityBondDunData:GetBondDunType()
  return self.__bondDunCfg.is_infinite
end

function ActivityBondDunData:GetBondDunScore()
  return self.__levelScore
end

return ActivityBondDunData
