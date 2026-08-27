local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivitySteinsGateMiniGameData = class("ActivitySteinsGateMiniGameData", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local TinyGameEnum = require("Game.TinyGames.TinyGameEnum")
local GameMashUpData = require("Game.ActivitySteinsGateMiniGame.Data.GameMashUpData")
local GameMashDownData = require("Game.ActivitySteinsGateMiniGame.Data.GameMashDownData")
local ActSGMiniGameEnum = require("Game.ActivitySteinsGateMiniGame.Data.ActSGMiniGameEnum")
local CurActType = ActivityFrameEnum.eActivityType.SteinsGateMiniGame

function ActivitySteinsGateMiniGameData:InitSteinsGateMiniGameData(msg)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self._mainCfg = ConfigData.activity_mashup_main[msg.actId]
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local tinyGames = activityFrameCtrl:GetTinyGameDataListByActFrameId(self:GetActFrameId())
  for i, data in pairs(tinyGames) do
    if data:GetTinyGameCat() == TinyGameEnum.eType.ballMerge then
      self.gameMashUpData = GameMashUpData.New(data:GetTinyGameUid(), data:GetTinyGameId(), data:GetTinyGameCat())
    elseif data:GetTinyGameCat() == TinyGameEnum.eType.mashdown then
      self.gameMashDownData = GameMashDownData.New(data:GetTinyGameUid(), data:GetTinyGameId(), data:GetTinyGameCat())
    end
  end
  self:RefreshRewardTaskData()
end

function ActivitySteinsGateMiniGameData:RefreshSGMiniGameTaskRedDot(rewardTaskData)
  local isPicked = rewardTaskData:IsPickedTaskReward()
  local isComplete = rewardTaskData:CheckComplete()
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    return
  end
  local childReddot = actRedDotNode:AddChild("RewardTask")
  local flag = isComplete and not isPicked
  local redDot = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redDot then
    childReddot:SetRedDotCount(redDot)
  end
end

function ActivitySteinsGateMiniGameData:RefreshRewardTaskData()
  local taskId = self:GetMashUpTaskId()
  self.rewardTaskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
  self:RefreshSGMiniGameTaskRedDot(self.rewardTaskData)
end

function ActivitySteinsGateMiniGameData:GetSteinsGateTinyGameData(gameType)
  if gameType == ActSGMiniGameEnum.GameType.MashUp then
    return self.gameMashUpData
  end
  return self.gameMashDownData
end

function ActivitySteinsGateMiniGameData:UpdateSteinsGateMiniGameData(msg)
end

function ActivitySteinsGateMiniGameData:FinishMashUpTask()
  local taskCtrl = ControllerManager:GetController(ControllerTypeId.Task)
  if self.rewardTaskData == nil then
    return
  end
  if self.rewardTaskData:CheckComplete() then
    taskCtrl:SendCommitQuestReward(self.rewardTaskData, true)
  end
end

function ActivitySteinsGateMiniGameData:GetSGMiniGameTaskRedDot()
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    return 0
  end
  local childReddot = actRedDotNode:AddChild("RewardTask")
  return childReddot:GetRedDotCount()
end

function ActivitySteinsGateMiniGameData:GetRewardTaskData()
  self:RefreshRewardTaskData()
  return self.rewardTaskData
end

function ActivitySteinsGateMiniGameData:GetMainCfg()
  return self._mainCfg
end

function ActivitySteinsGateMiniGameData:GetMashUpTaskId()
  return self._mainCfg.task_id
end

function ActivitySteinsGateMiniGameData:GetRewardItemId()
  return self._mainCfg.final_award
end

function ActivitySteinsGateMiniGameData:GetSGMiniGameTip()
  return self._mainCfg.rule_title, self._mainCfg.rule_des
end

function ActivitySteinsGateMiniGameData:GetActivityReddotNum()
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  return false, num
end

return ActivitySteinsGateMiniGameData
