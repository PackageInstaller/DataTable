local base = require("Game.TinyGames.Common.TinyGameDataBase")
local TinyGameMussicSoundPlayData = class("TinyGameMussicSoundPlayData", base)
local eDynConfigData = require("Game.ConfigData.eDynConfigData")
local SectorEnum = require("Game.Sector.SectorEnum")

function TinyGameMussicSoundPlayData:ctor(uid, gameId, cat)
  base.ctor(self, uid, gameId, cat)
  ConfigData:LoadDynCfg(eDynConfigData.activity_instrument_main)
  ConfigData:LoadDynCfg(eDynConfigData.activity_instrument_reward)
  self.mainCfg = ConfigData.activity_instrument_main[gameId]
  self.rewardCfg = ConfigData.activity_instrument_reward[gameId]
  self:UpdateAchivDatas()
end

function TinyGameMussicSoundPlayData:UpdateAchivDatas()
  if self.rewardCfg == nil then
    return
  end
  local achivDatas = {}
  for id, cfg in pairs(self.rewardCfg) do
    local stateType
    if cfg.level <= self:GetTinyGameRewardGotLv() then
      stateType = SectorEnum.eSectorAchivState.Picked
    elseif cfg.point <= self:GetTinyGameRewardLevelPoint() then
      stateType = SectorEnum.eSectorAchivState.Completed
    else
      stateType = SectorEnum.eSectorAchivState.Normal
    end
    table.insert(achivDatas, {
      stcData = {
        activeId = self:GetTaskTokenItemId(),
        level = cfg.level,
        activeNum = cfg.point,
        rewardIds = cfg.rewardIds,
        rewardNums = cfg.rewardNums,
        type = 3
      },
      stateType = stateType
    })
  end
  self.achivDatas = achivDatas
end

function TinyGameMussicSoundPlayData:GetAchieveData()
  for _, achivData in ipairs(self.achivDatas) do
    local stateType
    if achivData.stcData.level <= self:GetTinyGameRewardGotLv() then
      stateType = SectorEnum.eSectorAchivState.Picked
    elseif achivData.stcData.activeNum <= self:GetTinyGameRewardLevelPoint() then
      stateType = SectorEnum.eSectorAchivState.Completed
    else
      stateType = SectorEnum.eSectorAchivState.Normal
    end
    achivData.stateType = stateType
  end
  return self.achivDatas
end

function TinyGameMussicSoundPlayData:GetActivityFrameId()
  return self._uid
end

function TinyGameMussicSoundPlayData:GetNextRewardCfg()
  if self.rewardCfg == nil then
    return nil
  end
  for index, reward in ipairs(self.rewardCfg) do
    if reward.point > self:GetTinyGameRewardLevelPoint() then
      return reward
    end
  end
  return self.rewardCfg[#self.rewardCfg]
end

function TinyGameMussicSoundPlayData:GetTaskTokenItemId()
  return self.mainCfg.task_item
end

function TinyGameMussicSoundPlayData:GetTaskType()
  return self.mainCfg.task_type
end

function TinyGameMussicSoundPlayData:UploadTinyGameScore(score, musicId, callback)
  local activityFrameNet = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  activityFrameNet:CS_TinyGame_Settle(self._uid, score, callback, musicId)
end

function TinyGameMussicSoundPlayData:GetTotalMusicScore()
  return self._gameData:GetTinyGameHighest()
end

function TinyGameMussicSoundPlayData:GetTinyGameSubLevelHistoryScore(musicId)
  if self._gameData.tiniGameSubLevelScoreMap ~= nil then
    return self._gameData.tiniGameSubLevelScoreMap[musicId] or 0
  end
end

function TinyGameMussicSoundPlayData:IsSoundPlayTaskComplete()
  local taskType = self:GetTaskType()
  local taskDataDic = PlayerDataCenter.allTaskData:GetTaskDataDicByType(taskType)
  for taskId, taskData in pairs(taskDataDic) do
    if taskData:CheckComplete() then
      return true
    end
  end
  return false
end

function TinyGameMussicSoundPlayData:IsSoundPlayAchieveComplete()
  local achieveDatas = self:GetAchieveData()
  for key, achieveData in pairs(achieveDatas) do
    if achieveData.stateType == SectorEnum.eSectorAchivState.Completed then
      return true
    end
  end
  return false
end

return TinyGameMussicSoundPlayData
