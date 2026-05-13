local ChapterInfoCsv = require("csvdata.chapter_info")
local ChapterPassTaskCsv = require("csvdata.chapter_pass_task")
local ChapterPassRewardCsv = require("csvdata.chapter_pass_reward")
local ChapterPassQuestionCsv = require("csvdata.chapter_pass_question")
local ItemCsv = require("csvdata.item")
local ChapterPassManager = class("ChapterPassManager")
local CarbonManager = require("app.models.CarbonManager")

function ChapterPassManager:getCardDatas(groupId)
  local tasks = ChapterPassTaskCsv[groupId]
  local cardDatas = {}
  local activityStatu = game.role.activityStatus["79"] or {}
  local taskStatus = activityStatu.taskStatus or ""
  local testStatus = activityStatu.testStatus or ""
  local rewardStatus = activityStatu.rewardStatus or ""
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
      local rewardCSV = ChapterPassRewardCsv[groupId][rewardId]
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

function ChapterPassManager:getQuestion(questionId)
  return ChapterPassQuestionCsv[questionId]
end

function ChapterPassManager:getRewardTaskId(groupId, mapStrNum)
  local activityStatu = game.role.activityStatus["79"] or {}
  local taskStatus = activityStatu.taskStatus or ""
  local taskGroup = ChapterPassTaskCsv[groupId]
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

function ChapterPassManager:getTaskProgressMax(groupId, mapStrNum)
  local canget, taskId = self:getRewardTaskId(groupId, mapStrNum)
  return ChapterPassTaskCsv[groupId][taskId].condition2
end

function ChapterPassManager:isUnlockGroup(groupId)
  if groupId <= 2 then
    return true
  end
  local activityStatu = game.role.activityStatus["79"] or {}
  local buyedGroup = activityStatu.buyedGroup or ""
  local buyed = buyedGroup:getv(groupId, 0)
  return 0 < buyed
end

function ChapterPassManager:getRandomRewardId(groupId)
  local activityStatu = game.role.activityStatus["79"] or {}
  local rewardStatus = activityStatu.rewardStatus or ""
  local firstId = (groupId - 1) * 10 + 1
  local poolData = {}
  local isFinishAll = true
  for i = firstId, firstId + 8 do
    poolData[i] = {}
    poolData[i].weight = 10
    local geted = rewardStatus:getv(i, 0)
    if geted == 0 then
      isFinishAll = false
    else
      poolData[i].weight = 0
    end
  end
  if isFinishAll then
    print("nothing in the pool")
    return
  end
  local randomId = math.randWeight(poolData, "weight")
  return randomId
end

function ChapterPassManager:checkRedPoint()
  for i = 1, 4 do
    local datas, chapterId = self:getCardDatas(i)
    local now = CarbonManager:getMapStar(chapterId)
    local canFinishNewTask = ChapterPassManager:getRewardTaskId(i, now)
    local isUnLockGroup = ChapterPassManager:isUnlockGroup(i)
    if canFinishNewTask and isUnLockGroup then
      return true
    end
    for k, v in pairs(datas) do
      if v.isgeted and not v.istested then
        return true
      end
    end
  end
  return false
end

return ChapterPassManager
