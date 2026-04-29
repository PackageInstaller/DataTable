_class("ExtMissionModule", GameModule)
ExtMissionModule = ExtMissionModule

function ExtMissionModule:Constructor()
  self.m_mapExtMission = {}
  self.m_vecNewExtMission = ArrayList:New()
  self.m_nGuideExtMission = 0
  self.m_mapExtStory = {}
end

function ExtMissionModule:Init()
  self.caller:RegisterPushHandler(CEventExtMission_Summary, self.OnRecvMsg_ExtMission_Summary, self)
  self.caller:RegisterPushHandler(CEventExtMission_FailCount, self.OnRecvMsg_ExtMission_FailCount, self)
  self.caller:RegisterPushHandler(CEventExtMission_StoryData, self.OnRecvMs_ExtMission_StoryData, self)
end

function ExtMissionModule:Update(deltaTimeMS)
end

function ExtMissionModule:InitExtMissionInfo()
end

function ExtMissionModule:_GetDetailData_ExtMission(nExtMissionID)
  local detailExtMission = self.m_mapExtMission[nExtMissionID]
  if nil == detailExtMission then
    detailExtMission = DDetailExtMission:New()
    self.m_mapExtMission[nExtMissionID] = detailExtMission
  end
  return detailExtMission
end

function ExtMissionModule:_SaveSummaryData(vecExtMission, bOnlyNew)
  for i = 1, #vecExtMission do
    local summaryExtMission = vecExtMission[i]
    local detailExtMission = self:_GetDetailData_ExtMission(summaryExtMission.m_nExtMissionID)
    detailExtMission.m_nExtMissionID = summaryExtMission.m_nExtMissionID
    detailExtMission.m_nStarCount = summaryExtMission.m_nStarCount
    detailExtMission.m_nAwardRecord = summaryExtMission.m_nAwardRecord
    for _, summaryExtTask in pairs(summaryExtMission.m_vecExtTask) do
      local detailExtTask = self:_FindExtTaskDetail2(detailExtMission, summaryExtTask.m_nExtTaskID)
      if nil == detailExtTask then
        detailExtTask = DDetailExtTask:New()
        local nVecCount = #detailExtMission.m_vecExtTask
        detailExtMission.m_vecExtTask[nVecCount + 1] = detailExtTask
      end
      detailExtTask.m_nExtTaskID = summaryExtTask.m_nExtTaskID
      detailExtTask.m_nStarCount = summaryExtTask.m_nStarCount
      detailExtTask.pass_without_help = summaryExtTask.pass_without_help
    end
    if bOnlyNew and detailExtMission.m_nStarCount <= 0 then
      self.m_vecNewExtMission:PushBack(summaryExtMission.m_nExtMissionID)
    end
  end
  Log.debug("[ExtMission] Save Summary Data, nExtTaskCount = ", #vecExtMission)
end

function ExtMissionModule:OnRecvMsg_ExtMission_Summary(msg)
  self:_SaveSummaryData(msg.m_vecExtMission, msg.m_bOnlyNew)
  self.m_nGuideExtMission = msg.m_nGuideData
  self:UI_SaveExtMissionNewState(msg.m_vecExtMission, msg.m_bOnlyNew)
end

function ExtMissionModule:OnRecvMsg_ExtMission_FailCount(msg)
  local detailTask = self:_FindExtTaskDetail(msg.m_nExtMissionID, msg.m_nExtTaskID)
  if detailTask then
    detailTask.m_nFailCount = msg.m_nFailCount
  end
end

function ExtMissionModule:OnRecvMs_ExtMission_StoryData(msg)
  self:SaveExtStoryData(msg.m_extStroy)
end

function ExtMissionModule:SaveExtStoryData(extStoryData)
  self.m_mapExtStory = extStoryData.m_mapExtStory
end

function ExtMissionModule:Request_GetSummary_All(TT, nExtMissionID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventExtMission_SummaryReq)
  request.m_nExtMissionID = nExtMissionID or 0
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    if reply.msg then
      res:SetResult(reply.msg.m_nResult)
    else
      res:SetResult(ENUM_ExtMission_ErrorCode.E_ExtMission_Fail)
    end
    return res
  end
  res:SetSucc(true)
  local recvPacket = reply.msg
  self:_SaveSummaryData(recvPacket.m_vecExtMission, false)
  self.m_nGuideExtMission = recvPacket.m_nGuideData
  return res
end

function ExtMissionModule:Request_GetDetail_ExtMission(TT, nExtMissionID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventExtMission_DetailReq)
  request.m_nExtMissionID = nExtMissionID
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    if reply.msg then
      res:SetResult(reply.msg.m_nResult)
    else
      res:SetResult(ENUM_ExtMission_ErrorCode.E_ExtMission_Fail)
    end
    return res
  end
  res:SetSucc(true)
  local nAswExtMissionID = reply.msg.m_extMissionData.m_nExtMissionID
  if 0 < nAswExtMissionID then
    local extMissionData = reply.msg.m_extMissionData
    self.m_mapExtMission[nAswExtMissionID] = table.cloneconf(extMissionData)
  end
  return res
end

function ExtMissionModule:Request_GetDetail_ExtTask(TT, nExtMissionID, nExtTaskID)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventExtTask_DetailReq)
  request.m_nExtMissionID = nExtMissionID
  request.m_nExtTaskID = nExtTaskID
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    if reply.msg then
      res:SetResult(reply.msg.m_nResult)
    else
      res:SetResult(ENUM_ExtMission_ErrorCode.E_ExtMission_Fail)
    end
    return res
  end
  res:SetSucc(true)
  local detailExtMission = self:_GetDetailData_ExtMission(reply.msg.m_nExtMissionID)
  local detailExtTaskIndex = self:_FindExtTaskDetailIndex(detailExtMission, reply.msg.m_extTaskData.m_nExtTaskID)
  if nil == detailExtTaskIndex then
    detailExtTaskIndex = #detailExtMission.m_vecExtTask + 1
  end
  detailExtMission.m_vecExtTask[detailExtTaskIndex] = table.cloneconf(reply.msg.m_extTaskData)
  return res
end

function ExtMissionModule:Request_GetAward(TT, nExtMissionID, nStarCount)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventExtMission_AwardReq)
  request.m_nExtMissionID = nExtMissionID
  request.m_nExtTaskID = 0
  request.m_nStarCount = nStarCount
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    if reply.msg then
      res:SetResult(reply.msg.m_nResult)
    else
      res:SetResult(ENUM_ExtMission_ErrorCode.E_ExtMission_Fail)
    end
    return res
  end
  res:SetSucc(true)
  local nExtMissionID = reply.msg.m_nExtMissionID
  local nExtTaskID = reply.msg.m_nExtTaskID
  if 0 == nExtTaskID then
    local detailExtMission = self:_GetDetailData_ExtMission(nExtMissionID)
    detailExtMission.m_nAwardRecord = reply.msg.m_nAwardRecord
  else
    local detailExtTask = self:_FindExtTaskDetail(nExtMissionID, nExtTaskID)
    if detailExtTask then
      detailExtTask.m_nAwardRecord = reply.msg.m_nAwardRecord
    end
  end
  return res
end

function ExtMissionModule:Request_Guide(TT, nGuideData)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventSetGuideReq)
  request.m_nGuideKey = EnumRoleGuideType.E_RoleGuide_ExtMission
  request.m_nGuideData = nGuideData
  local res = AsyncRequestRes:New()
  local reply = self:Call(TT, request)
  if reply.res ~= CallResultType.Normal then
    if reply.msg then
      res:SetResult(reply.msg.m_nResult)
    else
      res:SetResult(ENUM_ExtMission_ErrorCode.E_ExtMission_Fail)
    end
    return res
  end
  res:SetSucc(true)
  self.m_nGuideExtMission = reply.msg.m_nGuideData
  return res
end

function ExtMissionModule:Request_StoryActive(TT, nExtTaskID, activeType)
  local request = NetMessageFactory:GetInstance():CreateMessage(CEventExtMission_StoryReq)
  request.m_nExtTaskID = nExtTaskID or 0
  request.m_nExtStroyData = activeType or ActiveStoryType.ActiveStoryType_None
  local reply = self:Call(TT, request)
  local res = AsyncRequestRes:New()
  if reply.res ~= CallResultType.Normal then
    if reply.msg then
      res:SetResult(reply.msg.m_nResult)
    else
      res:SetResult(ENUM_ExtMission_ErrorCode.E_ExtMission_Fail)
    end
    return res
  end
  res:SetSucc(true)
  local replyEvent = reply.msg
  res:SetResult(replyEvent.m_result)
  local extStoryTask = DExtStoryTask:New()
  extStoryTask.m_nExtTaskID = replyEvent.m_nExtTaskID
  extStoryTask.m_nExtStroyData = replyEvent.m_nExtStroyData
  self.m_mapExtStory[replyEvent.m_nExtTaskID] = extStoryTask
  return res
end

function ExtMissionModule:_GetConditionDesc(condition_id)
  local missionModule = self:GetModule(MissionModule)
  return missionModule:Get3StarConditionDesc(condition_id)
end

function ExtMissionModule:_FindExtMissionDetail(nExtMissionID)
  return self.m_mapExtMission[nExtMissionID]
end

function ExtMissionModule:_FindExtTaskDetail2(extMission, nExtTaskID)
  if nil == extMission then
    return nil
  end
  for i = 1, #extMission.m_vecExtTask do
    if extMission.m_vecExtTask[i].m_nExtTaskID == nExtTaskID then
      return extMission.m_vecExtTask[i]
    end
  end
  return nil
end

function ExtMissionModule:_FindExtTaskDetailIndex(extMission, nExtTaskID)
  if nil == extMission then
    return nil
  end
  for i = 1, #extMission.m_vecExtTask do
    if extMission.m_vecExtTask[i].m_nExtTaskID == nExtTaskID then
      return i
    end
  end
  return nil
end

function ExtMissionModule:_FindExtTaskDetail(nExtMissionID, nExtTaskID)
  local extMission = self:_FindExtMissionDetail(nExtMissionID)
  return self:_FindExtTaskDetail2(extMission, nExtTaskID)
end

function ExtMissionModule:_IsConditionPass(vecCondition, nConditionID)
  if type(vecCondition) == "number" then
    return vecCondition == nConditionID
  end
  for _, conditionPass in pairs(vecCondition) do
    if conditionPass == nConditionID then
      return true
    end
  end
  return false
end

function ExtMissionModule._LessComparer(nItemIDA, nItemIDB)
  local cfgItemA = Cfg.cfg_item[nItemIDA.assetid]
  local cfgItemB = Cfg.cfg_item[nItemIDB.assetid]
  if cfgItemA.Color < cfgItemB.Color then
    return -1
  elseif cfgItemA.Color > cfgItemB.Color then
    return 1
  elseif nItemIDA.assetid < nItemIDB.assetid then
    return 1
  elseif nItemIDA.assetid > nItemIDB.assetid then
    return -1
  else
    return 0
  end
end

function ExtMissionModule:_CopyItemData(cfgItemID, cfgItemCount)
  local vecSort = SortedArray:New(Algorithm.COMPARE_CUSTOM, ExtMissionModule._LessComparer)
  for i = 1, #cfgItemID do
    local roleAsset = RoleAsset:New()
    roleAsset.assetid = tonumber(cfgItemID[i])
    roleAsset.count = tonumber(cfgItemCount[i])
    vecSort:Insert(roleAsset)
  end
  return vecSort.elements
end

function ExtMissionModule:_ConvertCondition(vecPassCondition, nConditionID)
  local uiExtCondition = UI_DetailExtCondition:New()
  uiExtCondition.m_nID = nConditionID
  uiExtCondition.m_nParam = 0
  uiExtCondition.m_stDest = self:_GetConditionDesc(nConditionID)
  uiExtCondition.m_bPass = self:_IsConditionPass(vecPassCondition, nConditionID)
  return uiExtCondition
end

function ExtMissionModule:IsExtTaskPass(nExtTaskID)
  for keyExtID, extMission in pairs(self.m_mapExtMission) do
    local detailExtTask = self:_FindExtTaskDetail2(extMission, nExtTaskID)
    if detailExtTask then
      if detailExtTask.m_nStarCount > 0 then
        return true
      else
        return false
      end
    end
  end
  return false
end

function ExtMissionModule:_IsNewExtMission(nExtMissionID)
  local nCount = self.m_vecNewExtMission:Size()
  if nCount <= 0 then
    return false
  end
  for i = 1, nCount do
    if self.m_vecNewExtMission:GetAt(i) == nExtMissionID then
      return true
    end
  end
  return false
end

function ExtMissionModule:UI_ClearNewExtMission(nExtMissionID)
  self.m_vecNewExtMission:Remove(nExtMissionID)
end

function ExtMissionModule:UI_IsFirstFail(nExtMissionID, nExtTaskID)
  local detailTask = self:_FindExtTaskDetail(nExtMissionID, nExtTaskID)
  if detailTask and detailTask.m_nFailCount < 1 then
    return true
  end
  return false
end

function ExtMissionModule:UI_GetExtMissionAward(nExtMissionID)
  local cfgExtMission = Cfg.cfg_extra_mission[nExtMissionID]
  if nil == cfgExtMission then
    return nil
  end
  local uiExtMission = UI_DetailExtMission:New()
  uiExtMission.m_nID = nExtMissionID
  uiExtMission.m_stName = StringTable.Get(cfgExtMission.ExtMissionName)
  local detailExtMission = self:_FindExtMissionDetail(nExtMissionID)
  if detailExtMission then
    uiExtMission.m_nStarCount = detailExtMission.m_nStarCount
  end
  for i = 1, #cfgExtMission.AwardStar do
    local nCfgStarCount = cfgExtMission.AwardStar[i]
    local uiExtAward = UI_DetailExtAward:New()
    uiExtAward.m_nStarCount = nCfgStarCount
    uiExtAward.m_nAwardStat = EnumAwardRecord.Disable
    if detailExtMission then
      local awardLevel = UI_AwardLevel:New(detailExtMission.m_nAwardRecord)
      uiExtAward.m_nAwardStat = awardLevel:GetAwardStat(detailExtMission.m_nStarCount, nCfgStarCount)
    end
    uiExtAward.m_vecAwardItem = self:_CopyItemData(cfgExtMission.AwardListItemID[i], cfgExtMission.AwardListItemCount[i])
    uiExtMission.m_vecAward[i] = uiExtAward
  end
  return uiExtMission
end

function ExtMissionModule:UI_GetExtTaskDetail(nExtMissionID, nExtTaskID)
  local cfgExt = Cfg.cfg_extra_mission[nExtMissionID]
  local cfgTask = Cfg.cfg_extra_mission_task[nExtTaskID]
  local detailTask = self:_FindExtTaskDetail(nExtMissionID, nExtTaskID)
  if nil == detailTask then
    Log.debug("[ExtMission] 没有找到副本关卡详细数据：nExtMissionID=", nExtMissionID, ", nExtTaskID=", nExtTaskID)
  end
  local uiExtTask = UI_DetailExtTask:New()
  uiExtTask.m_nID = nExtTaskID
  uiExtTask.m_stName = StringTable.Get(cfgTask.TaskName)
  uiExtTask.m_stExtName = StringTable.Get(cfgExt.ExtMissionName)
  uiExtTask.m_stDesc = StringTable.Get(cfgTask.TaskDesc)
  uiExtTask.m_vecCondition[1] = self:_ConvertCondition(detailTask.m_vecCondition, cfgTask.ThreeStarCondition1)
  uiExtTask.m_vecCondition[2] = self:_ConvertCondition(detailTask.m_vecCondition, cfgTask.ThreeStarCondition2)
  uiExtTask.m_vecCondition[3] = self:_ConvertCondition(detailTask.m_vecCondition, cfgTask.ThreeStarCondition3)
  if nil ~= detailTask then
    uiExtTask.m_stStarCount = detailTask.m_nStarCount
    uiExtTask.m_awardPerfect.m_nAwardRecord = detailTask.m_nAwardRecord
  end
  uiExtTask.m_awardNormal.m_vecAwardItem = self:_CopyItemData(cfgTask.AwardListItemID, cfgTask.AwardListItemCount)
  uiExtTask.m_awardPerfect.m_vecAwardItem = self:_CopyItemData(cfgTask.PerfectAwardListItemID, cfgTask.PerfectAwardListItemCount)
  uiExtTask.m_nExpendPower = cfgTask.ExpendPower
  return uiExtTask
end

function ExtMissionModule:_IsHaveExtAward(extMissionData)
  local awardLevel = UI_AwardLevel:New(extMissionData.m_nAwardRecord)
  if awardLevel:IsHaveAward(extMissionData.m_nStarCount) then
    return true
  end
  return false
end

function ExtMissionModule:UI_IsExtAwardRed()
  local temp = DDetailExtMission:New()
  for nExtMissionID, extMissionData in pairs(self.m_mapExtMission) do
    if self:_IsHaveExtAward(extMissionData) then
      return true
    end
  end
  return false
end

function ExtMissionModule:UI_IsExtNewChapter()
  for nExtMissionID, extMissionData in pairs(self.m_mapExtMission) do
    local extMissionDataID = extMissionData.m_nExtMissionID
    local key = tostring(GameGlobal.GameLogic():GetOpenId()) .. tostring(extMissionDataID)
    local newState = UnityEngine.PlayerPrefs.HasKey(key)
    if newState then
      local newValue = UnityEngine.PlayerPrefs.GetInt(key)
      if newValue == 1 then
        return true
      end
    end
  end
  return false
end

function ExtMissionModule:UI_GetExtAwardRed(nExtMissionID)
  local detailExtMissionData = self:_FindExtMissionDetail(nExtMissionID)
  if nil == detailExtMissionData then
    return false
  end
  if self:_IsHaveExtAward(detailExtMissionData) then
    return true
  end
  return false
end

local EnumExtMissionState = {
  Disable = 0,
  Open = 1,
  New = 2,
  Down = 3
}
_enum("EnumExtMissionState", EnumExtMissionState)

function ExtMissionModule:UI_GetExtMissionState(nExtMissionID)
  local nReturn = EnumExtMissionState.Disable
  local extMissionData = self:_FindExtMissionDetail(nExtMissionID)
  if nil == extMissionData then
    return nReturn
  end
  local nPassCount = 0
  local nActiveCount = 0
  local nTaskCount = #extMissionData.m_vecExtTask
  if extMissionData.m_nStarCount >= 3 * nTaskCount then
    nPassCount = nTaskCount
  else
    for _, detailExtTask in pairs(extMissionData.m_vecExtTask) do
      if 0 < detailExtTask.m_nStarCount then
        nPassCount = nPassCount + 1
      elseif 0 == detailExtTask.m_nStarCount then
        nActiveCount = nActiveCount + 1
      else
        break
      end
    end
  end
  if nTaskCount <= nPassCount then
    if extMissionData.m_nStarCount >= 3 * nTaskCount then
      nReturn = EnumExtMissionState.Down
    else
      nReturn = EnumExtMissionState.Open
    end
  elseif 0 == nPassCount then
    if 0 < nActiveCount then
      nReturn = EnumExtMissionState.Open
    else
      nReturn = EnumExtMissionState.Disable
    end
  else
    nReturn = EnumExtMissionState.Open
  end
  return nReturn
end

function ExtMissionModule:UI_GetExtTaskState(nExtMissionID, nExtTaskID)
  local detailExtTask = self:_FindExtTaskDetail(nExtMissionID, nExtTaskID)
  if nil == detailExtTask then
    return -100
  end
  return detailExtTask.m_nStarCount
end

function ExtMissionModule:Module_ConvertMatchResult(recvResult, bVictory)
  local uiMatchResult = UI_MatchResult:New()
  uiMatchResult.m_nMatchType = MatchType.MT_ExtMission
  uiMatchResult.m_nID = recvResult.m_nExtTaskID
  local cfgTask = Cfg.cfg_extra_mission_task[recvResult.m_nExtTaskID]
  uiMatchResult.m_stShowName = StringTable.Get(cfgTask.TaskName)
  uiMatchResult.m_stShowDesc = StringTable.Get(cfgTask.TaskDesc)
  uiMatchResult.m_vecCondition[1] = self:_ConvertCondition(recvResult.m_vecCondition, cfgTask.ThreeStarCondition1)
  uiMatchResult.m_vecCondition[2] = self:_ConvertCondition(recvResult.m_vecCondition, cfgTask.ThreeStarCondition2)
  uiMatchResult.m_vecCondition[3] = self:_ConvertCondition(recvResult.m_vecCondition, cfgTask.ThreeStarCondition3)
  uiMatchResult.m_vecAwardNormal = recvResult.m_vecAwardNormal
  uiMatchResult.m_vecFirstPassAward = recvResult.m_firstpass_award
  uiMatchResult.m_vecAwardPerfect = recvResult.m_vecAwardPerfect
  uiMatchResult.m_matchResRolInfo = recvResult.match_result_role_info
  if bVictory then
    local extTaskData = self:_FindExtTaskDetail(recvResult.m_nExtMissionID, recvResult.m_nExtTaskID)
    if extTaskData then
      local nStartCount = 0
      local vecPassCondition = {}
      for i = 1, #uiMatchResult.m_vecCondition do
        local detailExtCondition = uiMatchResult.m_vecCondition[i]
        if detailExtCondition.m_bPass then
          nStartCount = nStartCount + 1
          table.insert(vecPassCondition, detailExtCondition.m_nID)
        end
      end
      if nStartCount >= extTaskData.m_nStarCount then
        extTaskData.m_nStarCount = nStartCount
        extTaskData.m_vecCondition = vecPassCondition
      end
      extTaskData.pass_without_help = recvResult.pass_without_help
    end
  end
  return uiMatchResult
end

function ExtMissionModule:UI_GetPassExtTask(nExtMissionID)
  local detailExtMission = self:_FindExtMissionDetail(nExtMissionID)
  if nil == detailExtMission then
    return {}
  end
  local vecPassTask = {}
  for nTaskID, detailExtTask in pairs(detailExtMission.m_vecExtTask) do
    if detailExtTask.m_nStarCount > 0 then
      table.insert(vecPassTask, detailExtTask.m_nExtTaskID)
    end
  end
  return vecPassTask
end

local EnumEnableGuide = {
  Show = 1,
  Hide = 2,
  Animation = 3
}
_enum("EnumEnableGuide", EnumEnableGuide)

function ExtMissionModule:UI_IsEnableExtMissionGuide()
  local nReturn = EnumEnableGuide.Hide
  if self.m_nGuideExtMission <= 0 then
    local nExtMissionCount = 0
    for keyExtID, extMission in pairs(self.m_mapExtMission) do
      nExtMissionCount = nExtMissionCount + 1
    end
    if 0 < nExtMissionCount then
      nReturn = EnumEnableGuide.Animation
    else
      nReturn = EnumEnableGuide.Hide
    end
  elseif self.m_nGuideExtMission > 0 then
    nReturn = EnumEnableGuide.Show
  end
  return nReturn
end

local EnumLockReason = {
  Unlock = 0,
  Lock_level = 1,
  Lock_mission = 2,
  Lock_extTask = 3,
  Lock_error = 4
}
_enum("EnumLockReason", EnumLockReason)

function ExtMissionModule:UI_GetLockReason(nExtMissionID)
  local cfgExtMission = Cfg.cfg_extra_mission[nExtMissionID]
  if nil == cfgExtMission then
    return EnumLockReason.Lock_error
  end
  local roleModule = self:GetModule(RoleModule)
  local nPlayerLevel = roleModule:GetLevel()
  if nPlayerLevel < cfgExtMission.DependLevel then
    return EnumLockReason.Lock_level, cfgExtMission.DependLevel, nPlayerLevel
  end
  local nDependMissionID = cfgExtMission.DependMissionID
  if 0 < nDependMissionID then
    local missionModule = self:GetModule(MissionModule)
    local bMissionPass = missionModule:GetPassMissionById(nDependMissionID)
    if nil == bMissionPass then
      return EnumLockReason.Lock_mission, nDependMissionID
    end
  end
  local nDependTaskID = cfgExtMission.DependTaskID
  if 0 < nDependTaskID and false == self:IsExtTaskPass(nDependTaskID) then
    return EnumLockReason.Lock_extTask, nDependTaskID
  end
  return EnumLockReason.Unlock
end

function ExtMissionModule:UI_SetCurExtData(nExtMissionID, nExtTaskID)
  self.m_nCurExtMissionID = nExtMissionID
  self.m_nCurExtTaskID = nExtTaskID
end

function ExtMissionModule:UI_GetCurExtData()
  return self.m_nCurExtMissionID, self.m_nCurExtTaskID
end

function ExtMissionModule:UI_IsMissionStoryActive(extTaskID, activeStoryType)
  if nil == self.m_mapExtStory then
    return false
  end
  local storyTask = self.m_mapExtStory[extTaskID]
  if nil == storyTask then
    return false
  end
  local t = storyTask.m_nExtStroyData & activeStoryType
  return t ~= 0
end

function ExtMissionModule:GetErrorMsg(nErrorCode)
  local vecErrorMsg = {
    [ENUM_ExtMission_ErrorCode.E_ExtMission_Success] = StringTable.Get("str_extra_mission_error_success"),
    [ENUM_ExtMission_ErrorCode.E_ExtMission_Fail] = StringTable.Get("str_extra_mission_error_fail"),
    [ENUM_ExtMission_ErrorCode.E_ExtMission_Level] = StringTable.Get("str_extra_mission_error_level"),
    [ENUM_ExtMission_ErrorCode.E_ExtMission_MissionID] = StringTable.Get("str_extra_mission_error_mission_id"),
    [ENUM_ExtMission_ErrorCode.E_ExtMission_TaskID] = StringTable.Get("str_extra_mission_error_task_id"),
    [ENUM_ExtMission_ErrorCode.E_ExtMission_LowPower] = StringTable.Get("str_extra_mission_error_low_power"),
    [ENUM_ExtMission_ErrorCode.E_ExtMission_TaskLock] = StringTable.Get("str_extra_mission_error_task_lock"),
    [ENUM_ExtMission_ErrorCode.E_ExtMission_InvalidStar] = StringTable.Get("str_extra_mission_error_invalid_star"),
    [ENUM_ExtMission_ErrorCode.E_ExtMission_MissionData] = StringTable.Get("str_extra_mission_error_mission_data"),
    [ENUM_ExtMission_ErrorCode.E_ExtMission_AwardOver] = StringTable.Get("str_extra_mission_error_award_over"),
    [ENUM_ExtMission_ErrorCode.E_ExtMission_MissionLock] = StringTable.Get("str_extra_mission_error_mission_lock"),
    [ENUM_ExtMission_ErrorCode.E_ExtMission_StoryType] = StringTable.Get("str_extra_mission_error_story_type"),
    [ENUM_ExtMission_ErrorCode.E_ExtMission_Else] = StringTable.Get("str_extra_mission_error_else")
  }
  local stErrorMsg = vecErrorMsg[nErrorCode]
  if nil == stErrorMsg then
    return "Unknown ErrorCode"
  end
  return stErrorMsg
end

function ExtMissionModule:IsMissionStoryActive(extTaskID, activeStoryType)
  return self:UI_IsMissionStoryActive(extTaskID, activeStoryType)
end

function ExtMissionModule:SetMissionStoryActive(TT, extTaskID, activeType)
  return self:Request_StoryActive(TT, extTaskID, activeType)
end

function ExtMissionModule:UI_SaveExtMissionNewState(ExtTable, BeNew)
  local extTable = ExtTable
  local beNew = BeNew
  if extTable and table.count(extTable) > 0 and beNew then
    local openid = GameGlobal.GameLogic():GetOpenId()
    for _, value in pairs(extTable) do
      local extid = value.m_nExtMissionID
      local key = tostring(openid) .. tostring(extid)
      local newState = UnityEngine.PlayerPrefs.HasKey(key)
      if not newState then
        UnityEngine.PlayerPrefs.SetInt(key, 1)
      else
        local v = UnityEngine.PlayerPrefs.GetInt(key)
        local aa
      end
    end
  end
end
