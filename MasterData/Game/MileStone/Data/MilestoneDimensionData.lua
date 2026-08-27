local MilestoneDimensionData = class("MilestoneDimensionData")
local MilestoneEnum = require("Game.MileStone.MilestoneEnum")
local TaskEnum = require("Game.Task.TaskEnum")

function MilestoneDimensionData:ctor(moduleId, moduleElemMsg)
  self.curStage = nil
  self.curScore = nil
  self.curScoreMax = nil
  self.pickedScore = nil
  self._moudleCfg = ConfigData.milestone_module[moduleId]
  self._rewardCfgList = ConfigData.milestones_module_reward[moduleId]
  self:UpdateByModuleMsg(moduleElemMsg)
end

function MilestoneDimensionData:UpdateByModuleMsg(moduleElem)
  if moduleElem == nil then
    self.curScore = 0
    self.pickedScore = 0
  else
    self.curScore = moduleElem.score
    self.pickedScore = moduleElem.rewardScore
  end
  for stage, rewardCfg in ipairs(self._rewardCfgList) do
    if self.pickedScore < rewardCfg.score or stage == #self._rewardCfgList and self.pickedScore == rewardCfg.score then
      self.curScoreMax = rewardCfg.score - self.pickedScore
      self.curScore = self.curScore - self.pickedScore
      self.curStage = rewardCfg.reward_level
      break
    end
  end
end

function MilestoneDimensionData:GetMlstDimensionId()
  return self._moudleCfg.id
end

function MilestoneDimensionData:GetMlstDimensionStage()
  return self.curStage
end

function MilestoneDimensionData:IsMlstDimensionCanPickStageReward()
  local isCouldPic = self.curScore >= self.curScoreMax and self.curScoreMax ~= 0
  return isCouldPic
end

function MilestoneDimensionData:GetMlstDimensionScore()
  return self.curScore
end

function MilestoneDimensionData:GetMlstDimensionScoreMax()
  return self.curScoreMax
end

function MilestoneDimensionData:IsMlstDimensionScoreMax()
  return self.curScoreMax == 0
end

function MilestoneDimensionData:GetMlstDimensionScoreProgress()
  if self.curScoreMax == 0 then
    return 1
  end
  return math.clamp(self.curScore / self.curScoreMax, 0, 1)
end

function MilestoneDimensionData:GetMlstDimensionPickedScore()
  return self.pickedScore
end

function MilestoneDimensionData:GetPickrewardScore4Stage(stageId)
  return self._rewardCfgList[stageId].score
end

function MilestoneDimensionData:GetPickrewardStageScore4Stage(stageId)
  if stageId == 1 then
    return self._rewardCfgList[stageId].score
  end
  return self._rewardCfgList[stageId].score - self._rewardCfgList[stageId - 1].score
end

function MilestoneDimensionData:GetMlstDimensionName()
  return LanguageUtil.GetLocaleText(self._moudleCfg.name)
end

function MilestoneDimensionData:GetMlstDimensionNameEn()
  return self._moudleCfg.name_eng
end

function MilestoneDimensionData:GetMlstDimensionIcon()
  return self._moudleCfg.icon
end

function MilestoneDimensionData:GetMlstDimensionScoreItemId()
  return self._moudleCfg.item_id
end

function MilestoneDimensionData:GetMlstDimensionTaskDataList()
  local moduleId = self:GetMlstDimensionId()
  local typeNum = #ConfigData.milestones_mile_task[moduleId]
  local dataList = {}
  for i = 1, typeNum do
    local taskType = TaskEnum.eTaskType.MilestoneTask + moduleId * 10 + typeNum
    local taskDic = PlayerDataCenter.allTaskData:GetTaskDataDicByType(taskType)
    for k, v in pairs(taskDic) do
      table.insert(dataList, v)
    end
  end
  return dataList
end

return MilestoneDimensionData
