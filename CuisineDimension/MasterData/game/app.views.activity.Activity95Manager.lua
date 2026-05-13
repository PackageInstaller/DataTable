local Activity95TaskCsv = require("csvdata.activity_95_task")
local Activity95RewardCsv = require("csvdata.activity_95_reward")
local Activity95QuestionCsv = require("csvdata.activity_95_question")
local ItemCsv = require("csvdata.item")
local Activity95Manager = class("Activity95Manager")
local CarbonManager = require("app.models.CarbonManager")
local activityType = "95"
local activityType2 = "951"

function Activity95Manager:getCardDatas(mapId, groupId)
  local tasks = Activity95TaskCsv[mapId][groupId]
  local cardDatas = {}
  local activityT = activityType
  if 8 <= mapId then
    mapId = tostring(mapId)
    activityT = activityType2
  end
  local activityStatu = game.role.activityStatus[activityT] or {}
  local actMapData = activityStatu[mapId] or {}
  local taskStatus = actMapData.taskStatus or ""
  local testStatus = actMapData.testStatus or ""
  local rewardStatus = actMapData.rewardStatus or ""
  local chapterId = 0
  local posPool = {}
  for i = 1, 9 do
    posPool[i] = {}
    posPool[i].weight = 10
  end
  local taskReward = {}
  local rewardPos = {}
  for k, v in pairs(tasks) do
    local rewardId = taskStatus:getv(v.id, 0)
    if 0 < rewardId then
      taskReward[v.id] = rewardId
      local pos = rewardStatus:getv(rewardId, 0)
      rewardPos[rewardId] = pos
      posPool[pos].weight = 0
    end
  end
  for k, v in pairs(tasks) do
    chapterId = v.chapterId
    local data = {}
    data.id = v.id
    data.groupId = groupId
    local rewardId = taskReward[v.id]
    data.isgeted = rewardId and 0 < rewardId
    if data.isgeted then
      data.cardIndex = rewardPos[rewardId]
      local rewardCSV = Activity95RewardCsv[tonumber(mapId)][groupId][rewardId]
      data.reward = rewardCSV.reward:toArray("=", true)
      local itemId = data.reward[1]
      data.itemIconPath = ItemCsv[itemId].icon
      data.isHeadIcon = 1000 < itemId and itemId < 2000
    else
      data.cardIndex = math.randWeight(posPool, "weight")
      posPool[data.cardIndex].weight = 0
    end
    data.istested = 0 < testStatus:getv(v.id, 0)
    cardDatas[data.cardIndex] = data
  end
  self.cardDatas = cardDatas
  return cardDatas, chapterId
end

function Activity95Manager:getQuestion(mapId, questionId)
  return Activity95QuestionCsv[mapId][questionId]
end

function Activity95Manager:getRewardTaskId(mapId, groupId, mapStrNum)
  local activityT = activityType
  if 8 <= mapId then
    mapId = tostring(mapId)
    activityT = activityType2
  end
  local activityStatu = game.role.activityStatus[activityT] or {}
  local actMapData = activityStatu[mapId] or {}
  local taskStatus = actMapData.taskStatus or ""
  local taskGroup = Activity95TaskCsv[tonumber(mapId)][groupId]
  local firstId = (groupId - 1) * 10 + 1
  for i = firstId, firstId + 8 do
    local v = taskGroup[i]
    if mapStrNum >= v.condition2 then
      local isGeted = 0 < taskStatus:getv(v.id, 0)
      if not isGeted then
        return true, v.id
      end
    else
      return false, v.id
    end
  end
  return false, firstId + 8
end

function Activity95Manager:getTaskProgressMax(mapId, groupId, mapStrNum)
  local canget, taskId = self:getRewardTaskId(mapId, groupId, mapStrNum)
  return Activity95TaskCsv[tonumber(mapId)][groupId][taskId].condition2
end

function Activity95Manager:isUnlockGroup(mapId, groupId)
  if groupId <= 2 then
    return true
  end
  local activityT = activityType
  if 8 <= mapId then
    mapId = tostring(mapId)
    activityT = activityType2
  end
  local activityStatu = game.role.activityStatus[activityT] or {}
  local actMapData = activityStatu[mapId] or {}
  local buyedGroup = actMapData.buyedGroup or ""
  local buyed = buyedGroup:getv(groupId, 0)
  return 0 < buyed
end

function Activity95Manager:checkRedPoint()
  for index, value in pairs(globalCsv.Activity95MapIds) do
    if value == 1 then
      for i = 1, 4 do
        local datas, chapterId = self:getCardDatas(index, i)
        local now = CarbonManager:getMapStar(chapterId)
        local canFinishNewTask = Activity95Manager:getRewardTaskId(index, i, now)
        local isUnLockGroup = Activity95Manager:isUnlockGroup(index, i)
        if canFinishNewTask and isUnLockGroup then
          return true
        end
        for k, v in pairs(datas) do
          if v.isgeted and not v.istested then
            return true
          end
        end
      end
    end
  end
  return false
end

return Activity95Manager
