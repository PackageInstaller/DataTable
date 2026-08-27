local base = require("Game.ActivityFrame.ActivityBase")
local EventDrawLotteryData = class("EventDrawLotteryData", base)
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")
local CurActType = ActivityFrameEnum.eActivityType.DrawLottery
local CheckerTypeId, CheckerGlobalConfig = table.unpack(require("Game.Common.CheckCondition.CheckerGlobalConfig"))
local CommonRewardData = require("Game.CommonUI.CommonRewardData")
local redDotType = {taskGroup = 1, bpReward = 1}

function EventDrawLotteryData:InitDrawLotteryData(msg)
  local actId = msg.actId
  self:SetActFrameDataByType(CurActType, actId)
  self._mainCfg = ConfigData.activity_drawlottery_main[actId]
  self._rewardCfg = ConfigData.activity_drawlottery_reward[actId]
  self._taskGroupCfg = ConfigData.activity_drawlottery_task_group[actId]
  self.netCtrl = NetworkManager:GetNetwork(NetworkTypeID.EventDrawLottery)
  self.stagesPickedDic = {}
  self:UpdateDrawLotteryMsg(msg)
  self:RefreshBPRedDot()
  self:RefreshTaskGroupRedDot()
end

function EventDrawLotteryData:UpdateDrawLotteryMsg(msg)
  if msg.stagesPicked ~= nil then
    for _, value in ipairs(msg.stagesPicked) do
      self.stagesPickedDic[value] = true
    end
  end
end

function EventDrawLotteryData:RefreshTaskGroupRedDot()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local isHave = self:GetDrawLotteryAllHaveTaskComplete()
  local childReddot = reddot:AddChild(redDotType.taskGroup)
  local redCount = isHave and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function EventDrawLotteryData:RefreshBPRedDot()
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return
  end
  local isHave = self:GetDrawLotteryBpCanPick()
  local childReddot = reddot:AddChild(redDotType.bpReward)
  local redCount = isHave and 1 or 0
  if childReddot:GetRedDotCount() ~= redCount then
    childReddot:SetRedDotCount(redCount)
  end
end

function EventDrawLotteryData:SendRewardCallback(objList)
  local msg = objList[0]
  if msg == nil then
    return
  end
  local rewardIds = {}
  local rewardNums = {}
  for k, v in pairs(msg.rewards) do
    table.insert(rewardIds, k)
    table.insert(rewardNums, v)
  end
  if 0 < #rewardIds then
    UIManager:ShowWindowAsync(UIWindowTypeID.CommonReward, function(window)
      if window == nil then
        return
      end
      local CRData = CommonRewardData.CreateCRDataUseList(rewardIds, rewardNums)
      CRData:SetCRItemTransDic(self.transDic)
      window:AddAndTryShowReward(CRData)
    end)
  end
end

function EventDrawLotteryData:SendDrawLotteryAllPick()
  if not self:GetDrawLotteryBpCanPick(nil, true) then
    return
  end
  self.netCtrl:CS_Activity_DrawLottery_Pick(self:GetActId(), 0, BindCallback(self, self.SendRewardCallback))
end

function EventDrawLotteryData:SendDrawLotteryOnePick(stage)
  if not self:GetDrawLotteryBpCanPick(stage, true) then
    return
  end
  self.netCtrl:CS_Activity_DrawLottery_Pick(self:GetActId(), stage, BindCallback(self, self.SendRewardCallback))
end

function EventDrawLotteryData:GetDrawLotteryMainCfg()
  return self._mainCfg
end

function EventDrawLotteryData:GetDrawLotteryRewardCfg()
  return self._rewardCfg
end

function EventDrawLotteryData:GetDrawLotteryTaskGroupCfg()
  return self._taskGroupCfg
end

function EventDrawLotteryData:GetCorrectionNum(taskInfo)
  local cfg = self._taskGroupCfg[taskInfo.id]
  return cfg.correction_num
end

function EventDrawLotteryData:GetDrawLotteryStageIsPicked(id)
  return self.stagesPickedDic[id]
end

function EventDrawLotteryData:CheckPooIdIsExclude(poolId)
  if poolId == self._mainCfg.lottery_exclude then
    return true
  end
  return false
end

function EventDrawLotteryData:GetDrawLotteryScore()
  local itemData = PlayerDataCenter.itemDic[self:GetDrawLotteryScoreItemId()]
  return itemData and itemData:GetCount() or 0
end

function EventDrawLotteryData:GetDrawLotteryScoreItemId()
  return self._mainCfg.score_id
end

function EventDrawLotteryData:GetDrawLotteryGroupNum()
  return ConfigData.activity_drawlottery_task_group.allGroupCountDic[self:GetActId()] or 0
end

function EventDrawLotteryData:GetDrawLotteryNowTaskStage(groupId)
  local taskGroup = self:GetAllTaskStage(groupId)
  local realData
  for i, taskId in ipairs(taskGroup) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    if not taskData:IsPickedTaskReward() then
      realData = taskData
      break
    end
    realData = taskData
  end
  return realData
end

function EventDrawLotteryData:GetStageIdByTaskData(taskData)
  local cfg = self._taskGroupCfg[taskData.id]
  return cfg.stage_id
end

function EventDrawLotteryData:GetAllCompleteTaskDataList(groupId)
  local idList = self:GetAllTaskStage(groupId)
  local list = {}
  for _, taskId in pairs(idList) do
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    if taskData:IsPickedTaskReward() then
      table.insert(list, taskData)
    else
      break
    end
  end
  return list
end

function EventDrawLotteryData:GetAllTaskStage(groupId)
  return ConfigData.activity_drawlottery_task_group.taskGroupDic[self:GetActId()][groupId]
end

function EventDrawLotteryData:GetDrawLotteryAllHaveTaskComplete()
  local isHave = false
  local groupNum = self:GetDrawLotteryGroupNum()
  for i = 1, groupNum do
    local groupId = i
    local taskData = self:GetDrawLotteryNowTaskStage(groupId)
    local isPicked = taskData.state == proto_object_QuestState.QuestStateExpired or taskData.state == proto_object_QuestState.QuestStateCompleted
    local isComplete = taskData:CheckComplete()
    if isComplete and not isPicked then
      isHave = true
    end
  end
  return isHave
end

function EventDrawLotteryData:GetDrawLotteryHaveTaskComplete(lotteryType)
  local taskCompleteData = {}
  local groupId = ConfigData.activity_drawlottery_task_group.lotteryTypeDic[self:GetActId()][lotteryType]
  local taskData = self:GetDrawLotteryNowTaskStage(groupId)
  local isPicked = taskData.state == proto_object_QuestState.QuestStateExpired or taskData.state == proto_object_QuestState.QuestStateCompleted
  local isComplete = taskData:CheckComplete()
  local schedule, aim = taskData:GetTaskProcess()
  local correctionNum = self:GetCorrectionNum(taskData)
  schedule = schedule - correctionNum
  aim = aim - correctionNum
  taskCompleteData.canPick = isComplete and not isPicked
  taskCompleteData.schedule = schedule
  taskCompleteData.aim = aim
  taskCompleteData.destroy = isPicked
  return taskCompleteData
end

function EventDrawLotteryData:GetDrawLotteryBpCanPick(id, isNeedGenTrans)
  local nowNum = self:GetDrawLotteryScore()
  if id ~= nil then
    local nowCfg = self._rewardCfg[id]
    if nowNum >= nowCfg.stage_score and not self:GetDrawLotteryStageIsPicked(id) then
      if isNeedGenTrans then
        self:GenTransDic(id)
      end
      return true
    end
    return false
  end
  for i, cfg in ipairs(self._rewardCfg) do
    if nowNum >= cfg.stage_score and not self:GetDrawLotteryStageIsPicked(i) then
      if isNeedGenTrans then
        self:GenTransDic()
      end
      return true
    end
  end
  return false
end

function EventDrawLotteryData:GenTransDic(id)
  self.transDic = {}
  if id ~= nil then
    self:GenTransDicById(id, self.transDic)
  else
    local nowNum = self:GetDrawLotteryScore()
    for i, cfg in ipairs(self._rewardCfg) do
      if nowNum >= cfg.stage_score and not self:GetDrawLotteryStageIsPicked(i) then
        self:GenTransDicById(i, self.transDic)
      end
    end
  end
end

function EventDrawLotteryData:GenTransDicById(id, transDic)
  local nowCfg = self._rewardCfg[id]
  for rewardId, rewardNum in pairs(nowCfg.stage_reward) do
    local itemCfg = ConfigData.item[rewardId]
    if itemCfg.overflow_type == eItemTransType.actMoneyX then
      local num = PlayerDataCenter:GetItemOverflowNum(rewardId, rewardNum)
      if num ~= 0 then
        transDic[rewardId] = (transDic[rewardId] or 0) + num
      end
    end
  end
end

function EventDrawLotteryData:GetDrawLotteryMaxScore()
  return self._rewardCfg[#self._rewardCfg].stage_score
end

function EventDrawLotteryData:GetDrawLotteryRate()
  local maxNum = self._rewardCfg[#self._rewardCfg].stage_score
  local nowNum = self:GetDrawLotteryScore()
  return nowNum / maxNum
end

function EventDrawLotteryData:GetDrawLotterySkinPosData()
  return self._mainCfg.posData
end

function EventDrawLotteryData:GetDrawLotteryGameTip()
  return self._mainCfg.task_rule_title, self._mainCfg.task_rule_id
end

return EventDrawLotteryData
