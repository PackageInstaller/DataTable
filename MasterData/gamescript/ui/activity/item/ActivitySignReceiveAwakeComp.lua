local T_UITableview = typeof(CS.UITableview)
local T_Button = typeof(CS.UnityEngine.UI.Button)
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local ActivitySignReceiveAwakeComp, Super = System.NewClass("ActivitySignReceiveAwakeComp", ActivityBaseComp)

function ActivitySignReceiveAwakeComp:ctor(uiNode, activityTid, model)
  Super.ctor(self)
  self.ui = UI_Event_Activity_XiaomaoGiftResource(uiNode)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.awakerItemTids = self.activityConfig.ActivityPara1
  self.selectItemTid = self.awakerItemTids[1]
  self.selectAwakerTid = Vue.ref(self:_GetAwakerTidByItemId(self.selectItemTid))
end

function ActivitySignReceiveAwakeComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self:_BindActivityTimer()
  local activityName = ActivityDataUtils.GetActivityName(self.activityTid)
  local activityPlotInfo = ActivityDataUtils.GetActivityPlot(self.activityTid)
  binder:SetText(self.ui.Text_Title, activityName)
  binder:SetImageSync(self.ui.Image_Map, ActivityDataUtils.GetBgImage(self.activityTid))
  binder:SetText(self.ui.Text_Tip, activityPlotInfo)
  self:_CreateAwakerListView()
  self:_RefreshAwakerListView()
  self:_RefreshPortaitComp()
  self:_OnBindReceiveCount()
  binder:BindZ1Button(self:_GetReceiveBtnObj(), System.fn(self, self._OnClickInviteAwaker), function()
    if not self:_IsAbleToReceive() then
      return CommonDefine.BtnType.Unclickable
    end
    local num = self:_GetCanReceiveAwakeNum()
    if self:_IsAwakerReceived(self.selectItemTid) or 0 == num then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    local num = self:_GetCanReceiveAwakeNum()
    if self:_IsAwakerReceived(self.selectItemTid) or 0 == num then
      do return LT.Text end
      return LT.Text, "TextAlreadyReceived", self.selectItemTid
    end
    do return LT.Text end
    return LT.Text, "InviteAwaker", self.selectItemTid
  end, function()
    do return self._IsAbleToReceive end
    return self._IsAbleToReceive, self
  end)
  binder:BindToRaw(function(_, num)
    self:_GetReceiveBtnObj():SetActive(num > 0)
    self.ui.Group_Received:SetActive(num <= 0)
  end, function()
    do return self._GetCanReceiveAwakeNum end
    return self._GetCanReceiveAwakeNum, self
  end)
  binder:BindButtonClick(self.ui.UI_Summon_Btn_Jump, function()
    local awakerBasePanelData = {}
    awakerBasePanelData.jumpPage = CommonDefine.AwakerPage.Detail
    awakerBasePanelData.specialAwakerList = {
      AwakerDataUtils.GetAwakerData(self.selectAwakerTid.value)
    }
    UIManager.Instance:Reopen(Urls.AwakerBasePanel, awakerBasePanelData)
  end)
  self:_RefreshReceivedAwakerText()
  self:_RefreshSelectAwakerInfo()
end

function ActivitySignReceiveAwakeComp:_GetReceiveBtnObj()
  return self.ui.Btn_Invite
end

function ActivitySignReceiveAwakeComp:_OnBindReceiveCount()
  self.binder:BindToRaw(function(_, num)
    if not self:_IsAbleToReceive() then
      self.ui.Text_ReceiveCount:SetActive(true)
      local targetTaskData = self:_GetTargetTaskData()
      local desc = TaskCfgUtils.GetCfgField("Desc", targetTaskData and targetTaskData.tid)
      local starAward = LT.Textf("DailyChallengeStarAward", targetTaskData and targetTaskData.count, TaskDataUtils.GetTaskProgressLimit(targetTaskData.tid))
      self.binder:SetText(self.ui.Text_ReceiveCount, LT.Textf("ActivitySignReceiveTaskTextAndCount", desc, starAward))
      return
    end
    self.ui.Text_ReceiveCount:SetActive(num > 0)
    self.binder:SetText(self.ui.Text_ReceiveCount, LT.Textf("ActivitySignReceiveTaskTextAndCount", LT.Text("ActivitySignReceiveRewardTimeLabel"), num))
  end, function()
    do return self._GetCanReceiveAwakeNum end
    return self._GetCanReceiveAwakeNum, self
  end)
end

function ActivitySignReceiveAwakeComp:_RefreshPortaitComp()
  self.portaitComp = self.binder:BindComponent(AwakerPortraitComp(self.ui.Image_Awaker, self.selectAwakerTid), nil, nil, CommonDefine.PortraitAlign.Center)
  PortraitManager.Instance:AddAwakerPortrait(self.portaitComp)
end

function ActivitySignReceiveAwakeComp:_RefreshAwakerListView()
  self.awakerListView:ReloadData()
end

function ActivitySignReceiveAwakeComp:_RefreshReceivedAwakerText()
  if not (self.activityData and self.activityData.base) or not self.activityData.selectedReward then
    return
  end
  local awakerItemTid = self.activityData.selectedReward[#self.activityData.selectedReward]
  if not awakerItemTid then
    return
  end
  local awakerTid = self:_GetAwakerTidByItemId(awakerItemTid)
  self.binder:SetText(self.ui.Text_Received, LT.Textf("TextAlreadyReceivedAwaker", AwakerDataUtils.GetAwakerName(awakerTid)))
end

function ActivitySignReceiveAwakeComp:_RefreshSelectAwakerInfo()
  local awakerTid = self.selectAwakerTid.value
  if 0 == awakerTid then
    return
  end
  local awakerConfig = DT.AwakerConfig[awakerTid]
  local schoolConfig = DT.SchoolConfig[awakerConfig.School]
  self.binder:SetText(self.ui.Text_Name, LT.Text(awakerConfig.Name))
  self.binder:SetImage(self.ui.Image_Positioning, schoolConfig.Icon or "")
end

function ActivitySignReceiveAwakeComp:OnUnbind()
  PortraitManager.Instance:RemoveAwakerPortrait(self.portaitComp)
  self.awakerListView:Travel(function(cell)
    local uiRes = UI_Awaker_Item_List_3Resource(cell.gameObject)
    local buttonComp = uiRes.Btn_Click:GetComponent(T_Button)
    buttonComp.onClick:RemoveAllListeners()
  end)
  self.awakerListView:UnregisterAllCallbacks()
end

function ActivitySignReceiveAwakeComp:_CreateAwakerListView()
  local tableview = self.ui.ScrollView_Awaker:GetComponent(T_UITableview)
  
  function tableview.numberCellsInTableview()
    return #self.awakerItemTids
  end
  
  function tableview.tableCellAtIndex(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.Awaker_Item)
    self:_FillAwakerItem(cell, index + 1)
    return cell
  end
  
  self.awakerListView = tableview
end

function ActivitySignReceiveAwakeComp:_FillAwakerItem(cell, index)
  local uiRes = UI_Awaker_Item_List_3Resource(cell.gameObject)
  local itemTid = self.awakerItemTids[index]
  local awakerTid = self:_GetAwakerTidByItemId(itemTid) or 0
  local awakerConfig = DT.AwakerConfig[awakerTid]
  local schoolConfig = DT.SchoolConfig[awakerConfig.School]
  self.binder:SetImage(uiRes.Icon_Awaker, AwakerDataUtils.GetAwakerDefaultBust(awakerTid))
  self.binder:SetImage(uiRes.Image_Quality, AwakerDataUtils.GetAwakerQualityColor(awakerTid))
  self.binder:SetImage(uiRes.Image_Position, schoolConfig.Icon or "")
  uiRes.Image_Select:SetActive(self.selectItemTid == itemTid)
  local buttonComp = uiRes.Btn_Click:GetComponent(T_Button)
  buttonComp.onClick:RemoveAllListeners()
  buttonComp.onClick:AddListener(function()
    self.selectAwakerTid.value = self:_GetAwakerTidByItemId(itemTid)
    self.selectItemTid = itemTid
    self:_RefreshSelectAwakerInfo()
    self.awakerListView:Refresh()
  end)
  uiRes.Group_Got:SetActive(false)
  uiRes.Image_Full:SetActive(self:_IsAwakerPotencyMax(itemTid))
end

function ActivitySignReceiveAwakeComp:_IsAwakerReceived(awakerTid)
  if not (self.activityData and self.activityData.base) or not self.activityData.selectedReward then
    return true
  end
  do return table.contains, self.activityData.selectedReward end
  return table.contains, self.activityData.selectedReward, awakerTid
end

function ActivitySignReceiveAwakeComp:_GetTargetTaskData()
  local targetTaskTid = self.activityConfig.ActivityPara3[1]
  return self.activityData.taskList[targetTaskTid]
end

function ActivitySignReceiveAwakeComp:_IsAbleToReceive()
  local targetTaskData = self:_GetTargetTaskData()
  if not targetTaskData then
    return true
  end
  return targetTaskData.state == CommonDefine.TaskState.Receive or targetTaskData.state == CommonDefine.TaskState.Done
end

function ActivitySignReceiveAwakeComp:_GetCanReceiveAwakeNum()
  if not (self.activityData and self.activityData.base) or not self.activityData.selectedReward then
    return 0
  end
  return self.activityConfig.ActivityPara2 - table.length(self.activityData.selectedReward)
end

function ActivitySignReceiveAwakeComp:_OnClickInviteAwaker()
  if not self:_IsAbleToReceive() then
    Alert.Show("ActivitySignRewardTaskNotCompleteTips")
    return
  end
  local taskListActivityData = self.activityData
  local taskListActivityBaseData = taskListActivityData and taskListActivityData.base or {}
  if taskListActivityBaseData.state ~= ActivityDefine.ActivityState.Running then
    return
  end
  if 0 == self:_GetCanReceiveAwakeNum() then
    return
  end
  
  local function _ReqCB()
    self:_ReqReceiveAwaker()
  end
  
  local itemTid = self.selectItemTid
  local selectAwakerTid = self:_GetAwakerTidByItemId(itemTid)
  if self:_IsAwakerPotencyMax(itemTid) then
    local tipsId = 10908
    local tipsCfg = DT.TipsType[tipsId]
    local desc = LT.Textf(tipsCfg.Desc, AwakerDataUtils.GetAwakerName(selectAwakerTid))
    local nonLimitedAwakerList = DT.GetOriginalConstant("NonLimitedAwakerList")
    local isDoubleReward = not table.contains(nonLimitedAwakerList, selectAwakerTid)
    local awakerCfg = DT.AwakerConfig[selectAwakerTid]
    local items = {}
    if table.contains({
      CommonDefine.CommonQuality.Orange,
      CommonDefine.CommonQuality.UR
    }, awakerCfg.Quality) then
      local overFlowItems = AwakerDataUtils.GetAwakerChipSSROverflowExtraItems(isDoubleReward)
      for i = #overFlowItems, 1, -1 do
        local item = overFlowItems[i]
        table.insert(items, item)
      end
    end
    local data = DT.Constant.AwakerChipOverflowTransform.Data
    local dataExtra = DT.Constant.SummonExtraItemGetSR.Data
    local itemCount = {
      Orange = data[2],
      Purple = data[3],
      Blue = data[4]
    }
    local itemCountExtra = {
      Orange = dataExtra[2],
      Purple = dataExtra[3],
      Blue = dataExtra[4]
    }
    for quality, sortValue in pairs(cd.QualitySortID) do
      if sortValue < cd.QualitySortID.Blue then
        itemCount[quality] = itemCount.Blue
        itemCountExtra[quality] = itemCountExtra.Blue
      end
      if sortValue > cd.QualitySortID.Orange then
        itemCount[quality] = itemCount.Orange
        itemCountExtra[quality] = itemCountExtra.Orange
      end
    end
    local targetItemCount = itemCount[awakerCfg.Quality] or 0
    if isDoubleReward then
      targetItemCount = targetItemCount + targetItemCount
    end
    local targetItemCountExtra = itemCountExtra[awakerCfg.Quality] or 0
    if data[1] == dataExtra[1] then
      targetItemCount = targetItemCount + targetItemCountExtra
    end
    table.insert(items, {
      tid = data[1],
      num = targetItemCount
    })
    local params = {
      tipTid = tipsId,
      desc = desc,
      items = items,
      callback = _ReqCB
    }
    UIManager.Instance:Reopen(Urls.ItemObtainedTipPanel, params)
    return
  end
  if AwakerDataUtils.HasOwnedAwaker(selectAwakerTid) then
    local tipsId = 10909
    local tipsCfg = DT.TipsType[tipsId]
    local awakerName = AwakerDataUtils.GetAwakerName(selectAwakerTid)
    local desc = LT.Textf(tipsCfg.Desc, awakerName, awakerName)
    local awakerCfg = DT.AwakerConfig[selectAwakerTid]
    local dataExtra = DT.Constant.SummonExtraItemGetSR.Data
    local itemCountExtra = {
      Orange = dataExtra[2],
      Purple = dataExtra[3],
      Blue = dataExtra[4]
    }
    local items = {}
    table.insert(items, {
      tid = DT.AwakerConfig[selectAwakerTid].AwakerSpecialItem
    })
    table.insert(items, {
      tid = dataExtra[1],
      num = itemCountExtra[awakerCfg.Quality]
    })
    local params = {
      tipTid = tipsId,
      desc = desc,
      items = items,
      callback = _ReqCB
    }
    UIManager.Instance:Reopen(Urls.ItemObtainedTipPanel, params)
    return
  end
  local tipsId = 10910
  local tipsCfg = DT.TipsType[tipsId]
  local desc = LT.Textf(tipsCfg.Desc, AwakerDataUtils.GetAwakerName(selectAwakerTid))
  Alert.Show(tipsId, nil, _ReqCB, tipsCfg.Title, desc)
end

function ActivitySignReceiveAwakeComp:_ReqReceiveAwaker()
  local selectAwakerTid = self.selectItemTid
  ActivityDataUtils.ReqGainAward(self.activityTid, selectAwakerTid, {}, function(result)
    if result then
      table.insert(self.activityData.selectedReward, selectAwakerTid)
      if 0 == self:_GetCanReceiveAwakeNum() then
        ActivityManager.Instance.model:UpdateFinishState(self.activityData.activityTid)
      end
      self.awakerListView:Refresh()
      self:_RefreshReceivedAwakerText()
    end
  end)
end

function ActivitySignReceiveAwakeComp:_IsAwakerPotencyMax(itemTid)
  do return ItemDataUtils.IsAwakerChipOverFlow end
  return ItemDataUtils.IsAwakerChipOverFlow, itemTid
end

function ActivitySignReceiveAwakeComp:_GetAwakerTidByItemId(itemTid)
  local itemCfg = DT.Item[itemTid]
  local awakerTid = itemCfg and itemCfg.SpParam[1] or 0
  return awakerTid
end

function ActivitySignReceiveAwakeComp:OnOpenAnim(callback)
  self.uiAnimController:PlayState("UI_Event_Activity_XiaomaoGift_Open", callback)
end

function ActivitySignReceiveAwakeComp:OnCloseAnim(callback)
  callback()
end

return ActivitySignReceiveAwakeComp
