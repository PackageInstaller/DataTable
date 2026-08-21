local ChapterInfoCsv = require("csvdata.chapter_info")
local ActivityManager = class("ActivityManager")
local FormationCsv = require("csvdata.activity_formation")
local Activity_83_taskCsv = require("csvdata.activity_83_task")

function ActivityManager:IsFinishFormationPractice()
  local status = game.role.activityStatus["62"] or ""
  local t = ActivityManager:CheckFormationPractice(status, 1)
  if not t then
    return false
  end
  t = ActivityManager:CheckFormationPractice(status, 2)
  if not t then
    return false
  end
  return true
end

function ActivityManager:CheckFormationPractice(status, diifType)
  local data = FormationCsv[diifType][0]
  local cur = status:getv(data.group * 100, 0)
  if cur == -1 then
    return true
  end
  return false
end

function ActivityManager:GetActivity83Datas()
  local status = game.role.activityStatus["83"]
  local Datas = {}
  local IsUnlockPre = true
  for stage = 1, #Activity_83_taskCsv do
    local taskList = Activity_83_taskCsv[stage]
    local taskIndex = 0
    local isUnlockAll = true
    for i = 1, #taskList do
      local state = -1
      local data = {}
      data.task = taskList[i]
      taskIndex = stage * 100 + i
      state = status.taskStatus:getv(taskIndex, 0)
      local reward = data.task.award:toArray("=", true)
      data.rewardId = reward[1]
      data.rewardCount = reward[2]
      data.progressStr = TaskHelper.GetProgressStr(status.progress, data.task, taskIndex)
      data.canGet = state == 1 and true or false
      data.isFinishAll = state == -1 and true or false
      data.isUnlockPre = IsUnlockPre
      if data.canGet or data.isFinishAll then
        data.progressStr = ""
      end
      if not data.isFinishAll then
        IsUnlockPre = false
      end
      if not Datas[stage] then
        Datas[stage] = {}
      end
      Datas[stage][i] = data
    end
    if not isUnlockAll then
    end
  end
  return Datas
end

function ActivityManager:CheckActivity83Red()
  local Datas = ActivityManager:GetActivity83Datas()
  local status = game.role.activityStatus["83"]
  for x = 1, #Datas do
    local list = Datas[x]
    for y = 1, #list do
      local data = list[y]
      if data.isUnlockPre and data.canGet then
        return true
      end
    end
  end
  return false
end

return ActivityManager
