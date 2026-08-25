local TrinketChoosenType = CommonDefine.TrinketChoosenType
local AwakerTrinketExtModel, Super = NewClass("AwakerTrinketExtModel", TrinketListBaseModel)
local EmptyTrinkets = {}
AwakerTrinketExtModel.EmptyTrinkets = EmptyTrinkets

function AwakerTrinketExtModel:OnInit()
  self:OnReset()
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    EmptyTrinkets[i] = 0
  end
end

function AwakerTrinketExtModel:OnReset()
  Super.OnReset(self)
  self.trinketChoosenType = TrinketChoosenType.SingleTrinket
  self.partType = 1
  self.curChoosenTrinketUid = 0
  self.awakerData = nil
  self.awakerTeamDatas = nil
  self.curAwakerTrinkets = nil
  self.trinketPlaneMap = nil
  self.trinketPlansList = nil
  self.teamModel = nil
  self.curChooseSuitPlanId = 0
  self.teamSlot = 0
end

function AwakerTrinketExtModel:ResetByAwakerData(awakerData, awakerTeamDatas, teamModel, teamSlot, inputTrinkets)
  self.trinketChoosenType = TrinketChoosenType.SingleTrinket
  self.awakerData = awakerData
  self.awakerTeamDatas = awakerTeamDatas
  self.teamSlot = teamSlot
  self.curChoosenTrinketUid = 0
  self.teamModel = teamModel
  local trinkets = self.teamModel and self.teamModel.teamTrinketGroups[self.teamSlot] or nil
  trinkets = trinkets or inputTrinkets or nil
  self.curAwakerTrinkets = self:_CopyAwakerTrinkets(trinkets)
  local strippedTrinkets = self:StripBoundTrinkets(self.curAwakerTrinkets)
  local hasBoundLeak = false
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    local rawUid = self.curAwakerTrinkets and self.curAwakerTrinkets[i] or 0
    if rawUid ~= strippedTrinkets[i] then
      hasBoundLeak = true
    end
  end
  if hasBoundLeak then
    self.curAwakerTrinkets = strippedTrinkets
    self:SyncCurTrinketsToTeamSlot()
    self:SaveTeamToServer()
  end
  self:ResetByPartType(1)
  self.curChooseSuitPlanId = 0
  if self:IsTrinketPlansDataReady() then
    self:CalTrinketPlansList()
  end
end

function AwakerTrinketExtModel:_CopyAwakerTrinkets(trinkets)
  do return TrinketModel.CopyAwakerTrinkets end
  return TrinketModel.CopyAwakerTrinkets, trinkets
end

function AwakerTrinketExtModel:SetCurTrinketChoosenType(trinketChoosenType)
  if self.trinketChoosenType ~= trinketChoosenType then
    self.trinketChoosenType = trinketChoosenType
    if self.trinketChoosenType == TrinketChoosenType.SingleTrinket then
      self.curChoosenTrinketUid = 0
      self:CalFilterTrinketsList()
    else
      self.curChooseSuitPlanId = 0
      self:CalTrinketPlansList()
    end
    self:LocalNotify(NotifyId.OnTrinketChoosenTypeChanged, trinketChoosenType)
  end
end

function AwakerTrinketExtModel:GetCurTrinketChoosenType()
  return self.trinketChoosenType
end

function AwakerTrinketExtModel:SetCurPartType(partType)
  self.partType = partType
  self:CalFilterTrinketsList()
  self:LocalNotify(NotifyId.OnTrinketChoosenPartTypeChanged, partType)
end

function AwakerTrinketExtModel:GetCurPartType()
  return self.partType
end

function AwakerTrinketExtModel:SetCurChoosenTrinketUid(curChoosenTrinketUid)
  local lastUid = self.curChoosenTrinketUid
  self.curChoosenTrinketUid = curChoosenTrinketUid
  self:LocalNotify(NotifyId.OnTrinketChoosen, curChoosenTrinketUid, lastUid)
end

function AwakerTrinketExtModel:GetCurChoosenTrinketUid()
  return self.curChoosenTrinketUid
end

function AwakerTrinketExtModel:GetCurAwakerTid()
  return self.awakerData and self.awakerData.tid or 0
end

function AwakerTrinketExtModel:GetCurTeamType()
  return self.teamModel and self.teamModel.teamType or 0
end

function AwakerTrinketExtModel:GetCurTeamIndex()
  return self.teamModel and self.teamModel.curTeamIndex or 0
end

function AwakerTrinketExtModel:GetTeamSvrIndex()
  return self.teamModel and self.teamModel:GetTeamSvrIdx() or 0
end

function AwakerTrinketExtModel:IsTrinketEquiping(trinketUid)
  if 0 == trinketUid then
    return false
  end
  if not self.curAwakerTrinkets then
    return false
  end
  for _, v in pairs(self.curAwakerTrinkets) do
    if v == trinketUid then
      return true
    end
  end
  return false
end

function AwakerTrinketExtModel:GetTrinketOwnerTid(trinketUid)
  if 0 == trinketUid then
    return false
  end
  local curAwakerTid = self:GetCurAwakerTid()
  if self:IsTrinketEquiping(trinketUid) then
    return curAwakerTid
  end
  if not self.teamModel then
    return 0
  end
  for i = 1, #self.teamModel.teamTrinketGroups do
    local trinkets = self.teamModel.teamTrinketGroups[i]
    if not trinkets or i == self.teamSlot then
    else
      for _, v in pairs(trinkets) do
        if v == trinketUid then
          return self.teamModel:GetTeamAwakerTidBySlot(i)
        end
      end
    end
  end
  return 0
end

function AwakerTrinketExtModel:IsTrinketOwnerInTeam(trinketUid)
  return 0 ~= self:GetTrinketOwnerTid(trinketUid)
end

function AwakerTrinketExtModel:GetCurShowTrinkets()
  local curChoosenType = self:GetCurTrinketChoosenType()
  local isSingleTrinket = curChoosenType == TrinketChoosenType.SingleTrinket
  if isSingleTrinket then
    do return self.GetCurAwakerTrinketsUidList end
    return self.GetCurAwakerTrinketsUidList, self
  else
    do return self.GetCurChoosenPlanTrinkets end
    return self.GetCurChoosenPlanTrinkets, self
  end
end

function AwakerTrinketExtModel:GetCurAwakerTrinketsUidList()
  return self.curAwakerTrinkets
end

function AwakerTrinketExtModel:GetCurEquipTrinketUid()
  if not self.curAwakerTrinkets then
    return 0
  end
  local trinketUid = self.curAwakerTrinkets[self.partType]
  return trinketUid or 0
end

function AwakerTrinketExtModel:GetBoundTrinketUidByPart(partType)
  local awakerTid = self:GetCurAwakerTid()
  if not awakerTid or 0 == awakerTid then
    return 0
  end
  local boundUid = AwakerDataUtils.GetBoundTrinketUid(awakerTid, partType)
  if 0 == boundUid then
    return 0
  end
  if not ItemDataUtils.GetItemByUid(boundUid) then
    return 0
  end
  return boundUid
end

function AwakerTrinketExtModel:GetCurPartBoundTrinketUid()
  do return self.GetBoundTrinketUidByPart, self end
  return self.GetBoundTrinketUidByPart, self, self.partType
end

function AwakerTrinketExtModel:_GetListExemptUid()
  if table.next(AwakerDataUtils.GetMockAwakerMap()) then
    return nil
  end
  do return self.GetCurPartBoundTrinketUid end
  return self.GetCurPartBoundTrinketUid, self
end

function AwakerTrinketExtModel:_PlaceAwakerEquipTrinketToFirstPos()
  local boundUid = self:_GetListExemptUid()
  if boundUid and 0 ~= boundUid then
    local list = self.curFilterTrinkets
    if list then
      local index = -1
      for i = 1, #list do
        if list[i].uid == boundUid then
          index = i
          break
        end
      end
      if index > 1 then
        local trinket = table.remove(list, index)
        table.insert(list, 1, trinket)
      end
    end
  end
  Super._PlaceAwakerEquipTrinketToFirstPos(self)
end

function AwakerTrinketExtModel:IsAwakerEquipAnyTrinkets()
  if not self.curAwakerTrinkets then
    return false
  end
  do return TrinketModel.Instance.ExistsAnyTrinkets, TrinketModel.Instance end
  return TrinketModel.Instance.ExistsAnyTrinkets, TrinketModel.Instance, self.curAwakerTrinkets
end

function AwakerTrinketExtModel:IsAwakerEquipAnyRealTrinkets()
  if not self.curAwakerTrinkets then
    return false
  end
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    local uid = self.curAwakerTrinkets[i]
    if 0 ~= uid and not AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) then
      return true
    end
  end
  return false
end

function AwakerTrinketExtModel:GetDisplayTrinketMapWithBound(awakerTid, trinketUids)
  if not (trinketUids and awakerTid) or 0 == awakerTid then
    return trinketUids
  end
  if table.next(AwakerDataUtils.GetMockAwakerMap()) then
    return trinketUids
  end
  local displayMap = {}
  local hasSubstitute = false
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    local uid = trinketUids[i] or 0
    if 0 == uid then
      local boundUid = AwakerDataUtils.GetBoundTrinketUidFormAware(awakerTid, i)
      if 0 ~= boundUid and ItemDataUtils.GetItemByUid(boundUid) then
        uid = boundUid
        hasSubstitute = true
      end
    end
    displayMap[i] = uid
  end
  if not hasSubstitute then
    return trinketUids
  end
  return displayMap
end

function AwakerTrinketExtModel:GetCurAwakerTrinketsDisplayMap()
  do return self.GetDisplayTrinketMapWithBound, self, self:GetCurAwakerTid(), self:GetCurAwakerTrinketsUidList() end
  return self.GetDisplayTrinketMapWithBound, self, self:GetCurAwakerTid(), self:GetCurAwakerTrinketsUidList()
end

function AwakerTrinketExtModel:StripBoundTrinkets(trinkets)
  local rst = {}
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    local uid = trinkets and trinkets[i] or 0
    if 0 ~= uid and AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) then
      uid = 0
    end
    rst[i] = uid
  end
  return rst
end

function AwakerTrinketExtModel:GetBoundTrinketOwnerTid(trinketUid)
  if not trinketUid or 0 == trinketUid then
    return 0
  end
  local boundAwakerTid = AwakerDataUtils.IsTrinketBoundByAnyAwaker(trinketUid)
  if not boundAwakerTid then
    return 0
  end
  local itemData = ItemDataUtils.GetItemByUid(trinketUid)
  local ownerTid = itemData and itemData.awaker or 0
  if ownerTid and 0 ~= ownerTid then
    return ownerTid
  end
  return boundAwakerTid
end

function AwakerTrinketExtModel:PutOffTrinket(trinketUid)
  if not self.curAwakerTrinkets then
    return
  end
  for k, v in pairs(self.curAwakerTrinkets) do
    if v == trinketUid then
      self.curAwakerTrinkets[k] = 0
      break
    end
  end
  self:SyncCurTrinketsToTeamSlot()
  Logger.ReportApusInfo("DBGTeam SaveTeamToServer PutOff Trinket")
  self:SaveTeamToServer()
  local trinketItem = ItemDataUtils.GetItemByUid(trinketUid)
  if trinketItem then
    TrinketSortingModel.Instance:CalSortingParam(trinketItem)
  end
  self:LocalNotify(NotifyId.OnTrinketUnequiped, trinketUid)
end

function AwakerTrinketExtModel:PutOnTrinket(trinketUid)
  if not self.curAwakerTrinkets then
    return
  end
  local trinket = ItemDataUtils.GetItemByUid(trinketUid)
  if not trinket then
    return
  end
  local pos = ItemDataUtils.GetTrinketPosIndex(trinket)
  local awaker = self:GetTrinketOwnerTid(trinketUid)
  local curUid
  if awaker and 0 ~= awaker then
    curUid = self:GetCurEquipTrinketUid()
    self:ReplaceOtherAwakerTrinket(awaker, pos, curUid)
  end
  self.curAwakerTrinkets[pos] = trinketUid
  self:SyncCurTrinketsToTeamSlot()
  Logger.ReportApusInfo("DBGTeam SaveTeamToServer PutOn Trinket")
  self:SaveTeamToServer()
  if curUid then
    local curItem = ItemDataUtils.GetItemByUid(curUid)
    if curItem then
      TrinketSortingModel.Instance:CalSortingParam(curItem)
    end
  end
  local trinketItem = ItemDataUtils.GetItemByUid(trinketUid)
  if trinketItem then
    TrinketSortingModel.Instance:CalSortingParam(trinketItem)
  end
  self:LocalNotify(NotifyId.OnTrinketEquiped, trinketUid)
end

function AwakerTrinketExtModel:TakeOffAllTrinkets()
  if not self.curAwakerTrinkets then
    return
  end
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    local trinketItem = ItemDataUtils.GetItemByUid(self.curAwakerTrinkets[i])
    if trinketItem then
      TrinketSortingModel.Instance:CalSortingParam(trinketItem)
    end
    self.curAwakerTrinkets[i] = 0
  end
  self:SyncCurTrinketsToTeamSlot()
  Logger.ReportApusInfo("DBGTeam SaveTeamToServer TakeOff All Trinket")
  self:SaveTeamToServer()
  self:LocalNotify(NotifyId.OnAwakerTakeoffAllTrinkets)
end

function AwakerTrinketExtModel:EquipRecommendTrinkets(svrData)
  self.curAwakerTrinkets = self:_CopyAwakerTrinkets(svrData)
  self:SyncCurTrinketsToTeamSlot()
  self:UnEquipOtherAwakerTrinkets(svrData)
  Logger.ReportApusInfo("DBGTeam SaveTeamToServer Recommend Trinket")
  self:SaveTeamToServer()
  self:LocalNotify(NotifyId.OnAwakerEquipRecommendTrinket)
end

function AwakerTrinketExtModel:IsTrinketPlansDataReady()
  return self.trinketPlaneMap ~= nil
end

function AwakerTrinketExtModel:OnTrinketPlansData(svrData)
  self.trinketPlaneMap = {}
  for k, v in pairs(svrData or {}) do
    self.trinketPlaneMap[k] = {
      id = v.id,
      name = v.name,
      trinkets = v.trinkets
    }
  end
  self:CalTrinketPlansList()
  self:LocalNotify(NotifyId.OnTrinketPlansData)
end

function AwakerTrinketExtModel:SetChooseSuitPlanId(curChooseSuitPlanId)
  if self.curChooseSuitPlanId ~= curChooseSuitPlanId then
    self.curChooseSuitPlanId = curChooseSuitPlanId
    self:LocalNotify(NotifyId.OnTrinketSuitPlanChoosen, curChooseSuitPlanId)
  end
end

function AwakerTrinketExtModel:GetChooseSuitPlanId()
  return self.curChooseSuitPlanId
end

function AwakerTrinketExtModel:GetCurPlansCount()
  return self.trinketPlansList and #self.trinketPlansList or 0
end

function AwakerTrinketExtModel:CalTrinketPlansList()
  self.trinketPlansList = {}
  local suitTypeInfoDict = {}
  for k, v in pairs(self.trinketPlaneMap) do
    table.insert(self.trinketPlansList, v)
    suitTypeInfoDict[v.id] = AwakerTrinketDataUtils.GetSuitTypeInfo(v.trinkets)
  end
  local curEquipPlanId = self:GetCurEquipingPlanId()
  local curEquipPlanSuitTypeInfo = curEquipPlanId and suitTypeInfoDict[curEquipPlanId]
  local curSuitId = curEquipPlanSuitTypeInfo and curEquipPlanSuitTypeInfo.fullSuitId or 0
  table.sort(self.trinketPlansList, function(a, b)
    local aSuitTypeInfo = suitTypeInfoDict[a.id]
    local bSuitTypeInfo = suitTypeInfoDict[b.id]
    if a.id == curEquipPlanId or b.id == curEquipPlanId then
      return a.id == curEquipPlanId
    end
    if aSuitTypeInfo.suitType ~= bSuitTypeInfo.suitType then
      return aSuitTypeInfo.suitType < bSuitTypeInfo.suitType
    end
    if aSuitTypeInfo.suitType == CommonDefine.SuitType.Full and bSuitTypeInfo.suitType == CommonDefine.SuitType.Full then
      if (aSuitTypeInfo.fullSuitId == curSuitId or bSuitTypeInfo.fullSuitId == curSuitId) and aSuitTypeInfo.fullSuitId ~= bSuitTypeInfo.fullSuitId then
        return aSuitTypeInfo.fullSuitId == curSuitId
      end
      if aSuitTypeInfo.BaseSortId ~= bSuitTypeInfo.BaseSortId then
        return aSuitTypeInfo.BaseSortId < bSuitTypeInfo.BaseSortId
      end
    end
    if aSuitTypeInfo.refineCompletePercent ~= bSuitTypeInfo.refineCompletePercent then
      return aSuitTypeInfo.refineCompletePercent > bSuitTypeInfo.refineCompletePercent
    end
    if aSuitTypeInfo.levelCompletePercent ~= bSuitTypeInfo.levelCompletePercent then
      return aSuitTypeInfo.levelCompletePercent > bSuitTypeInfo.levelCompletePercent
    end
    return a.id > b.id
  end)
  if 0 == self.curChooseSuitPlanId and #self.trinketPlansList > 0 then
    self.curChooseSuitPlanId = self.trinketPlansList[1].id
  end
end

function AwakerTrinketExtModel:GetPlansList()
  return self.trinketPlansList
end

function AwakerTrinketExtModel:GetTrinketPlanData(planId)
  if not self.trinketPlaneMap then
    return
  end
  return self.trinketPlaneMap[planId]
end

function AwakerTrinketExtModel:GetTrinketPlanName(planId)
  local planData = self:GetTrinketPlanData(planId)
  return planData and planData.name or nil
end

function AwakerTrinketExtModel:GetTrinketPlanId(trinketUid)
  if not (self.trinketPlaneMap and trinketUid) or 0 == trinketUid then
    return 0
  end
  for _, v in pairs(self.trinketPlaneMap) do
    if not v.trinkets then
    else
      for _, v1 in pairs(v.trinkets) do
        if v1 == trinketUid then
          return v.id
        end
      end
    end
  end
  return 0
end

function AwakerTrinketExtModel:IsTrinketUsing(uid)
  if DBGTeamDataUtils.GetTrinketInTeamIdx(CommonDefine.TeamType.Normal, uid) then
    return true
  end
  if 0 ~= self:GetTrinketPlanId(uid) then
    return true
  end
  if 0 ~= uid and table.contains(SocialDataUtils.GetPreviewAwakerTrinketUids(), uid) then
    return true
  end
  return false
end

function AwakerTrinketExtModel:GetPlanIdByTrinkets(trinkets)
  if not trinkets then
    return 0
  end
  local part2UidMap = {}
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    part2UidMap[i] = 0
  end
  for _, uid in pairs(trinkets) do
    if uid and 0 ~= uid then
      local trinket = ItemDataUtils.GetItemByUid(uid)
      if trinket then
        local pos = ItemDataUtils.GetTrinketPosIndex(trinket)
        part2UidMap[pos] = uid
      end
    end
  end
  for _, v in pairs(self.trinketPlaneMap) do
    if not v.trinkets then
    else
      local isSamed = true
      for i = 1, CommonDefine.MaxEquipTrinketsNum do
        if v.trinkets[i] ~= part2UidMap[i] then
          isSamed = false
          break
        end
      end
      if isSamed then
        return v.id
      end
    end
  end
  return 0
end

function AwakerTrinketExtModel:GenPlanId()
  local maxId = 0
  for _, v in pairs(self.trinketPlaneMap) do
    if maxId < v.id then
      maxId = v.id
    end
  end
  local planId = maxId + 1
  if planId > DT.GetConstant("MaximumNumberOfTrinketPlan") then
    for i = 1, DT.GetConstant("MaximumNumberOfTrinketPlan") do
      if not self:GetPlanTrinkets(i) then
        return i
      end
    end
    Logger.Error("GenPlayId: %s > MaximumNumberOfTrinketPlan: %s", planId, DT.GetConstant("MaximumNumberOfTrinketPlan"))
  end
  return planId
end

function AwakerTrinketExtModel:GetPlanNameLenghtMin()
  return DT.Constant.TrinketPlanNameLengthRange.Data[1]
end

function AwakerTrinketExtModel:GetPlanNameLenghtMax()
  return DT.Constant.TrinketPlanNameLengthRange.Data[2]
end

function AwakerTrinketExtModel:IsPlanNameLenValid(name)
  local lenMinLimit = self:GetPlanNameLenghtMin()
  local lenMaxLimit = self:GetPlanNameLenghtMax()
  local len = StrUtils.GetCharLen(name or "")
  if lenMinLimit <= len and lenMaxLimit >= len then
    return true
  end
  return false
end

function AwakerTrinketExtModel:GetTrinketPlanIcon(planId)
  local planData = self:GetTrinketPlanData(planId)
  if TrinketModel.Instance:IsSuitGatherAll(planData.trinkets) then
    local trinket = ItemDataUtils.GetItemByUid(planData.trinkets[1])
    do return AwakerTrinketDataUtils.GetSuitIcon end
    return AwakerTrinketDataUtils.GetSuitIcon, trinket.suitId
  end
end

function AwakerTrinketExtModel:IsTrinketPlanEquipedInTeamTrinketGroups(planId, teamTrinketGroups)
  if not teamTrinketGroups then
    return false
  end
  for i = 1, #teamTrinketGroups do
    local trinkets = teamTrinketGroups[i]
    if trinkets then
      local id = self:GetPlanIdByTrinkets(trinkets)
      if id == planId then
        return true
      end
    end
  end
  return false
end

function AwakerTrinketExtModel:GetCurPartPlanTrinketUid()
  local trinkets = self:GetCurChoosenPlanTrinkets()
  if not trinkets then
    return 0
  end
  local trinketUid = trinkets[self.partType]
  return trinketUid or 0
end

function AwakerTrinketExtModel:GetPlanTrinkets(planId)
  local planData = self:GetTrinketPlanData(planId)
  if not planData then
    return
  end
  return planData.trinkets or EmptyTrinkets
end

function AwakerTrinketExtModel:GetCurChoosenPlanTrinkets()
  local curChooseSuitPlanId = self:GetChooseSuitPlanId()
  do return self.GetPlanTrinkets, self end
  return self.GetPlanTrinkets, self, curChooseSuitPlanId
end

function AwakerTrinketExtModel:UpdateAwakerTrinketSuitPlan(planData)
  local prePlanData = self.trinketPlaneMap[planData.id]
  local isNewPlan = not prePlanData
  prePlanData = prePlanData or {}
  prePlanData.id = planData.id
  prePlanData.name = planData.name
  prePlanData.trinkets = self:_CopyAwakerTrinkets(planData.trinkets)
  self.trinketPlaneMap[planData.id] = prePlanData
  self:CalTrinketPlansList()
  self.curChooseSuitPlanId = planData.id
  self:LocalNotify(NotifyId.OnAwakerTrinketSuitPlanUpdate, planData.id, isNewPlan)
end

function AwakerTrinketExtModel:DeleteAwakerTrinketSuitPlan(planId)
  self.trinketPlaneMap[planId] = nil
  if self.curChooseSuitPlanId == planId then
    self.curChooseSuitPlanId = 0
  end
  self:CalTrinketPlansList()
  self:LocalNotify(NotifyId.OnDeleteTrinketSuitPlan, planId)
end

function AwakerTrinketExtModel:EquipSuitPlan(planId)
  local planData = self:GetTrinketPlanData(planId)
  self.curAwakerTrinkets = self:_CopyAwakerTrinkets(planData.trinkets)
  self:SyncToTeamSlot(self.teamSlot, planData.trinkets)
  self:UnEquipOtherAwakerTrinkets(planData.trinkets)
  Logger.ReportApusInfo("DBGTeam SaveTeamToServer EquipSuitPlan Trinket")
  self:SaveTeamToServer()
  self:Notify(NotifyId.OnAwakerEquipedTrinketSuit, planId, self.teamSlot)
end

function AwakerTrinketExtModel:SaveTeamToServer()
  if self.teamModel then
    self.teamModel:SaveTeamToServer(nil, true)
  end
end

function AwakerTrinketExtModel:SyncCurTrinketsToTeamSlot()
  if not self.teamModel then
    return
  end
  self:SyncToTeamSlot(self.teamSlot, self.curAwakerTrinkets)
end

function AwakerTrinketExtModel:SyncToTeamSlot(slot, awakerTrinkets)
  if not self.teamModel then
    return
  end
  self.teamModel:SetTrinketsGroupWithTeamSlot(self:_CopyAwakerTrinkets(awakerTrinkets), slot)
  GlobalDispatcher:Dispatch(NotifyId.OnTeamSlotTrinketsChanged, slot)
end

function AwakerTrinketExtModel:UnEquipOtherAwakerTrinkets(trinkets)
  if not (trinkets and self.teamModel) or not self.teamModel.teamTrinketGroups then
    return
  end
  local uidMap = {}
  for _, v in pairs(trinkets) do
    uidMap[v] = true
  end
  for i = 1, #self.teamModel.teamTrinketGroups do
    if i == self.teamSlot then
    else
      local isNeedUnequiped = false
      local awakerTrinkets = self:_CopyAwakerTrinkets(self.teamModel.teamTrinketGroups[i])
      for j = 1, #awakerTrinkets do
        if uidMap[awakerTrinkets[j]] then
          awakerTrinkets[j] = 0
          isNeedUnequiped = true
        end
      end
      if isNeedUnequiped then
        self.teamModel:GetTeamAwakerTidBySlot(i)
        self.teamModel:SetTrinketsGroupWithTeamSlot(awakerTrinkets, i)
      end
    end
  end
end

function AwakerTrinketExtModel:ReplaceOtherAwakerTrinket(awakerTid, partType, uid)
  if not self.teamModel or not self.teamModel.teamTrinketGroups then
    return
  end
  for i = 1, #self.teamModel.teamTrinketGroups do
    if i == self.teamSlot then
    else
      local slotAwakerTid = self.teamModel:GetTeamAwakerTidBySlot(i)
      if slotAwakerTid == awakerTid then
        local awakerTrinkets = self:_CopyAwakerTrinkets(self.teamModel.teamTrinketGroups[i])
        awakerTrinkets[partType] = uid
        self:SyncToTeamSlot(i, awakerTrinkets)
        break
      end
    end
  end
end

function AwakerTrinketExtModel:IsEquipingPlan(planId)
  local curPlanId = self:GetCurEquipingPlanId()
  if curPlanId == planId then
    return true
  end
  return false
end

function AwakerTrinketExtModel:GetCurEquipingPlanId()
  do return self.GetPlanIdByTrinkets, self end
  return self.GetPlanIdByTrinkets, self, self.curAwakerTrinkets
end

function AwakerTrinketExtModel:GetTrinketPlanOwnerTid(planId)
  local curAwakerTid = self:GetCurAwakerTid()
  if self:IsEquipingPlan(planId) then
    return curAwakerTid
  end
  if not self.teamModel then
    return 0
  end
  for i = 1, #self.teamModel.teamTrinketGroups do
    local trinkets = self.teamModel.teamTrinketGroups[i]
    if not trinkets or i == self.teamSlot then
    else
      local eqPlanId = self:GetPlanIdByTrinkets(trinkets)
      if eqPlanId == planId then
        do return self.teamModel.GetTeamAwakerTidBySlot, self.teamModel end
        return self.teamModel.GetTeamAwakerTidBySlot, self.teamModel, i
      end
    end
  end
  return 0
end

function AwakerTrinketExtModel:DeleteTrinkets(trinketUids)
  if not trinketUids then
    return
  end
  for _, uid in pairs(trinketUids) do
    self:DeleteTrinketFromPlan(uid)
  end
  self:_ClearEmptyPlans()
  GlobalDispatcher:Dispatch(NotifyId.OnTrinketsDeleted, trinketUids)
end

function AwakerTrinketExtModel:_ClearEmptyPlans()
  if self.trinketPlaneMap then
    local temp = {}
    table.mergeWithoutGc(temp, self.trinketPlaneMap)
    local hit = false
    for k, v in pairs(temp) do
      if not TrinketModel.Instance:ExistsAnyTrinkets(v.trinkets) then
        self.trinketPlaneMap[k] = nil
        hit = true
      end
      if k == self.curChooseSuitPlanId then
        self.curChooseSuitPlanId = 0
      end
    end
    if hit then
      self:CalTrinketPlansList()
    end
  end
end

function AwakerTrinketExtModel:DeleteTrinketFromPlan(uid)
  local planId = self:GetTrinketPlanId(uid)
  if 0 == planId then
    return
  end
  local planData = self:GetTrinketPlanData(planId)
  if not planData or not planData.trinkets then
    return
  end
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    if planData.trinkets[i] == uid then
      planData.trinkets[i] = 0
      break
    end
  end
end

function AwakerTrinketExtModel:DeleteTrinketFromTrinketsList(trinketUids)
  if not trinketUids then
    return
  end
  for _, uid in pairs(trinketUids) do
    self:_DeleteTrinketFromEquipingList(uid)
  end
  Super.DeleteTrinketFromTrinketsList(self, trinketUids)
end

function AwakerTrinketExtModel:_DeleteTrinketFromEquipingList(uid)
  if not self.curAwakerTrinkets then
    return
  end
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    if self.curAwakerTrinkets[i] == uid then
      self.curAwakerTrinkets[i] = 0
      break
    end
  end
end

function AwakerTrinketExtModel:HandleTrinketBoundResponse(svrData, awakerTid, localUpdateFn)
  if svrData and svrData.boundTrinkets then
    AwakerDataUtils.UpdateBoundTrinkets(awakerTid, svrData.boundTrinkets)
  elseif localUpdateFn then
    local boundTrinkets = {}
    for k, v in pairs(AwakerDataUtils.GetBoundTrinkets(awakerTid)) do
      boundTrinkets[k] = v
    end
    localUpdateFn(boundTrinkets)
    AwakerDataUtils.UpdateBoundTrinkets(awakerTid, boundTrinkets)
  end
  if self:IsTrinketPlansDataReady() then
    if svrData and svrData.changedSuits then
      for _, planData in pairs(svrData.changedSuits) do
        if planData and planData.id then
          self:UpdateAwakerTrinketSuitPlan(planData)
        end
      end
    end
    if svrData and svrData.removedSuitIds then
      for _, planId in pairs(svrData.removedSuitIds) do
        if planId then
          self:DeleteAwakerTrinketSuitPlan(planId)
        end
      end
    end
  end
  if svrData and svrData.changedTeams and table.next(svrData.changedTeams) then
    for teamType, teamsMap in pairs(svrData.changedTeams) do
      for idx, teamData in pairs(teamsMap or {}) do
        if teamType and idx and teamData then
          DBGTeamDataUtils.ParseShowOneTeamData(teamType, idx, teamData)
        end
      end
    end
  end
  DBGTeamDataUtils.RefreshAllReqShowTeam()
  GlobalDispatcher:Dispatch(NotifyId.OnTrinketBoundDataChanged, awakerTid)
end

function AwakerTrinketExtModel:CalTrinketAttrsFromTeamModel(teamModel, equipsAttrs)
  local maxNum = CommonDefine.TeamAssign.MaxBattleNum
  for slotIndex = 1, maxNum do
    equipsAttrs = self:CalTrinketAttrsFromTeamSlot(teamModel, slotIndex, equipsAttrs)
  end
  return equipsAttrs
end

function AwakerTrinketExtModel:CollectTrinketItemsFromTeamSlot(teamModel, slotIndex)
  local trinkets = {}
  if not teamModel then
    return trinkets
  end
  local assistAwaker = teamModel:GetAssistAwaker()
  if slotIndex == CommonDefine.TeamAssign.MaxBattleNum and assistAwaker then
    local trinketUids = assistAwaker.trinkets
    if not trinketUids then
      return trinkets
    end
    local assistItems = teamModel:GetAssistItem()
    if not assistItems then
      return trinkets
    end
    for _, uid in pairs(trinketUids) do
      local item = assistItems[uid]
      if item then
        table.insert(trinkets, item)
      end
    end
  else
    local tid = teamModel:GetTeamAwakerTidBySlot(slotIndex)
    if not tid or 0 == tid then
      return trinkets
    end
    local trinketUids = teamModel:GetTeamTrinketGroupBySlot(slotIndex)
    if not trinketUids then
      return trinkets
    end
    trinketUids = self:GetDisplayTrinketMapWithBound(tid, trinketUids)
    for _, uid in pairs(trinketUids) do
      local item = ItemDataUtils.GetBagItemByUid(uid) or ItemDataUtils.GetItemByUid(uid)
      if item then
        table.insert(trinkets, item)
      end
    end
  end
  return trinkets
end

function AwakerTrinketExtModel:GetSlotBoundTrinkets(teamModel, slotIndex)
  if not teamModel or slotIndex ~= CommonDefine.TeamAssign.MaxBattleNum then
    return nil
  end
  local assistAwaker = teamModel:GetAssistAwaker()
  if not assistAwaker then
    return nil
  end
  do return AwakerTrinketDataUtils.GetSnapshotBoundTrinkets end
  return AwakerTrinketDataUtils.GetSnapshotBoundTrinkets, assistAwaker
end

function AwakerTrinketExtModel:CollectSlotBindContributions(teamModel, slotIndex)
  local trinkets = self:CollectTrinketItemsFromTeamSlot(teamModel, slotIndex)
  do return AwakerTrinketDataUtils.CollectBindBonusMainContributions, trinkets, self:GetSlotBoundTrinkets(teamModel, slotIndex) end
  return AwakerTrinketDataUtils.CollectBindBonusMainContributions, trinkets, self:GetSlotBoundTrinkets(teamModel, slotIndex)
end

function AwakerTrinketExtModel:CalTrinketAttrsFromTeamSlot(teamModel, slotIndex, equipsAttrs)
  if not teamModel then
    return equipsAttrs
  end
  local trinkets = self:CollectTrinketItemsFromTeamSlot(teamModel, slotIndex)
  equipsAttrs = equipsAttrs or {}
  local attrsMap = TrinketModel.Instance:GetTrinketAttrs(trinkets)
  for k, v in pairs(attrsMap) do
    if 0 ~= v then
      local curVal = equipsAttrs[k] or 0
      equipsAttrs[k] = curVal + v
    end
  end
  local bindContributions = self:CollectSlotBindContributions(teamModel, slotIndex)
  for attrId, contributions in pairs(bindContributions) do
    local beforeVal = equipsAttrs[attrId] or 0
    equipsAttrs[attrId] = AwakerTrinketDataUtils.GetBindBonusAggDisplayCount(beforeVal, contributions)
  end
  local suitAttrs = TrinketModel.Instance:GetActiveSuitAttrsList(trinkets)
  if suitAttrs then
    for _, v in pairs(suitAttrs) do
      local curVal = equipsAttrs[v.attrId] or 0
      equipsAttrs[v.attrId] = curVal + v.val
    end
  end
  return equipsAttrs
end

return AwakerTrinketExtModel
