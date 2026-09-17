local this = {}
local activityTpl = L_GameTpl:getActivityTpl()
local activityRewardTpl = L_GameTpl:getActivityRewardTpl()

function this:init()
  this.super.init(self)
  self.data = {
    activityTaskList = {},
    activityRewardList = {},
    activityGroupTaskList = {},
    csvDairyActivityTaskList = {},
    csvWeekActivityTaskList = {},
    csvDairyActivityRewardList = {},
    csvWeekActivityRewardList = {},
    csvAllActivityTaskList = {},
    csvAllActivityRewardList = {},
    todayActivityValue = 0,
    weekActivityValue = 0
  }
  self:initCsvData()
end

function this:state()
  return {}
end

function this:initCsvData()
  self.data.csvDairyActivityTaskList = activityTpl:getAllData(1)
  self.data.csvWeekActivityTaskList = activityTpl:getAllData(2)
  self.data.csvDairyActivityRewardList = activityRewardTpl:getAllData(1)
  self.data.csvWeekActivityRewardList = activityRewardTpl:getAllData(2)
  self.data.csvAllActivityTaskList = activityTpl:getAllData()
  self.data.csvAllActivityRewardList = activityRewardTpl:getAllData()
  for i, v in pairs(self.data.csvAllActivityTaskList) do
    local id = activityTpl:getId(v)
    local entity = self.data.activityTaskList[id]
    if entity == nil then
      entity = require(L_R.store .. "activityTask.data.activityTaskItem").new()
      self.data.activityTaskList[id] = entity
      entity.id = id
      entity.groupId = activityTpl:getGroupId(v)
      entity.finishState = 0
      entity.count = 0
      entity.targetCount = activityTpl:getPara(v)
      entity.describe = string.format("" .. activityTpl:getDescription(v), tostring(activityTpl:getPara(v)))
      entity.reward = activityTpl:getReward(v)
      entity.groupOrder = activityTpl:getGroupOrder(v)
      entity.taskType = activityTpl:getTaskType(v)
      entity.itemReward = activityTpl:getActivityRewardDisplay(v)
      entity.systemId = activityTpl:getSystemJump(v)
      entity.unlockSystemId = activityTpl:getUnlockSystemId(v)
    end
  end
  for i, v in pairs(self.data.csvAllActivityRewardList) do
    local id = activityRewardTpl:getId(v)
    local entity = self.data.activityRewardList[id]
    if entity == nil then
      entity = require(L_R.store .. "activityTask.data.activityRewardItem").new()
      self.data.activityRewardList[id] = entity
      entity.id = id
      entity.canReward = 0
      entity.count = 0
      entity.requireActivity = activityRewardTpl:getRequireActivity(v)
      entity.isFinish = false
      entity.taskType = activityRewardTpl:getTaskType(v)
      entity.reward = activityRewardTpl:getReward(v)
    end
  end
  for i, v in pairs(self.data.csvAllActivityTaskList) do
    local groupId = activityTpl:getGroupId(v)
    local entity = self.data.activityGroupTaskList[groupId]
    if entity == nil then
      local entity = self:getActivityGroupItem(groupId, true)
      entity.count = 0
      entity.curActivityId = activityTpl:getId(v)
      entity.finishState = 0
      entity.child = {}
      self:getActivityGroupChildItem(entity, 1)
    end
  end
end

function this:getActivityGroupTaskList()
  return self.data.activityGroupTaskList
end

function this:getActivityRewardList()
  return self.data.activityRewardList
end

function this:getTodayActivityValue()
  return self.data.todayActivityValue
end

function this:getWeekActivityValue()
  return self.data.weekActivityValue
end

function this:getActivityGroupItem(activityGroupId, isCreate)
  local entity = self.data.activityGroupTaskList[activityGroupId]
  if entity == nil and isCreate then
    entity = require(L_R.store .. "activityTask.data.activityGroupItem").new()
    self.data.activityGroupTaskList[activityGroupId] = entity
    entity.groupId = activityGroupId
  end
  return entity
end

function this:getActivityTaskItem(activityId, isCreate)
  local entity = self.data.activityTaskList[activityId]
  if entity == nil and isCreate then
    entity = require(L_R.store .. "activityTask.data.activityTaskItem").new()
    self.data.activityTaskList[activityId] = entity
    entity.activityId = activityId
  end
  return entity
end

function this:getActivityGroupChildItem(entity, isFinish)
  local groupId = entity.groupId
  local data = {}
  for i, v in pairs(self.data.activityTaskList) do
    if v.groupId == groupId then
      table.insert(data, v)
    end
  end
  table.sort(data, function(a, b)
    return a.groupOrder < b.groupOrder
  end)
  entity.taskType = activityTpl:getTaskType(activityTpl:getTplById(entity.curActivityId))
  entity.maxStage = #data
  entity.maxCount = data[#data].targetCount
  if isFinish ~= nil and isFinish == 1 then
    for i, v in ipairs(data) do
      table.insert(entity.child, v)
    end
    entity.count = entity.child[#data].targetCount
    entity.curStage = #data + 1
    entity.finishState = 1
  else
    entity.curStage = 1
    for i, v in ipairs(data) do
      if entity.count >= v.targetCount then
        entity.curStage = entity.curStage + 1
      end
      table.insert(entity.child, v)
    end
    entity.finishState = entity.curStage > entity.maxStage and 1 or 0
  end
end

function this:getServerDataActivityTask(entity)
  entity.finishState = entity.count >= entity.targetCount and 1 or 0
end

function this:getActivityRewardItem(activityRewardId)
  local entity = self.data.activityRewardList[activityRewardId]
  return entity
end

function this:getActivityTaskGroupByIndex(index)
  local data = {}
  for i, v in pairs(self.data.activityTaskList) do
    if v.taskType == index then
      table.insert(data, v)
    end
  end
  table.sort(data, function(a, b)
    if a.finishState == b.finishState then
      return a.id < b.id
    elseif a.finishState == 1 then
      return true
    elseif b.finishState == 1 then
      return false
    else
      return a.finishState < b.finishState
    end
  end)
  return data
end

function this:getActivityRewardListByIndex(index)
  local data = {}
  for i, v in pairs(self.data.activityRewardList) do
    if v.taskType == index then
      if index == 1 then
        if v.requireActivity <= self.data.todayActivityValue then
          v.canReward = 1
        end
        v.curTotalActivity = self.data.todayActivityValue
      else
        if v.requireActivity <= self.data.weekActivityValue then
          v.canReward = 1
        end
        v.curTotalActivity = self.data.weekActivityValue
      end
      table.insert(data, v)
    end
  end
  table.sort(data, function(a, b)
    return a.requireActivity < b.requireActivity
  end)
  return data
end

return this
