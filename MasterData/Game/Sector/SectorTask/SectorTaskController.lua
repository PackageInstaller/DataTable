local SectorTaskController = class("SectorTaskController", ControllerBase)
local TaskEnum = require("Game.Task.TaskEnum")
local SectorEnum = require("Game.Sector.SectorEnum")
local TaskData = require("Game.Task.Data.TaskData")
local cs_MessageCommon = CS.MessageCommon

function SectorTaskController:OnInit()
end

function SectorTaskController:GetSectorTaskDatas(sectorId)
  local sectorCfg = ConfigData.sector[sectorId]
  local taskDatas = PlayerDataCenter.allTaskData.sectorTaskDatas[sectorCfg.achievement]
  local taskDataKist = {}
  for _, taskData in pairs(taskDatas) do
    if taskData:CheckComplete() then
      taskData.state = TaskEnum.eTaskState.Completed
    elseif PlayerDataCenter.sectorAchievementDatas:GetIsComplete(sectorId, taskData.id) then
      taskData.state = TaskEnum.eTaskState.Picked
    else
      taskData.state = TaskEnum.eTaskState.InProgress
    end
    table.insert(taskDataKist, taskData)
  end
  local completedTasks = PlayerDataCenter.sectorAchievementDatas:GetCompletedTask(sectorId)
  if completedTasks ~= nil then
    for taskId, _ in pairs(completedTasks) do
      local stcData = ConfigData.task[taskId]
      if taskDatas[taskId] == nil and stcData ~= nil and stcData.type == sectorCfg.achievement then
        table.insert(taskDataKist, TaskData.CreatePickedTaskData(stcData))
      end
    end
  end
  table.sort(taskDataKist, function(a, b)
    if a.state == b.state then
      return a.id < b.id
    elseif a.state == TaskEnum.eTaskState.Completed then
      return true
    elseif b.state == TaskEnum.eTaskState.Completed then
      return false
    elseif a.state == TaskEnum.eTaskState.InProgress then
      return true
    elseif b.state == TaskEnum.eTaskState.InProgress then
      return false
    end
  end)
  return taskDataKist
end

function SectorTaskController:GetSectorAchievementDatas(sectorId)
  local sectorAchivDatas = {}
  local sectorAchieveCfgs = ConfigData.sectorAchievement[sectorId]
  if sectorAchieveCfgs == nil then
    return sectorAchivDatas
  end
  for id, cfg in pairs(sectorAchieveCfgs) do
    local state
    if PlayerDataCenter.sectorAchievementDatas:GetIsPicked(sectorId, id) then
      state = SectorEnum.eSectorAchivState.Picked
    elseif PlayerDataCenter.sectorAchievementDatas:CheckAchivCondition(cfg) then
      state = SectorEnum.eSectorAchivState.Completed
    else
      state = SectorEnum.eSectorAchivState.Normal
    end
    table.insert(sectorAchivDatas, {achiveCfg = cfg, state = state})
  end
  return sectorAchivDatas
end

function SectorTaskController:GetSectorAchievementScore(sectorId)
  local sectorAchieveCfgs = ConfigData.sectorAchievement[sectorId]
  if sectorAchieveCfgs == nil then
    return 0, 0, 0
  end
  local starId = sectorAchieveCfgs[1].conditionIds[1]
  local starCount = PlayerDataCenter:GetItemCount(starId)
  local starTotalCount = sectorAchieveCfgs[#sectorAchieveCfgs].conditionNums[1]
  return starId, starCount, starTotalCount
end

function SectorTaskController:GetSectorTaskTotalCount(starId, sectorId)
  local totalCount = 0
  local taskDatas = self:GetSectorTaskDatas(sectorId)
  if taskDatas == nil then
    return 0
  end
  for _, taskData in ipairs(taskDatas) do
    local starIdIndex = table.indexof(taskData.stcData.rewardIds, starId)
    if starIdIndex then
      totalCount = totalCount + taskData.stcData.rewardNums[starIdIndex]
    end
  end
  return totalCount
end

function SectorTaskController:OnDelete()
end

return SectorTaskController
