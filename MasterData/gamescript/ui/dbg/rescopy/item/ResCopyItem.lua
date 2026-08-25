local ResCopyItem, Super = System.NewComponent("ResCopyItem")

function ResCopyItem:ctor(res, cfgData, callFunc)
  Super.ctor(self)
  self.ui = Item_Daily_Dungeons_EntranceResource(res)
  self.cfgData = cfgData
  self.callFunc = callFunc
  self.isLock = false
end

function ResCopyItem:OnBind(binder)
  self.binder = binder
  binder:SetText(self.ui.Text_Name, self.cfgData.Name)
  binder:SetText(self.ui.Text_Desc, self.cfgData.Desc)
  if self.cfgData.Backgrand and self.ui.Image_Icon then
    binder:SetImage(self.ui.Image_Icon, self.cfgData.Backgrand)
  end
  if self.cfgData.OpenTimeStr then
    binder:SetActive(self.ui.Text_Time, true)
    binder:SetText(self.ui.Text_Time, self.cfgData.OpenTimeStr)
  else
    binder:SetActive(self.ui.Text_Time, false)
  end
  local _, isOpen = PlayerDataUtils.IsFeatureUnlock("DailyMaterial", self.cfgData.ID)
  binder:BindTimer(1, -1, System.fn(self, self.OnFixedUpdate))
  self:SetLock(CopyDataUtils.IsInOpenTime(self.cfgData.ID) == false or false == isOpen)
  binder:BindButtonClick(self.ui.Btn_Click, System.fn(self, self.OnBtnClick))
end

function ResCopyItem:OnFixedUpdate()
  local _, isOpen = PlayerDataUtils.IsFeatureUnlock("DailyMaterial", self.cfgData.ID)
  if isOpen then
    self:SetLock(CopyDataUtils.IsInOpenTime(self.cfgData.ID) == false)
  end
end

function ResCopyItem:SetLock(state)
  local binder = self.binder
  binder:SetActive(self.ui.Image_Lock, state)
  binder:SetActive(self.ui.Image_Mask, state)
  self.isLock = state
end

function ResCopyItem:OnBtnClick()
  if self.isLock then
    Logger.Info("当前副本处于未开放状态~")
    local _, isOpen = PlayerDataUtils.IsFeatureUnlock("DailyMaterial", self.cfgData.ID)
    if isOpen then
      Alert.Show(10477)
    else
      PlayerDataUtils.AlertLockedTips("DailyMaterial", self.cfgData.ID)
    end
    return
  end
  if self.callFunc then
    self.callFunc(self.cfgData)
  end
end

return ResCopyItem
