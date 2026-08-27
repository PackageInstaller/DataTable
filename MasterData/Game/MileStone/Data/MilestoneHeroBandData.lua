local MilestoneHeroBandData = class("MilestoneHeroBandData")
local MilestoneEnum = require("Game.MileStone.MilestoneEnum")
local TaskData = require("Game.Task.Data.TaskData")

function MilestoneHeroBandData:ctor(bandId, bandElemMsg)
  self.curScore = 0
  self.scoreMax = 0
  self.pickedScore = 0
  self.curStage = 0
  self.bandId = bandId
  local bandCfg = ConfigData.milestones_mile_band[bandId]
  if bandCfg == nil then
    error("Cant get milestones_mile_band,id:" .. tostring(bandId))
    return
  end
  self._bandCfg = bandCfg
  self:UpdateByMSBandMsg(bandElemMsg)
end

function MilestoneHeroBandData:UpdateByMSBandMsg(bandElemMsg)
  if bandElemMsg == nil then
    self.curScore = 0
    self.pickedScore = 0
  else
    self.curScore = bandElemMsg.score
    self.pickedScore = bandElemMsg.rewardScore
  end
  for k, score in ipairs(self._bandCfg.score) do
    if score > self.pickedScore or k == #self._bandCfg.score and self.pickedScore == score then
      self.curStage = k
      self.curScore = self.curScore - self.pickedScore
      self.scoreMax = score - self.pickedScore
      break
    end
  end
end

function MilestoneHeroBandData:GetMlstBandId()
  return self.bandId
end

function MilestoneHeroBandData:GetMlstBandName()
  return LanguageUtil.GetLocaleText(self._bandCfg.band_name)
end

function MilestoneHeroBandData:GetMlstBandHeroIdList()
  return self._bandCfg.hero_id
end

function MilestoneHeroBandData:GetMlstBandScoreId()
  return self._bandCfg.score_id
end

function MilestoneHeroBandData:GetMlstBandStage()
  return self.curStage
end

function MilestoneHeroBandData:GetMlstBandStageMax()
  return #self._bandCfg.score
end

function MilestoneHeroBandData:GetMlstBandScoreList()
  return self._bandCfg.score
end

function MilestoneHeroBandData:IsMlstBandStageComplete(stageId)
  local stageScore = self._bandCfg.score[stageId]
  return stageScore <= self.pickedScore
end

function MilestoneHeroBandData:GetMlstBandCurScore()
  return self.curScore
end

function MilestoneHeroBandData:GetMlstBandScoreMax()
  return self.scoreMax
end

function MilestoneHeroBandData:CanPickMlstBandStageReward()
  return self.scoreMax > 0 and self.curScore >= self.scoreMax
end

function MilestoneHeroBandData:GetMlstBandReawrd(stageId)
  local idKey = "reward" .. tostring(stageId) .. "Ids"
  local numKey = "reward" .. tostring(stageId) .. "Nums"
  if self._bandCfg[idKey] == nil or self._bandCfg[numKey] == nil then
    error("cant get band reward, stageId:" .. tostring(stageId))
    return table.emptytable, table.emptytable
  end
  return self._bandCfg[idKey], self._bandCfg[numKey]
end

function MilestoneHeroBandData:GetMlstBandCurTaskList()
  local taskDataList = {}
  local conditionTaskDic = ConfigData.milestones_mile_band.msBandTaskDic[self.bandId]
  for condition, taskIdList in pairs(conditionTaskDic) do
    for idx, taskId in ipairs(taskIdList) do
      if PlayerDataCenter.allTaskData.completedMilestoneTaskDic[taskId] then
        local taskCfg = ConfigData.task[taskId]
        if #taskCfg.next_task == 0 then
          local taskData = TaskData.CreatePickedTaskData(taskCfg)
          table.insert(taskDataList, taskData)
        end
      else
        local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
        if taskData and not taskData:IsPickedTaskReward() then
          table.insert(taskDataList, taskData)
        end
      end
    end
  end
  return taskDataList
end

function MilestoneHeroBandData:GetMlstBandCurTaskStateNum()
  local canPickRewardNum = 0
  local completeAll = true
  local conditionTaskDic = ConfigData.milestones_mile_band.msBandTaskDic[self.bandId]
  for condition, taskIdList in pairs(conditionTaskDic) do
    for idx, taskId in ipairs(taskIdList) do
      if PlayerDataCenter.allTaskData.completedMilestoneTaskDic[taskId] then
      else
        completeAll = false
        local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId)
        if taskData and not taskData:IsPickedTaskReward() and taskData:CheckComplete() then
          canPickRewardNum = canPickRewardNum + 1
        end
      end
    end
  end
  return canPickRewardNum, completeAll
end

return MilestoneHeroBandData
