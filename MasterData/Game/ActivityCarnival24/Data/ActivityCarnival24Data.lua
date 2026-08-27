local ActivityBase = require("Game.ActivityFrame.ActivityBase")
local ActivityCarnival24Data = class("ActivityCarnival24Data", ActivityBase)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.Carnival24
local ActivityCarnival24Enum = require("Game.ActivityCarnival24.Data.ActivityCarnival24Enum")
local ActMonsterCardPlayData = require("Game.ActivityFrame.ActivityMonsterCard.ActMonsterCardPlayData")
local ActDailyTaskData = require("Game.ActivityFrame.ActDailyTaskData")
local ActCommonRewardBpData = require("Game.ActivityFrame.ActCommonRewardBp.ActCommonRewardBpData")
local ActTermTaskDataMul = require("Game.ActivityFrame.ActTermTaskDataMul")
local eDemandState = require("Game.Task.TaskEnum").eTaskState
local EpCommonModeSelectUtil = require("Game.CommonUI.ModeSelect.EpCommonModeSelectUtil")

function ActivityCarnival24Data:InitActData(msg)
  self:SetActFrameDataByType(CurActType, msg.actId)
  self:UpdateActFrameDataSingleMsg(msg)
  self._mainCfg = ConfigData.activity_carnival24_main[msg.actId]
  self:__InitMonsterCardData()
  self:__InitDailyTaskData()
  self:__InitTermTaskData()
  self.actCommonRewardBpData = ActCommonRewardBpData.New(self, self:GetCarnival24BpItem())
  self:UpdateActData(msg)
  self.__UpdateChildActivityRedCallback = BindCallback(self, self.__UpdateChildActivityRed)
  self._childActivityRedDic = {}
  self:__InitChildActivityRedListen()
  self:RefreshRedCarnival24DailyTask()
  self:RefreshRedCarnival24OnceTask()
  self:__LinkBondActReddot()
end

function ActivityCarnival24Data:UpdateActData(msg)
  self:UpdateFragMentDemandData(msg.stages)
  self:InitPickedEpInfinityRewardScore(msg.levelInfiniteMode)
  MsgCenter:Broadcast(eMsgEventId.ActivityCarnival24DataChange)
end

function ActivityCarnival24Data:UpdateFragMentDemandData(stages)
  self.fragMentDemandTable = {}
  for stageId, stage in pairs(stages) do
    local demandIdList = stage.demandId
    for index, demandId in pairs(demandIdList) do
      self:UpdateMemoryDemand(stageId, demandId, true)
    end
  end
end

function ActivityCarnival24Data:UpdateMemoryDemand(stageId, demandId, value)
  if self.fragMentDemandTable == nil then
    self.fragMentDemandTable = {}
  end
  if self.fragMentDemandTable[stageId] == nil then
    self.fragMentDemandTable[stageId] = {}
  end
  self.fragMentDemandTable[stageId][demandId] = value
end

function ActivityCarnival24Data:RefreshAllInfinityRankData(rankId2ScoreDic)
  local actFrameId = self:GetActFrameId()
  local mainCfg = ConfigData.act_general_ep_main[actFrameId]
  if self.diff2ScoreDic == nil then
    self.diff2ScoreDic = {}
  end
  for _, envId in pairs(mainCfg.env_list) do
    local envCfg = ConfigData.act_general_ep_env[envId]
    for _, diffId in pairs(envCfg.difficulty_des) do
      local diffCfg = ConfigData.act_general_ep_difficulty[diffId]
      if EpCommonModeSelectUtil.IsEpCommonInfinity(diffId) then
        if rankId2ScoreDic[diffCfg.rank_id] ~= nil then
          self.diff2ScoreDic[diffId] = rankId2ScoreDic[diffCfg.rank_id]
        else
          self.diff2ScoreDic[diffId] = self.diff2ScoreDic[diffId] or 0
        end
      end
    end
  end
  self:RefreshRed_InfinityRewardPick()
end

function ActivityCarnival24Data:InitPickedEpInfinityRewardScore(levelInfiniteMode)
  self.diff2PickedScoreDic = {}
  for diffId, level in pairs(levelInfiniteMode) do
    local diffCfg = ConfigData.act_general_ep_difficulty[diffId]
    local rewardId = diffCfg.reward_id
    local rewardCfgList = ConfigData.act_general_ep_reward_id[rewardId]
    local totalScore = 0
    for index, cfg in ipairs(rewardCfgList) do
      totalScore = totalScore + cfg.need_num
      if index < level then
        self.diff2PickedScoreDic[diffId] = totalScore
      end
    end
  end
end

function ActivityCarnival24Data:LocalRefreshPickedEpInfinityRewardScore(diffId, newPickedScore)
  self.diff2PickedScoreDic[diffId] = newPickedScore
  self:RefreshRed_InfinityRewardPick()
end

function ActivityCarnival24Data:GetEpInfinityPickedScoreByDiffId(diffId)
  return self.diff2PickedScoreDic[diffId] or 0
end

function ActivityCarnival24Data:GetEpInfinityCurrentScoreByDiffId(diffId)
  return self.diff2ScoreDic[diffId] or 0
end

function ActivityCarnival24Data:__InitDailyTaskData()
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  self._dailyTaskData = actFrameCtrl:GetActDailyTaskData(self:GetActFrameId())
  if self._dailyTaskData == nil then
    self._dailyTaskData = ActDailyTaskData.New()
    self._dailyTaskData:InitActDailyTask(self:GetActFrameId())
  end
  local RefreshRedWinter23DailyTaskCallback = BindCallback(self, self.RefreshRedCarnival24DailyTask)
  self._dailyTaskData:BindActDailyTaskCommitFunc(RefreshRedWinter23DailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskChangeFunc(RefreshRedWinter23DailyTaskCallback)
  self._dailyTaskData:BindActDailyTaskExpireFunc(RefreshRedWinter23DailyTaskCallback)
  self._dailyTaskData:RegisterActDailyRefresh()
end

function ActivityCarnival24Data:__InitTermTaskData()
  self._termTaskData = ActTermTaskDataMul.New()
  self._termTaskData:InitTermTask(self:GetActFrameId())
  local RefreshRedWnter23OnceTaskCallback = BindCallback(self, self.RefreshRedCarnival24OnceTask)
  self._termTaskData:BindTeramTaskCommitFunc(RefreshRedWnter23OnceTaskCallback)
  self._termTaskData:BindTeramTaskUnlockFunc(RefreshRedWnter23OnceTaskCallback)
end

function ActivityCarnival24Data:GetRecentLobbyData()
  local lobbyId = -1
  local cfgList = {}
  for stageId, stageCfg in pairs(ConfigData.activity_carnival24_memory_stage) do
    if stageId // 1000 == self:GetActId() then
      if self:IsUnLockMemoryFragMent(stageId) and lobbyId < stageCfg.lobby_id then
        lobbyId = stageCfg.lobby_id
      end
      table.insert(cfgList, stageCfg)
    end
  end
  table.sort(cfgList, function(aCfg, bCfg)
    return aCfg.stage_id < bCfg.stage_id
  end)
  local index = 0
  local nameList = {}
  for i, cfg in ipairs(cfgList) do
    if cfg.lobby_id == lobbyId then
      index = i
    end
    table.insert(nameList, cfg.name)
  end
  return {
    lobbyId = lobbyId,
    index = index,
    nameList = nameList
  }
end

function ActivityCarnival24Data:IsUnLockMemoryFragMent(memoryStateId)
  local memoryStageCfg = ConfigData.activity_carnival24_memory_stage[memoryStateId]
  for checkStageId, keyDemandCount in pairs(memoryStageCfg.next_need) do
    local compeltedCount = 0
    local demandCfgList = ConfigData.activity_carnival24_memory_demand[checkStageId]
    if demandCfgList == nil then
      return false
    end
    for demandId, cfg in pairs(demandCfgList) do
      if cfg.type_id == 1 and self.fragMentDemandTable[checkStageId] ~= nil and self.fragMentDemandTable[checkStageId][demandId] == true then
        compeltedCount = compeltedCount + 1
      end
    end
    if keyDemandCount > compeltedCount then
      return false
    end
  end
  return true
end

function ActivityCarnival24Data:GetUnLockNextStageNeedkeyDemandCount(memoryStateId)
  local keyDemandCount = 0
  for stageId, memoryStageCfg in pairs(ConfigData.activity_carnival24_memory_stage) do
    for checkStageId, unLockDemandCount in pairs(memoryStageCfg.next_need) do
      if checkStageId == memoryStateId then
        keyDemandCount = unLockDemandCount
        break
      end
    end
  end
  if keyDemandCount == 0 then
    return 0
  end
  local compeltedCount = 0
  local demandCfgList = ConfigData.activity_carnival24_memory_demand[memoryStateId]
  for demandId, cfg in pairs(demandCfgList) do
    if cfg.type_id == 1 and self.fragMentDemandTable[memoryStateId] ~= nil and self.fragMentDemandTable[memoryStateId][demandId] then
      compeltedCount = compeltedCount + 1
    end
  end
  return math.max(keyDemandCount - compeltedCount, 0)
end

function ActivityCarnival24Data:IsMemoryFragMentDemandPicked(memoryStateId, demandId)
  return self.fragMentDemandTable[memoryStateId] ~= nil and self.fragMentDemandTable[memoryStateId][demandId]
end

function ActivityCarnival24Data:GetMemoryFragMentDemandState(memoryStateId, demandId)
  if self:IsMemoryFragMentDemandPicked(memoryStateId, demandId) then
    return eDemandState.Picked
  end
  local memoryDemandCfg = ConfigData.activity_carnival24_memory_demand[memoryStateId][demandId]
  for index, itemId in ipairs(memoryDemandCfg.consume_ids) do
    local itemCount = PlayerDataCenter:GetItemCount(itemId)
    if itemCount < memoryDemandCfg.consume_nums[index] then
      return eDemandState.InProgress
    end
  end
  return eDemandState.Completed
end

function ActivityCarnival24Data:GetMainCfg()
  return self._mainCfg
end

function ActivityCarnival24Data:Carnival24MainSectorId()
  local actFrameId = self:GetActFrameId()
  local mainCfg = ConfigData.act_general_ep_main[actFrameId]
  return mainCfg.main_stage
end

function ActivityCarnival24Data:GetCarnival24StoryStageId()
  local mainCfg = self:GetMainCfg()
  return mainCfg.story_stage
end

function ActivityCarnival24Data:__InitMonsterCardData()
  local actFrameId = self:GetActFrameId()
  if ConfigData.activity_monster_card[actFrameId] == nil then
    return
  end
  self.actMonsterCardPlayData = ActMonsterCardPlayData.New(self)
end

function ActivityCarnival24Data:RefreshActivityMonsterCardData(monsterCardDataMsg, isFromDiff)
  if self.actMonsterCardPlayData == nil then
    error("not has actMonsterCardPlayData")
    return
  end
  self.actMonsterCardPlayData:ActMCPD_RefreshCardDatas(monsterCardDataMsg, isFromDiff)
end

function ActivityCarnival24Data:GetMonsterCardData()
  return self.actMonsterCardPlayData
end

function ActivityCarnival24Data:RefreshActivityCommonRewardBp(bpElem)
  if self.actCommonRewardBpData ~= nil then
    self.actCommonRewardBpData:UpdateCommonRewardBp(bpElem)
    self:RefreshRedCarnival24RewardBp()
  end
end

function ActivityCarnival24Data:GetCarnival24DailyTaskData()
  return self._dailyTaskData
end

function ActivityCarnival24Data:GetCarnival24TermTaskData()
  return self._termTaskData
end

function ActivityCarnival24Data:GetRewardBpData()
  return self.actCommonRewardBpData
end

function ActivityCarnival24Data:GetCarnival24BpItem()
  return self._mainCfg.bp_item
end

function ActivityCarnival24Data:RefreshActivityShopRedDot()
  local childReddot = self:GetActChildRedDot(ActivityCarnival24Enum.reddotType.Shop)
  if childReddot == nil then
    return
  end
  local flag = false
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  for i, v in ipairs(self._mainCfg.shop_list) do
    if not userDataCache:GetCarnival24ShopLooked(self:GetActId(), v) then
      flag = true
      break
    end
  end
  local redCount = flag and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function ActivityCarnival24Data:RefreshRedCarnival24DailyTask()
  local reddot = self:GetActChildRedDot(ActivityCarnival24Enum.reddotType.DailyTask)
  if reddot == nil then
    return
  end
  if self._dailyTaskData == nil then
    return
  end
  local flag = self._dailyTaskData:IsExistDailyCompleteTask()
  local redCount = flag and 1 or 0
  if reddot:GetRedDotCount() ~= redCount then
    reddot:SetRedDotCount(redCount)
  end
end

function ActivityCarnival24Data:RefreshRedCarnival24OnceTask()
  local reddot = self:GetActChildRedDot(ActivityCarnival24Enum.reddotType.OnceTask)
  if reddot == nil then
    return
  end
  local flag = self._termTaskData:IsExistTermCompleteTask()
  local redCount = flag and 1 or 0
  if reddot:GetRedDotCount() ~= redCount then
    reddot:SetRedDotCount(redCount)
  end
end

function ActivityCarnival24Data:RefreshRedCarnival24RewardBp()
  local reddot = self:GetActChildRedDot(ActivityCarnival24Enum.reddotType.BpReward)
  if reddot == nil then
    return
  end
  local flag = self.actCommonRewardBpData:HasCommonRewardExpCanReceive()
  local redCount = flag and 1 or 0
  if reddot:GetRedDotCount() ~= redCount then
    reddot:SetRedDotCount(redCount)
  end
end

function ActivityCarnival24Data:RefreshRed_InfinityRewardPick()
  local reddot = self:GetActChildRedDot(ActivityCarnival24Enum.reddotType.Infinity)
  if reddot == nil then
    return
  end
  local actFrameId = self:GetActFrameId()
  local mainCfg = ConfigData.act_general_ep_main[actFrameId]
  for _, envId in pairs(mainCfg.env_list) do
    local envCfg = ConfigData.act_general_ep_env[envId]
    for _, diffId in pairs(envCfg.difficulty_des) do
      local diffCfg = ConfigData.act_general_ep_difficulty[diffId]
      if EpCommonModeSelectUtil.IsEpCommonInfinity(diffId) then
        local redNode = reddot:AddChild(diffId)
        if not self:IsActivityRunning() then
          redNode:SetRedDotCount(0)
        else
          local flag = false
          local pickedScore = self.diff2PickedScoreDic[diffId] or 0
          local curScore = self.diff2ScoreDic[diffId]
          local rewardId = diffCfg.reward_id
          local rewardCfgList = ConfigData.act_general_ep_reward_id[rewardId]
          local totalScore = 0
          if pickedScore < curScore then
            for index, cfg in ipairs(rewardCfgList) do
              totalScore = totalScore + cfg.need_num
              if curScore > totalScore and pickedScore < totalScore then
                flag = true
                break
              end
            end
          end
          local redCount = flag and 1 or 0
          if redNode:GetRedDotCount() ~= redCount then
            redNode:SetRedDotCount(redCount)
          end
        end
      end
    end
  end
end

function ActivityCarnival24Data:GetEnvReddotNode(envId)
  local reddot = self:GetActChildRedDot(ActivityCarnival24Enum.reddotType.Infinity)
  if reddot == nil then
    return
  end
  local envCfg = ConfigData.act_general_ep_env[envId]
  for _, diffId in pairs(envCfg.difficulty_des) do
    if EpCommonModeSelectUtil.IsEpCommonInfinity(diffId) then
      local redNode = reddot:AddChild(diffId)
      return redNode
    end
  end
  return nil
end

function ActivityCarnival24Data:GetInfinityRewardReddotNode(diffId)
  local reddot = self:GetActChildRedDot(ActivityCarnival24Enum.reddotType.Infinity)
  if reddot == nil then
    return nil
  end
  local redNode = reddot:AddChild(diffId)
  return redNode
end

function ActivityCarnival24Data:__InitChildActivityRedListen()
  local bpActFrameId = self._mainCfg.jump_activity_id[1]
  if bpActFrameId ~= nil then
    local bpReddot = self:__AddSingleChildRedListen(bpActFrameId)
    self._childActivityRedDic[ActivityCarnival24Enum.reddotType.Jump1] = bpReddot
  end
  local flipActFrameId = self._mainCfg.jump_activity_id[2]
  if flipActFrameId ~= nil then
    local flipReddot = self:__AddSingleChildRedListen(flipActFrameId)
    self._childActivityRedDic[ActivityCarnival24Enum.reddotType.Jump2] = flipReddot
  end
  self:__UpdateChildActivityRed()
end

function ActivityCarnival24Data:__AddSingleChildRedListen(activityId)
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local actFrameData = actFrameCtrl:GetActivityFrameData(activityId)
  if actFrameData == nil then
    return
  end
  local childActivityReddot = actFrameData:GetActivityReddotNode()
  if childActivityReddot == nil then
    return
  end
  RedDotController:AddListener(childActivityReddot.nodePath, self.__UpdateChildActivityRedCallback)
  return childActivityReddot
end

function ActivityCarnival24Data:__UpdateChildActivityRed()
  for enum, childActivityReddot in pairs(self._childActivityRedDic) do
    self:__UpdateSingleChildRed(childActivityReddot, enum)
  end
end

function ActivityCarnival24Data:__UpdateSingleChildRed(childActivityReddot, reddotEnum)
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  if childActivityReddot ~= nil then
    local childReddot = reddot:AddChild(reddotEnum)
    local flag = childActivityReddot:GetRedDotCount() > 0
    local redCount = flag and 1 or 0
    if childReddot:GetRedDotCount() ~= redCount then
      childReddot:SetRedDotCount(redCount)
    end
  end
end

function ActivityCarnival24Data:__RemoveChildActivityRedListen()
  for enum, childActivityReddot in pairs(self._childActivityRedDic) do
    RedDotController:RemoveListener(childActivityReddot.nodePath, self.__UpdateChildActivityRedCallback)
  end
  self._childActivityRedDic = {}
end

function ActivityCarnival24Data:__LinkBondActReddot()
  local bondCtrl = ControllerManager:GetController(ControllerTypeId.ActivityBond)
  if bondCtrl ~= nil then
    local rootNode = self:GetActivityReddot()
    local subActRedNodeRoot = rootNode:AddChild(ActivityCarnival24Enum.reddotType.SubAct_Bond)
    local mainCfg = self:GetMainCfg()
    local actFrameId = mainCfg.second_id
    local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
    local actFrameData = actFrameCtrl:GetActivityFrameData(actFrameId)
    local actId = actFrameData:GetActId()
    bondCtrl:ResetBondActRedDotRoot(subActRedNodeRoot, actId)
  end
end

function ActivityCarnival24Data:IsCarnival24ShopLooked(shopId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  return userDataCache:GetCarnival24ShopLooked(self:GetActId(), shopId)
end

function ActivityCarnival24Data:SetCarnival24ShopLooked(shopId)
  local userDataCache = PersistentManager:GetDataModel(PersistentConfig.ePackage.UserData)
  userDataCache:SetCarnival24ShopLooked(self:GetActId(), shopId)
  self:RefreshActivityShopRedDot()
end

function ActivityCarnival24Data:GetActivityReddotNum()
  local isBlue = true
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  for i, v in ipairs(ActivityCarnival24Enum.reddotIsRedType) do
    local redChild = actRedDotNode:GetChild(v)
    if redChild ~= nil and 0 < redChild:GetRedDotCount() then
      isBlue = false
      break
    end
  end
  return isBlue, num
end

function ActivityCarnival24Data:OnDataRemoved()
  self:__RemoveChildActivityRedListen()
end

return ActivityCarnival24Data
