local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivitySpring24Data = class("ActivitySpring24Data", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.Spring24
local ActivitySpring24Enum = require("Game.ActivitySpring24.Data.ActivitySpring24Enum")
local ActivitySpring24TreasureData = require("Game.ActivitySpring24.Data.ActivitySpring24TreasureData")
local ActLbUtil = require("Game.ActivityLobby.ActLbUtil")
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local ActDailyTaskData = require("Game.ActivityFrame.ActDailyTaskData")
local ActTermTaskDataOne = require("Game.ActivityFrame.ActTermTaskDataOne")

function ActivitySpring24Data:InitActData(msg)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self.mainCfg = ConfigData.activity_treasurehunt_main[msg.actId]
  self.treasureDetailCfg = ConfigData.activity_treasurehunt_treasure_detail[msg.actId]
  self.storyCfg = ConfigData.activity_treasurehunt_story[msg.actId]
  self.treasureData = ActivitySpring24TreasureData.New()
  self.treasureData:InitTreasureData(self.treasureDetailCfg, self)
  self:UpdateActData(msg)
  self:InitAllDigRewardAvg()
  self:__InitDailyTaskData()
  self:__InitTermTaskData()
  self:RefreshRedSpring24DailyTask()
  self:RefreshRedSpring24OnceTask()
  self:RefreshCollectFortuneRedDot()
end

function ActivitySpring24Data:UpdateActData(msg)
  self.treasureData:UpdateTreasureData(msg)
  self.nextRefreshTm = msg.nextFreshTm
  self:RefreshDigRewardRedDot()
end

function ActivitySpring24Data:RefreshDigRewardRedDot()
  local reddot = self:GetActivityReddot()
  local childReddot = reddot:AddChild(ActivitySpring24Enum.reddotType.DigReward)
  if reddot == nil then
    return
  end
  local isNowDigAll = self.treasureData:IsNowActSpring24TreasureDigAll()
  local flag = not isNowDigAll
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivitySpring24Data:GetActMainCfg()
  return self.mainCfg
end

function ActivitySpring24Data:GetActSpring24EggStoryId()
  return self.mainCfg.bonus_story_id
end

function ActivitySpring24Data:GetActTreasureCfg()
  return self.treasureDetailCfg
end

function ActivitySpring24Data:GetTreasureData()
  return self.treasureData
end

function ActivitySpring24Data:GetDigRewardGuideTipId()
  return self.mainCfg.treasure_guide
end

function ActivitySpring24Data:InitAllDigRewardAvg()
  local storyList = self:GetSurePlayedAvgList()
  local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay, true)
  local avgNetCtrl = NetworkManager:GetNetwork(NetworkTypeID.Avg)
  for i, storyId in pairs(storyList) do
    if not avgPlayCtrl:IsAvgPlayed(storyId) then
      avgPlayCtrl:RecordAvgPlayed(storyId)
      avgNetCtrl:CS_AVG_Complete(storyId, 1, nil)
    end
  end
end

function ActivitySpring24Data:GetSurePlayedAvgList()
  local storyList = {}
  local num = self.treasureData:GetNowDigRewardNum()
  for i, data in pairs(self.storyCfg) do
    if num >= data.treasure_count then
      table.insert(storyList, data.story_id)
    end
  end
  return storyList
end

function ActivitySpring24Data:CheckAndGetPlayAvg()
  local avgId
  local storyList = {}
  for i, data in pairs(self.storyCfg) do
    table.insert(storyList, data)
  end
  table.sort(storyList, function(dataA, dataB)
    return dataA.treasure_count < dataB.treasure_count
  end)
  local nowDigNum = self.treasureData:GetNowDigRewardNum()
  for id, cfg in ipairs(storyList) do
    if nowDigNum < cfg.treasure_count then
      break
    end
    local tempAvgId = cfg.story_id
    local avgPlayCtrl = ControllerManager:GetController(ControllerTypeId.AvgPlay)
    local played = avgPlayCtrl:IsAvgPlayed(tempAvgId)
    if not played then
      avgId = tempAvgId
    end
  end
  return avgId ~= nil, avgId
end

function ActivitySpring24Data:CheckPopNeed()
  local nowDigNum = self.treasureData:GetNowDigRewardNum()
  local num = self:GetPopNum()
  local maxRewardNum = self.treasureData:GetNowMaxRewardNum()
  if num == maxRewardNum then
    return false
  end
  if nowDigNum == maxRewardNum then
    return false
  end
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  saveUserData:SetTreasureHuntRecord(self:GetActId(), self.treasureData:GetNowMaxRewardNum())
  local dayNum = (self.mainCfg.total_limit - self.mainCfg.first_amount) / self.mainCfg.daily_amount
  local nowTime = PlayerDataCenter.timestamp
  if nowTime - self.mainCfg.first_daily_time > dayNum * 3600 * 24 then
    return false
  end
  return true
end

function ActivitySpring24Data:GetPopNum()
  local saveUserData = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  local num = saveUserData:GetTreasureHuntRecord(self:GetActId())
  return num
end

function ActivitySpring24Data:GetTreasurePos(objId)
  local id = ConfigData.activity_treasurehunt_treasure_detail.lobbyObj2Id[self:GetActId()][objId]
  local posDic = self.treasureDetailCfg[id].lobby_pos
  local pos = Vector3.Temp(posDic[1], 0, posDic[2])
  return pos
end

function ActivitySpring24Data:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(ActivitySpring24Enum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

function ActivitySpring24Data:__InitDailyTaskData()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dailyTaskData = actFrameCtrl:GetActDailyTaskData(self:GetActFrameId())
  if self._dailyTaskData == nil then
    self._dailyTaskData = ActDailyTaskData.New()
    self._dailyTaskData:InitActDailyTask(self:GetActFrameId())
  end
  local RefreshRedSpring24DailyTaskCallback = BindCallback(self, self.RefreshRedSpring24DailyTask)
  self._dailyTaskData:BindActDailyTaskCommitFunc(RefreshRedSpring24DailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskChangeFunc(RefreshRedSpring24DailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskExpireFunc(RefreshRedSpring24DailyTaskCallback)
  self._dailyTaskData:RegisterActDailyRefresh()
end

function ActivitySpring24Data:__InitTermTaskData()
  self._termTaskData = ActTermTaskDataOne.New()
  self._termTaskData:InitTermTask(self:GetActFrameId())
  local RefreshRedSpring24OnceTaskCallback = BindCallback(self, self.RefreshRedSpring24OnceTask)
  self._termTaskData:BindTeramTaskCommitFunc(RefreshRedSpring24OnceTaskCallback)
  self._termTaskData:BindTeramTaskUnlockFunc(RefreshRedSpring24OnceTaskCallback)
end

function ActivitySpring24Data:RefreshRedSpring24DailyTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  if self._dailyTaskData == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySpring24Enum.reddotType.DailyTask)
  local flag = self._dailyTaskData:IsExistDailyCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivitySpring24Data:RefreshRedSpring24OnceTask()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local childReddot = reddot:AddChild(ActivitySpring24Enum.reddotType.OnceTask)
  local flag = self._termTaskData:IsExistTermCompleteTask()
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivitySpring24Data:GetSpring24DailyTaskData()
  return self._dailyTaskData
end

function ActivitySpring24Data:GetSpring24TermTaskData()
  return self._termTaskData
end

function ActivitySpring24Data:RefreshCollectFortuneRedDot()
  local reddot = self:GetActivityReddot()
  local childReddot = reddot:AddChild(ActivitySpring24Enum.reddotType.CollectFortune)
  if reddot == nil then
    return
  end
  local collectFortuneCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCollectFortune, true)
  local data = collectFortuneCtrl:GetCollectFortuneData()
  local isCouldDraw = false
  if data ~= nil then
    isCouldDraw = data:GetActCollectFortuneIsCouldDraw()
  end
  local redCount = isCouldDraw and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

return ActivitySpring24Data
