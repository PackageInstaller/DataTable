local ActivityBase = class("ActivityBase")

function ActivityBase:SetActFrameDataByType(typeId, actId)
  self.actInfo = nil
  local activityController = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  local id = activityController:GetIdByActTypeAndActId(typeId, actId)
  if id ~= nil then
    self.actInfo = activityController:GetActivityFrameData(id)
  end
  if self.actInfo == nil then
    error("activity not in ActivityFrame,type and id is " .. tostring(typeId) .. "," .. tostring(actId))
    return
  end
  self.actInfo:SetActivityData(self)
end

function ActivityBase:SetActFrameData(actInfo)
  self.actInfo = actInfo
  self.actInfo:SetActivityData(self)
end

function ActivityBase:UpdateActFrameDataSingleMsg(msg)
  if self.actInfo == nil then
    return
  end
  if self.__isDealResetFinishTime then
    return
  end
  self.__isDealResetFinishTime = true
  local startTm = msg.startTm
  if (startTm or 0) == 0 then
    return
  end
  local activityController = ControllerManager:GetController(ControllerTypeId.ActivityFrame, true)
  activityController:TryResetActivityFinishTimeByFrameId(self.actInfo:GetActivityFrameId(), startTm)
end

function ActivityBase:GetActId()
  return self.actInfo:GetActId()
end

function ActivityBase:GetActivityFrameCat()
  return self.actInfo:GetActivityFrameCat()
end

function ActivityBase:GetActFrameId()
  return self.actInfo:GetActivityFrameId()
end

function ActivityBase:IsActivityOpen()
  if self.actInfo == nil then
    return false
  end
  return self.actInfo:IsActivityOpen()
end

function ActivityBase:IsActivityRunning()
  if self.actInfo == nil then
    return false
  end
  return self.actInfo:IsInRuningState()
end

function ActivityBase:IsActivityPreview()
  if self.actInfo == nil then
    return false
  end
  return self.actInfo:IsInPreviewState()
end

function ActivityBase:GetActivityDestroyTime()
  if self.actInfo == nil then
    return 0
  end
  return self.actInfo:GetActivityDestroyTime()
end

function ActivityBase:GetActivityEndTime()
  if self.actInfo == nil then
    return 0
  end
  return self.actInfo:GetActivityEndTime()
end

function ActivityBase:GetActivityBornTime()
  if self.actInfo == nil then
    return 0
  end
  return self.actInfo:GetActivityBornTime()
end

function ActivityBase:GetActivityName()
  if self.actInfo == nil then
    return 0
  end
  return self.actInfo.name
end

function ActivityBase:SetActivityAsReadOnLogin()
  if self.actInfo ~= nil then
    self.actInfo:SetActivityAsReadOnLogin()
  end
end

function ActivityBase:IsActivityReadOnLogin()
  if self.actInfo ~= nil then
    return self.actInfo:IsActivityReadOnLogin()
  end
  return false
end

function ActivityBase:GetActivityReddot()
  if self.actInfo == nil then
    return nil
  end
  return self.actInfo:GetActivityReddotNode()
end

function ActivityBase:GetActivityReddotNum()
  local isBlue = false
  local actRedDotNode = self:GetActivityReddot()
  if actRedDotNode == nil then
    error("can't get activity reddot node")
    return false, 0
  end
  local num = actRedDotNode:GetRedDotCount()
  return isBlue, num
end

function ActivityBase:RefreshActivityTechData(techData)
end

function ActivityBase:RefreshActivityMonsterCardData(monsterCardDataMsg)
end

function ActivityBase:GetMonsterCardData()
end

function ActivityBase:RefreshCommonHardLevelPlayData(msg)
end

function ActivityBase:GetCommonHardLevelPlayData()
end

function ActivityBase:RefreshActivityGiftItems(giftItems)
end

function ActivityBase:RefreshActivityCommonRewardBp(bpElem)
end

function ActivityBase:RefreshActivityBpPoint(bpTable)
  if bpTable == nil then
    return
  end
  for term, bp in pairs(bpTable) do
    self:TryInitActivityBpPointByTerm(term)
    self._bpPointTable[term].point = bp.point or self._bpPointTable[term].point
    self._bpPointTable[term].rewardGotPoint = bp.rewardGotPoint or self._bpPointTable[term].rewardGotPoint
  end
end

function ActivityBase:GetActivityBpPointByTerm(term)
  self:TryInitActivityBpPointByTerm(term)
  return self._bpPointTable[term]
end

function ActivityBase:TryInitActivityBpPointByTerm(term)
  if self._bpPointTable == nil then
    self._bpPointTable = {}
  end
  if self._bpPointTable[term] == nil then
    self._bpPointTable[term] = {point = 0, rewardGotPoint = 0}
  end
end

function ActivityBase:GetActivityIsUnlock()
  if self.actInfo == nil then
    return false
  end
  return self.actInfo:GetIsActivityUnlockForFrameCtrl()
end

function ActivityBase:GetActivityLockTip(noNeedTimeTip)
  if self.actInfo == nil then
    return nil
  end
  return self.actInfo:GetLockTip(noNeedTimeTip)
end

function ActivityBase:GetActChildRedDot(type)
  local reddot = self:GetActivityReddot()
  if reddot == nil then
    return nil
  end
  if type == nil then
    return reddot
  end
  return reddot:AddChild(type)
end

function ActivityBase:__InitRecommendTaskCfg()
  local spTaskCfg = ConfigData.activity_general_special_task[self:GetActFrameId()]
  if spTaskCfg == nil then
    return
  end
  self._spTaskCfg = spTaskCfg
  local spMainTaskIdDic = {}
  for _, id in ipairs(spTaskCfg.main_task) do
    spMainTaskIdDic[id] = true
  end
  self._spMainTaskIdDic = spMainTaskIdDic
  local spRecommendTaskIdDic = {}
  for _, id in ipairs(spTaskCfg.recommend_task) do
    spRecommendTaskIdDic[id] = true
  end
  self._spRecommendTaskIdDic = spRecommendTaskIdDic
end

function ActivityBase:GetActivitySpecialTaskData()
  if self._spTaskCfg == nil then
    return
  end
  
  local function showCurrectTaskFunc(taskId)
    local taskCfg = ConfigData.task[taskId]
    local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
    if taskCfg == nil or taskData == nil then
      error("cant find taskCfg or taskData!")
      return nil
    end
    local prePicked = true
    if taskCfg ~= nil and taskCfg.show_pre > 0 then
      local preTaskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskCfg.show_pre, true)
      prePicked = preTaskData.isPicked
    end
    return prePicked and not taskData.isPicked
  end
  
  local function addToTaskDataList(taskIdTable, taskDataList)
    for _, taskId in ipairs(taskIdTable) do
      local canShow = showCurrectTaskFunc(taskId)
      if canShow then
        local taskData = PlayerDataCenter.allTaskData:GetTaskDataById(taskId, true)
        table.insert(taskDataList, taskData)
      end
    end
  end
  
  local taskDataList = {}
  addToTaskDataList(self._spTaskCfg.main_task, taskDataList)
  local isMainLine = 0 < #taskDataList
  if not isMainLine then
    addToTaskDataList(self._spTaskCfg.recommend_task, taskDataList)
  end
  return taskDataList[1], isMainLine
end

function ActivityBase:CheckSpecialTaskCanMove2Entt(enttId)
  local taskData, isMainLine = self:GetActivitySpecialTaskData()
  if taskData == nil then
    return false, isMainLine
  end
  local flag, jumpId, jumpArgs = taskData:GetTaskJumpArg()
  if flag and jumpArgs[3] then
    return enttId == jumpArgs[3], isMainLine
  end
  return false, isMainLine
end

function ActivityBase:CheckIsSpecialTaskByTaskId(taskId)
  local isMain = self._spMainTaskIdDic[taskId] ~= nil
  local isRecommend = self._spRecommendTaskIdDic[taskId] ~= nil
  local index = isMain and 1 or 0
  return isMain or isRecommend, index
end

return ActivityBase
