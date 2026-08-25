local AwakerTrinketController = NewClass("AwakerTrinketController", BaseController)

function AwakerTrinketController:OnInit()
end

function AwakerTrinketController:OnReset()
end

function AwakerTrinketController:ReqTrinketSuitPlans()
  if AwakerTrinketExtModel.Instance:IsTrinketPlansDataReady() then
    return
  end
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("TrinketRequest", "OnOpen", function(svrData)
    AwakerTrinketExtModel.Instance:OnTrinketPlansData(svrData)
  end, function(svrData)
    Logger.Info(">>>>>> 密契套装数据请求失败:", table.tostring(svrData))
  end)
end

function AwakerTrinketController:OpenChangeTrinketSuitPlanNameView(viewData)
  if 0 == viewData.suitPlanId then
    return
  end
  viewData.onlyChangeName = true
  UIManager.Instance:Reopen(Urls.TrinketSuitPlaneSavedView, viewData)
end

function AwakerTrinketController:OpenTrinketSuitPlanView(viewData)
  if not TrinketModel.Instance:ExistsAnyTrinkets(viewData.trinkets) then
    Alert.Show(10810)
    return
  end
  if self:_HasBoundTrinketInPlan(viewData.trinkets) then
    return
  end
  local curPlanCount = AwakerTrinketExtModel.Instance:GetCurPlansCount()
  local maxiNumberOfTrinketPlan = DT.GetConstant("MaximumNumberOfTrinketPlan")
  if 0 == viewData.suitPlanId and curPlanCount >= maxiNumberOfTrinketPlan then
    Alert.Show(10801)
    return
  end
  local trinkets = viewData.trinkets
  local existPlanUid = {}
  for k, v in pairs(trinkets) do
    local planId = AwakerTrinketExtModel.Instance:GetTrinketPlanId(v)
    if 0 ~= planId and planId ~= viewData.suitPlanId then
      table.insert(existPlanUid, v)
    end
  end
  if #existPlanUid > 0 then
    local trinketsName = {}
    for i = 1, #existPlanUid do
      local itemData = ItemDataUtils.GetItemByUid(existPlanUid[i])
      local trinketName = ItemDataUtils.GetItemName(itemData.tid)
      table.insert(trinketsName, trinketName)
    end
    local tips = ""
    local tipConfig = DT.TipsType[10802]
    if tipConfig then
      tips = LT.Textf(tipConfig.Desc, table.concat(trinketsName, LT.Text("TextComma")))
    end
    Alert.Show(10802, nil, nil, nil, tips)
    return
  end
  viewData.onlyChangeName = false
  UIManager.Instance:Reopen(Urls.TrinketSuitPlaneSavedView, viewData)
end

function AwakerTrinketController:ReqEquipTrinket(trinketUid)
  if not trinketUid or 0 == trinketUid then
    return
  end
  local trinketData = ItemDataUtils.GetItemByUid(trinketUid)
  if not trinketData then
    Logger.Info("找不到密契:", trinketUid)
    return
  end
  if AwakerTrinketExtModel.Instance:IsTrinketEquiping(trinketUid) then
    self:ReqPutOffTrinket(trinketUid)
  else
    self:ReqPutOnTrinket(trinketUid)
  end
end

function AwakerTrinketController:ReqPutOffTrinket(uid)
  if not uid or 0 == uid then
    return
  end
  AwakerTrinketExtModel.Instance:PutOffTrinket(uid)
end

function AwakerTrinketController:ReqPutOnTrinket(uid)
  if not uid or 0 == uid then
    return
  end
  if AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) then
    return
  end
  local awakerTid = AwakerTrinketExtModel.Instance:GetCurAwakerTid()
  if not awakerTid or 0 == awakerTid then
    return
  end
  local trinketData = ItemDataUtils.GetItemByUid(uid)
  if not trinketData then
    Logger.Info("找不到饰品:", uid)
    return
  end
  local awaker = AwakerTrinketExtModel.Instance:GetTrinketOwnerTid(uid)
  if awaker and awaker > 0 then
    local awakerTitle = AwakerDataUtils.GetAwakerTitle(awaker)
    local itemName = TrinketModel:GetTrinketName(trinketData.tid, false)
    local desc = LT.Textf(DT.TipsType[20049].Desc, itemName, awakerTitle)
    Alert.Show(20049, nil, function()
      AwakerTrinketExtModel.Instance:PutOnTrinket(uid)
    end, nil, desc)
    return
  end
  AwakerTrinketExtModel.Instance:PutOnTrinket(uid)
end

function AwakerTrinketController:TakeOffAllTrinkets()
  AwakerTrinketExtModel.Instance:TakeOffAllTrinkets()
end

function AwakerTrinketController:ReqEquipRecommendTrinket()
  local trinkets = AwakerTrinketExtModel.Instance:GetCurAwakerTrinketsUidList()
  local freeSlots = {}
  for i = 1, CommonDefine.MaxEquipTrinketsNum do
    local trinketUid = trinkets[i]
    if not trinketUid or 0 == trinketUid then
      table.insert(freeSlots, i)
    end
  end
  if 0 == #freeSlots then
    Alert.Show(10638)
    return
  end
  local hasFreeTrinkets = false
  for _, pos in ipairs(freeSlots) do
    local trinketMap = ItemDataUtils.GetTrinketMapByPos(pos)
    if table.next(trinketMap) then
      hasFreeTrinkets = true
      break
    end
  end
  if not hasFreeTrinkets then
    Alert.Show(10637)
    return
  end
  local awakerTid = AwakerTrinketExtModel.Instance:GetCurAwakerTid()
  local curTeamType = AwakerTrinketExtModel.Instance:GetCurTeamType()
  local teamSvrIndex = AwakerTrinketExtModel.Instance:GetTeamSvrIndex()
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("TrinketRequest", "OnRecommendTrinket", function(svrData)
    AwakerTrinketExtModel.Instance:EquipRecommendTrinkets(svrData)
  end, function()
  end, awakerTid, curTeamType or 0, teamSvrIndex or 0)
end

function AwakerTrinketController:ReqChangeSuiPlanName(id, name, trinkets)
  if not AwakerTrinketExtModel.Instance:IsPlanNameLenValid(name) then
    if 0 == StrUtils.GetCharLen(name or "") then
      Alert.Show(10803)
    end
    return
  end
  if not StrUtils.IsCnJpAlphaNum(name) then
    Alert.Show(10804)
    return
  end
  local planTrinkets = trinkets or AwakerTrinketExtModel.Instance:GetPlanTrinkets(id)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("TrinketRequest", "UpdateTrinketSuit", function(svrData)
    AwakerTrinketExtModel.Instance:UpdateAwakerTrinketSuitPlan(svrData)
  end, function()
    self:LocalNotify(NotifyId.OnAwakerTrinketSuitPlanUpdateFailed, id)
  end, id, name, planTrinkets)
end

function AwakerTrinketController:UpdateAwakerTrinketSuitPlan(id, name, trinkets)
  if self:_HasBoundTrinketInPlan(trinkets) then
    return
  end
  if 0 == id then
    local planId = AwakerTrinketExtModel.Instance:GetPlanIdByTrinkets(trinkets)
    id = 0 ~= planId and planId or AwakerTrinketExtModel.Instance:GenPlanId()
  end
  if not AwakerTrinketExtModel.Instance:IsPlanNameLenValid(name) then
    if 0 == StrUtils.GetCharLen(name or "") then
      Alert.Show(10803)
    end
    return
  end
  if not StrUtils.IsCnJpAlphaNum(name) then
    Alert.Show(10804)
    return
  end
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("TrinketRequest", "UpdateTrinketSuit", function(svrData)
    AwakerTrinketExtModel.Instance:UpdateAwakerTrinketSuitPlan(svrData)
  end, function()
    self:LocalNotify(NotifyId.OnAwakerTrinketSuitPlanUpdateFailed, id)
  end, id, name, trinkets)
end

function AwakerTrinketController:DeleteAwakerTrinketSuitPlan(id)
  local function __ReqDeletePlan()
    EventMgr.Instance.OpenReqMask:Dispatch()
    
    ProtoManager.Instance:ReqServer("TrinketRequest", "RemoveTrinketSuit", function(svrData)
      AwakerTrinketExtModel.Instance:DeleteAwakerTrinketSuitPlan(id)
    end, function()
    end, id)
  end
  
  local curPlanId = AwakerTrinketExtModel.Instance:GetChooseSuitPlanId()
  local planName = AwakerTrinketExtModel.Instance:GetTrinketPlanName(curPlanId)
  local desc = LT.Textf(DT.TipsType[10813].Desc, planName)
  Alert.Show(10813, nil, function()
    __ReqDeletePlan()
  end, nil, desc)
end

function AwakerTrinketController:ReqEquipTrinketPlan(planId)
  local planData = AwakerTrinketExtModel.Instance:GetTrinketPlanData(planId)
  if not planData then
    return
  end
  local curAwakerTid = AwakerTrinketExtModel.Instance:GetCurAwakerTid()
  local trinkets = AwakerTrinketExtModel.Instance:GetPlanTrinkets(planId)
  local trinketsList = {}
  for _, uid in pairs(trinkets or {}) do
    if 0 ~= uid then
      local awaker = AwakerTrinketExtModel.Instance:GetTrinketOwnerTid(uid)
      if awaker and curAwakerTid ~= awaker and awaker > 0 then
        local itemData = ItemDataUtils.GetItemByUid(uid)
        table.insert(trinketsList, {
          awakerTid = awaker,
          uid = uid,
          tid = itemData.tid
        })
      end
    end
  end
  if #trinketsList > 0 then
    UIManager.Instance:Reopen(Urls.TrinketsEquipedByAwakersView, trinketsList, function()
      AwakerTrinketExtModel.Instance:EquipSuitPlan(planId)
    end)
    return
  end
  AwakerTrinketExtModel.Instance:EquipSuitPlan(planId)
end

function AwakerTrinketController:_HasBoundTrinketInPlan(trinkets)
  for _, uid in pairs(trinkets or {}) do
    if AwakerDataUtils.IsTrinketBoundByAnyAwaker(uid) then
      Alert.Show("TrinketBindSaveTips")
      return true
    end
  end
  return false
end

function AwakerTrinketController:ReqBatchBindTrinket(awakerTid, targetTrinkets, costTrinketUids, onSuccess)
  if not awakerTid or 0 == awakerTid then
    return
  end
  if not table.next(targetTrinkets or {}) then
    return
  end
  local fullTargetTrinkets = {}
  for pos, uid in pairs(AwakerDataUtils.GetBoundTrinkets(awakerTid)) do
    fullTargetTrinkets[pos] = uid
  end
  for pos, uid in pairs(targetTrinkets) do
    fullTargetTrinkets[pos] = uid
  end
  self:_SendBatchBindTrinkets(awakerTid, fullTargetTrinkets, costTrinketUids, function(boundTrinkets)
    for pos, uid in pairs(targetTrinkets) do
      boundTrinkets[pos] = uid
    end
  end, onSuccess)
end

function AwakerTrinketController:ReqChangeBindTrinket(awakerTid, pos, newUid, materialUids, onSuccess)
  if not (awakerTid and 0 ~= awakerTid and newUid) or 0 == newUid then
    return
  end
  if not pos or pos < 1 or pos > CommonDefine.MaxEquipTrinketsNum then
    return
  end
  if not table.next(materialUids or {}) then
    return
  end
  self:ReqBatchBindTrinket(awakerTid, {
    [pos] = newUid
  }, materialUids, onSuccess)
end

function AwakerTrinketController:ReqBatchUnbindTrinket(awakerTid, materialUidsMap, onSuccess)
  if not awakerTid or 0 == awakerTid then
    return
  end
  if not table.next(materialUidsMap or {}) then
    return
  end
  local positions = {}
  local costTrinketUids = {}
  for pos in pairs(materialUidsMap) do
    table.insert(positions, pos)
  end
  table.sort(positions)
  for _, pos in ipairs(positions) do
    for _, uid in ipairs(materialUidsMap[pos] or {}) do
      table.insert(costTrinketUids, uid)
    end
  end
  local fullTargetTrinkets = {}
  for boundPos, uid in pairs(AwakerDataUtils.GetBoundTrinkets(awakerTid)) do
    if not materialUidsMap[boundPos] then
      fullTargetTrinkets[boundPos] = uid
    end
  end
  self:_SendBatchBindTrinkets(awakerTid, fullTargetTrinkets, costTrinketUids, function(boundTrinkets)
    for _, pos in ipairs(positions) do
      boundTrinkets[pos] = nil
    end
  end, onSuccess)
end

function AwakerTrinketController:_SendBatchBindTrinkets(awakerTid, fullTargetTrinkets, costTrinketUids, localUpdateFn, onSuccess)
  EventMgr.Instance.OpenReqMask:Dispatch()
  ProtoManager.Instance:ReqServer("TrinketRequest", "BatchBindTrinkets", function(svrData)
    Logger.Debug("BatchBindTrinkets successful ", table.tostring(svrData))
    AwakerTrinketExtModel.Instance:HandleTrinketBoundResponse(svrData, awakerTid, localUpdateFn)
    if onSuccess then
      onSuccess()
    end
  end, function(data, code)
    ErrorMsg.ShowErrCodeTips(code, data)
  end, awakerTid, fullTargetTrinkets, costTrinketUids or {})
end

return AwakerTrinketController
