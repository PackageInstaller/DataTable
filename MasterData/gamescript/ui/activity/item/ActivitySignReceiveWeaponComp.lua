local T_UITableview = typeof(CS.UITableview)
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local ActivitySignReceiveWeaponComp, Super = System.NewClass("ActivitySignReceiveWeaponComp", ActivityBaseComp)

function ActivitySignReceiveWeaponComp:ctor(uiNode, activityTid, model)
  Super.ctor(self)
  self.ui = UI_Events_Activity_WeaponSignResource(uiNode)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.activityTaskTids = self.activityConfig.ActivityPara1
  self.activityTaskList = self.activityData.taskList
  self.itemIconComps = {}
end

function ActivitySignReceiveWeaponComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self:_BindActivityTimer()
  local activityName = ActivityDataUtils.GetActivityName(self.activityTid)
  local activityPlotInfo = ActivityDataUtils.GetActivityPlot(self.activityTid)
  binder:SetText(self.ui.Text_Diary, activityName)
  binder:SetImageSync(self.ui.Image_Map, ActivityDataUtils.GetBgImage(self.activityTid))
  binder:SetText(self.ui.Text_Desc, activityPlotInfo)
  self:_CreateWeaponsListView()
  self.weaponListView:ReloadData()
  local weaponTid = self.activityConfig.ActivityPara2
  local itemCfg = DT.Item[weaponTid]
  self.binder:BindComponent(AwakerWeaponPrefab(self.ui.Image_Weapon_Large, itemCfg.SpIcon, 0.85))
  self.binder:SetText(self.ui.Text_Name, itemCfg.Name)
  binder:BindButtonClick(self.ui.UI_Summon_Btn_Jump, function()
    ItemDataUtils.ShowItemDetailTips(binder, self.ui.UI_Summon_Btn_Jump, nil, weaponTid)
  end)
end

function ActivitySignReceiveWeaponComp:_CreateWeaponsListView()
  local tableview = self.ui.ScrollView_Task:GetComponent(T_UITableview)
  
  function tableview.numberCellsInTableview()
    return #self.activityTaskTids
  end
  
  function tableview.tableCellAtIndex(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.UI_Common_Item_WuPin_Type2)
    self:_FillWeaponItem(cell, index + 1)
    return cell
  end
  
  function tableview.reloadFinishCallback()
    self:_MoveReceivingFirstCellInView()
  end
  
  self.weaponListView = tableview
end

function ActivitySignReceiveWeaponComp:_MoveReceivingFirstCellInView()
  if not self.weaponListView.isReady then
    return
  end
  local canGetIndex = 0
  for i = 1, #self.activityTaskTids do
    local taskTid = self.activityTaskTids[i]
    local taskData = self.activityTaskList[taskTid]
    local canGetPrized = nil ~= taskData and taskData.state == CommonDefine.CommonState.GainPrize or false
    if canGetPrized then
      canGetIndex = i - 1
      break
    end
  end
  self.weaponListView:MoveCellInView(canGetIndex, false)
end

function ActivitySignReceiveWeaponComp:Show()
  Super.Show(self)
  if self.ui and self.ui.uiNode then
    self:_MoveReceivingFirstCellInView()
  end
end

function ActivitySignReceiveWeaponComp:_FillWeaponItem(cell, index)
  local taskTid = self.activityTaskTids[index]
  local taskData = self.activityTaskList[taskTid]
  local taskConfig = DT.Task[taskTid]
  local isReceived = nil ~= taskData and taskData.state == CommonDefine.CommonState.Finish or false
  local canGetPrized = nil ~= taskData and taskData.state == CommonDefine.CommonState.GainPrize or false
  local iconComp = self.itemIconComps[cell]
  if iconComp then
    iconComp.binder:teardown()
  end
  local completeAward = taskConfig.CompleteAward
  local itemData = {
    itemTid = completeAward[1],
    itemCount = completeAward[2] or 1,
    clickFunc = function()
      if canGetPrized then
        self:OnGetAllWeaponPrized()
      else
        ItemDataUtils.ShowItemDetailTips(self.binder, cell.gameObject, nil, completeAward[1])
      end
    end,
    isShowRing = function()
      return canGetPrized
    end
  }
  iconComp = self.binder:BindComponent(CommonIconItemType2(cell.gameObject, itemData))
  self.itemIconComps[cell] = iconComp
  iconComp.ui.Image_Mask:SetActive(isReceived)
  if isReceived then
    self.binder:SetText(iconComp.ui.Text_Name, LT.Text("ActivityRewardReceived"))
  else
    self.binder:SetText(iconComp.ui.Text_Name, LT.Textf("ActivityLoginDays", index))
  end
end

function ActivitySignReceiveWeaponComp:OnGetAllWeaponPrized()
  local taskListActivityData = self.activityData
  local taskListActivityBaseData = taskListActivityData and taskListActivityData.base or {}
  if taskListActivityBaseData.state ~= ActivityDefine.ActivityState.Running then
    return
  end
  local canGainTaskTids = {}
  for _, taskTid in ipairs(self.activityTaskTids) do
    local taskData = self.activityTaskList[taskTid]
    if taskData and taskData.state == CommonDefine.CommonState.GainPrize then
      table.insert(canGainTaskTids, taskTid)
    end
  end
  if 0 == #canGainTaskTids then
    return
  end
  ActivityDataUtils.ReqGainAwardList(self.activityTid, canGainTaskTids, function(result)
    if result then
      for _, taskTid in ipairs(canGainTaskTids) do
        self.activityTaskList[taskTid].state = CommonDefine.CommonState.Finish
      end
      ActivityManager.Instance.model:UpdateFinishState(self.activityData.activityTid)
      self.weaponListView:Refresh()
    end
  end)
end

function ActivitySignReceiveWeaponComp:OnUnbind()
  self.weaponListView:UnregisterAllCallbacks()
end

function ActivitySignReceiveWeaponComp:OnOpenAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Activity_WeaponSign_Open", callback)
end

function ActivitySignReceiveWeaponComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Events_Activity_WeaponSign_Close", callback)
end

return ActivitySignReceiveWeaponComp
