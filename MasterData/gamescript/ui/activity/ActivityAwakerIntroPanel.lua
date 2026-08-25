local ActivityAwakerIntroPanel, Super = System.NewClass("ActivityAwakerIntroPanel", UIBasePanel)
ActivityAwakerIntroPanel.uiResCls = UI_Events_illustrate_TipResource

function ActivityAwakerIntroPanel:ctor(awakerTid, closeCallback)
  Super.ctor(self)
  self.awakerTid = awakerTid
  self.closeCallback = closeCallback
end

function ActivityAwakerIntroPanel:OnBind(binder)
  self.binder = binder
  self:_BindBgPrefab()
  local config = AwakerDataUtils.GetAwakerConfig(self.awakerTid)
  local schoolConfig = DT.SchoolConfig[config.School]
  binder:SetImage(self.ui.Image_Positioning, string.format("Icon/Career/Icon_Career_illustrate_%s.png", schoolConfig.NameEn))
  binder:SetText(self.ui.Text_Name, LT.Text(config.Name))
  binder:SetText(self.ui.Text_Description, LT.Text(config.AwakerIntroduction))
  self.portaitComp = binder:BindComponent(AwakerPortraitComp(self.ui.Container_Awaker, self.awakerTid, nil, nil, CommonDefine.PortraitAlign.Center))
end

function ActivityAwakerIntroPanel:_BindBgPrefab()
  local binder = self.binder
  binder:BindButtonClick(self.ui.Btn_Mask, System.fn(self, self.Close))
  binder:BindButtonClick(self.ui.UI_Common_Btn_Back1, System.fn(self, self.Close))
end

function ActivityAwakerIntroPanel:Close()
  if self.closeCallback then
    self.closeCallback()
  end
  Super.Close(self)
end

return ActivityAwakerIntroPanel
