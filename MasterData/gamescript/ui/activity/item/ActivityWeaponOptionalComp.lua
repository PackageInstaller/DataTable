local T_UITableview = typeof(CS.UITableview)
local T_Button = typeof(CS.UnityEngine.UI.Button)
local T_UIAnimationController = typeof(CS.Z1Client.UIAnimationController)
local ActivityWeaponOptionalComp, Super = System.NewClass("ActivityWeaponOptionalComp", ActivityBaseComp)

function ActivityWeaponOptionalComp:ctor(uiNode, activityTid, model)
  Super.ctor(self)
  self.ui = UI_Event_WeaponOptionalResource(uiNode)
  self.activityTid = activityTid
  self.model = model
  self.activityData = self.model:GetActivityDataClient(activityTid)
  self.activityConfig = ActivityDataUtils.GetConfig(activityTid)
  self.weaponItemTids = self.activityConfig.ActivityPara1
  self.selectItemTid = self.weaponItemTids[1]
end

function ActivityWeaponOptionalComp:OnBind(binder)
  self.binder = binder
  self.uiAnimController = self.ui.uiNode:GetComponent(T_UIAnimationController)
  self:_BindActivityTimer()
  local activityName = ActivityDataUtils.GetActivityName(self.activityTid)
  local activityPlotInfo = ActivityDataUtils.GetActivityPlot(self.activityTid)
  binder:SetText(self.ui.Text_Title, activityName)
  binder:SetText(self.ui.Text_Tip, activityPlotInfo)
  self:_CreateWeaponListView()
  self.weaponListView:ReloadData()
  binder:BindToRaw(function(_, num)
    self.ui.Text_ReceiveCount:SetActive(num > 0)
    binder:SetText(self.ui.Text_ReceiveCount, num)
  end, function()
    do return self._GetCanReceiveNum end
    return self._GetCanReceiveNum, self
  end)
  binder:BindZ1Button(self.ui.Btn_Invite, System.fn(self, self._OnClickInvite), function()
    local num = self:_GetCanReceiveNum()
    if self:_IsWeaponReceived(self.selectItemTid) or 0 == num then
      return CommonDefine.BtnType.Unclickable
    end
    return CommonDefine.BtnType.High
  end, function()
    local num = self:_GetCanReceiveNum()
    if self:_IsWeaponReceived(self.selectItemTid) or 0 == num then
      do return LT.Text end
      return LT.Text, "TextAlreadyReceived", self.selectItemTid
    end
    do return LT.Text end
    return LT.Text, "InviteWeapon", self.selectItemTid
  end)
  binder:BindToRaw(function(_, num)
    self.ui.Btn_Invite:SetActive(num > 0)
    self.ui.Group_Received:SetActive(num <= 0)
  end, function()
    do return self._GetCanReceiveNum end
    return self._GetCanReceiveNum, self
  end)
  binder:BindButtonClick(self.ui.UI_Summon_Btn_Jump, function()
    ItemDataUtils.ShowItemDetailTips(binder, self.ui.UI_Summon_Btn_Jump, nil, self.selectItemTid)
  end)
  self:_RefreshReceivedText()
  self:_RefreshSelectWeaponInfo()
end

function ActivityWeaponOptionalComp:_RefreshReceivedText()
  if not (self.activityData and self.activityData.base) or not self.activityData.selectedReward then
    return
  end
  local weaponItemTid = self.activityData.selectedReward[#self.activityData.selectedReward]
  if not weaponItemTid then
    return
  end
  local itemConfig = DT.Item[weaponItemTid]
  self.binder:SetText(self.ui.Text_Received, LT.Textf("TextAlreadyReceivedWeapon", LT.Text(itemConfig.Name)))
end

function ActivityWeaponOptionalComp:_RefreshSelectWeaponInfo()
  local weaponTid = self.selectItemTid
  if 0 == weaponTid then
    return
  end
  local itemConfig = DT.Item[weaponTid]
  self.binder:BindComponent(AwakerWeaponPrefab(self.ui.Image_Weapon_Large, itemConfig.SpIcon, 0.7))
  self.binder:BindToImage(self.ui.Image_Quality, function()
    local quality = itemConfig.Quality
    return DT.ItemQuality[quality].BigWeaponFrame
  end)
  self.binder:SetText(self.ui.Text_Name, LT.Text(itemConfig.Name))
end

function ActivityWeaponOptionalComp:OnUnbind()
  self.weaponListView:Travel(function(cell)
    local uiRes = UI_Awaker_Item_List_3Resource(cell.gameObject)
    local buttonComp = uiRes.Btn_Click:GetComponent(T_Button)
    buttonComp.onClick:RemoveAllListeners()
  end)
  self.weaponListView:UnregisterAllCallbacks()
end

function ActivityWeaponOptionalComp:_CreateWeaponListView()
  local tableview = self.ui.ScrollView_Awaker:GetComponent(T_UITableview)
  
  function tableview.numberCellsInTableview()
    return #self.weaponItemTids
  end
  
  function tableview.tableCellAtIndex(view, index)
    local cell = view:DequeueCell()
    cell = cell or view:AddChild(self.ui.Weapon_Item)
    self:_FillWeaponItem(cell, index + 1)
    return cell
  end
  
  self.weaponListView = tableview
end

function ActivityWeaponOptionalComp:_FillWeaponItem(cell, index)
  local uiRes = UI_Awaker_Item_List_3Resource(cell.gameObject)
  local itemTid = self.weaponItemTids[index]
  local itemConfig = DT.Item[itemTid]
  self.binder:SetImage(uiRes.Icon_Awaker, itemConfig.SpIcon)
  uiRes.Image_Select:SetActive(self.selectItemTid == itemTid)
  local buttonComp = uiRes.Btn_Click:GetComponent(T_Button)
  buttonComp.onClick:RemoveAllListeners()
  buttonComp.onClick:AddListener(function()
    self.selectItemTid = itemTid
    self:_RefreshSelectWeaponInfo()
    self.weaponListView:Refresh()
  end)
  uiRes.Group_Got:SetActive(ItemDataUtils.GetItemByTid(itemTid))
end

function ActivityWeaponOptionalComp:_IsWeaponReceived(weaponItemTid)
  if not (self.activityData and self.activityData.base) or not self.activityData.selectedReward then
    return true
  end
  do return table.contains, self.activityData.selectedReward end
  return table.contains, self.activityData.selectedReward, weaponItemTid
end

function ActivityWeaponOptionalComp:_GetCanReceiveNum()
  if not (self.activityData and self.activityData.base) or not self.activityData.selectedReward then
    return 0
  end
  return self.activityConfig.ActivityPara2 - table.length(self.activityData.selectedReward)
end

function ActivityWeaponOptionalComp:_OnClickInvite()
  local taskListActivityData = self.activityData
  local taskListActivityBaseData = taskListActivityData and taskListActivityData.base or {}
  if taskListActivityBaseData.state ~= ActivityDefine.ActivityState.Running then
    return
  end
  if 0 == self:_GetCanReceiveNum() then
    return
  end
  
  local function _ReqCB()
    self:_ReqReceive()
  end
  
  local tipsId = 10914
  local tipsCfg = DT.TipsType[tipsId]
  local itemConfig = DT.Item[self.selectItemTid]
  local desc = LT.Textf(tipsCfg.Desc, LT.Text(itemConfig.Name))
  Alert.Show(tipsId, nil, _ReqCB, tipsCfg.Title, desc)
end

function ActivityWeaponOptionalComp:_ReqReceive()
  local selectWeaponTid = self.selectItemTid
  ActivityDataUtils.ReqGainAward(self.activityTid, selectWeaponTid, {}, function(result)
    if result then
      table.insert(self.activityData.selectedReward, selectWeaponTid)
      if 0 == self:_GetCanReceiveNum() then
        ActivityManager.Instance.model:UpdateFinishState(self.activityData.activityTid)
      end
      self.weaponListView:Refresh()
      self:_RefreshReceivedText()
    end
  end)
end

function ActivityWeaponOptionalComp:OnOpenAnim(callback)
  self.uiAnimController:PlayState("UI_Event_Activity_XiaomaoGift_Open", callback)
end

function ActivityWeaponOptionalComp:OnCloseAnim(callback)
  self.uiAnimController:PlayState("UI_Event_Activity_XiaomaoGift_Close", callback)
end

return ActivityWeaponOptionalComp
