local base = require("Game.DungeonCenter.Data.DungeonLevelBase")
local SectorIIChallengeDgData = class("SectorIIChallengeDgData", base)
local DungeonLevelEnum = require("Game.DungeonCenter.DungeonLevelEnum")

function SectorIIChallengeDgData:ctor(stageId, activitySectorIIData)
  self._actvSectorIIData = activitySectorIIData
  self._winterCfg = activitySectorIIData:GetActvWinterCfg()
  self._lvTypeCfg = ConfigData.activity_winter_level_type[self._winterCfg.id][self._winterCfg.hard_level_type]
  self.__ActivityWinterCfg = ConfigData.activity_winter_dungeon_detail[stageId]
end

function SectorIIChallengeDgData:GetDungeonLevelStageId()
  local winChallengeDyncDgData = PlayerDataCenter.dungeonDyncData:GetWinterChallengeDgDyncData()
  local curIdx = winChallengeDyncDgData.idx + 1
  local stageId = self._lvTypeCfg.dungeon_levels[curIdx]
  if stageId == nil then
    error("Cant get stageId, curIdx = " .. tostring(curIdx))
  end
  return stageId
end

function SectorIIChallengeDgData:GetDungeonLevelType()
  return DungeonLevelEnum.DunLevelType.SectorIIChallenge
end

function SectorIIChallengeDgData:GetDungeonInfoDesc()
  return LanguageUtil.GetLocaleText(self.__ActivityWinterCfg.level_des)
end

function SectorIIChallengeDgData:GetDungeonLevelPic()
  return self.__ActivityWinterCfg.level_pic
end

function SectorIIChallengeDgData:GetEnterLevelCost()
  return self._winterCfg.cost_id
end

function SectorIIChallengeDgData:GetConsumeKeyNum()
  return 0
end

function SectorIIChallengeDgData:GetLevelUnlockConditionCfg()
  local cfg = self._winterCfg
  return cfg.hard_pre_condition, cfg.pre_para1, cfg.pre_para2
end

function SectorIIChallengeDgData:GetDungeonBuffListCfg()
  if self.__chipTable == nil then
    self.__chipTable = {}
    local dic = {}
    for _, stageId in pairs(self._lvTypeCfg.dungeon_levels) do
      local stageCfg = ConfigData.battle_dungeon[stageId]
      if stageCfg ~= nil and stageCfg.protocol ~= nil then
        for _, buffID in pairs(stageCfg.protocol) do
          dic[buffID] = true
        end
      end
    end
    for buffID, _ in pairs(dic) do
      table.insert(self.__chipTable, buffID)
    end
  end
  return self.__chipTable
end

function SectorIIChallengeDgData:GetIsLevelUnlock()
  return CheckCondition.CheckLua(self:GetLevelUnlockConditionCfg())
end

function SectorIIChallengeDgData:GetSctIIChallengeDgLvNum()
  local lvTypeCfg = self:GetActvWinChallengeLvTypeCfg()
  return #lvTypeCfg.dungeon_levels
end

function SectorIIChallengeDgData:GetSectorIIActivityData()
  return self._actvSectorIIData
end

function SectorIIChallengeDgData:GetActvWinChallengeLvTypeCfg()
  return self._lvTypeCfg
end

function SectorIIChallengeDgData:GetSectorIIChallengeLvPos()
  local lvTypeCfg = self:GetActvWinChallengeLvTypeCfg()
  local posConfig = ConfigData.activity_winter_level_pos
  if posConfig[lvTypeCfg.pos_id] ~= nil and posConfig[lvTypeCfg.pos_id][1] ~= nil then
    local posCfg = posConfig[lvTypeCfg.pos_id][1]
    return Vector2.New(posCfg.level_pos[1], posCfg.level_pos[2])
  end
  return Vector2.zero
end

function SectorIIChallengeDgData:GetSectorIIChallengeRewardListCfg()
  local rewardCfg = ConfigData.activity_winter_challenge_award[self._actvSectorIIData.actId]
  return rewardCfg
end

function SectorIIChallengeDgData:UpdSctIIChallengeDgData(msgVerify)
  self._msgVerify = msgVerify or {
    curScore = 0,
    lastDungeonId = 0,
    maxScore = 0,
    historyMaxScore = 0
  }
end

function SectorIIChallengeDgData:GetSctIIChallengeDgScore()
  return self._msgVerify.curScore
end

function SectorIIChallengeDgData:GetSctIIChallengeDgMaxScore()
  return self._msgVerify.maxScore
end

function SectorIIChallengeDgData:GetSctIIChallengeDgHisMaxScore()
  return self._msgVerify.historyMaxScore
end

function SectorIIChallengeDgData:GetSctIIChallengeDgLastDungeonId()
  return self._msgVerify.lastDungeonId
end

function SectorIIChallengeDgData:GetSctIIChallengeDgSuitNumDic()
  local frameActId = self._actvSectorIIData:GetSectorIIActFrameId()
  local logicAddDic = PlayerDataCenter.playerBonus:Get_Activity_PowTestChipGroupLimitAdd(frameActId)
  local defaultNum = self._winterCfg.hard_chip_num
  local chipSuitNumDic = setmetatable({}, {
    __index = function(tab, key)
      return (logicAddDic[key] or 0) + defaultNum
    end
  })
  return chipSuitNumDic
end

function SectorIIChallengeDgData:GetSectorIIDun_ChipSuitLimitNum()
  local sectorIIData = self:GetSectorIIActivityData()
  local logicAdd = sectorIIData:GetSectorII_ChipSuitLimitNumAdd()
  local cfgNum = self.__ActivityWinterCfg.chip_select_max
  return cfgNum + logicAdd
end

function SectorIIChallengeDgData:GetSctIIChallengeDgRankId()
  local lvTypeCfg = self:GetActvWinChallengeLvTypeCfg()
  return lvTypeCfg.ranklist_id
end

function SectorIIChallengeDgData:GetSctIIChallengeDgStage()
  local dungeonDyncElemData = PlayerDataCenter.dungeonDyncData:GetWinterChallengeDgDyncData()
  if dungeonDyncElemData.isDailyDungeonNew then
    return false, false
  end
  local isFinish = dungeonDyncElemData.idx >= #self._lvTypeCfg.dungeon_levels
  local inDungeon = not isFinish
  return isFinish, inDungeon
end

function SectorIIChallengeDgData:IsSctIIChallengeDgLast(dungeonId)
  local maxNum = #self._lvTypeCfg.dungeon_levels
  if maxNum == 0 then
    return false
  end
  return dungeonId == self._lvTypeCfg.dungeon_levels[maxNum]
end

function SectorIIChallengeDgData:GetDunExtraBuffDic()
  local sectorIIData = self:GetSectorIIActivityData()
  if sectorIIData == nil then
    return nil
  end
  local actBuffUnlockDic = sectorIIData:GetSectorII_UnlockedBuffList()
  return actBuffUnlockDic
end

function SectorIIChallengeDgData:GetDunExtraDelectedBuffDic()
  local sectorIIData = self:GetSectorIIActivityData()
  if sectorIIData == nil then
    return nil
  end
  local actBuffRemoveDic = sectorIIData:GetSectorII_DelectedBuffList()
  return actBuffRemoveDic
end

function SectorIIChallengeDgData:GetIsShowDunRank()
  return true
end

return SectorIIChallengeDgData
