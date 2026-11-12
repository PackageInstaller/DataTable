local BtnTipsCtrl = class("BtnTipsCtrl", BaseCtrl)
BtnTipsCtrl._mapNodeConfig = {
  BtnScreen = {sComponentName = "Button", callback = "OnBtnClick"}
}
BtnTipsCtrl._mapEventConfig = {}

function BtnTipsCtrl:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.callback = tbParam[1]
  end
end

function BtnTipsCtrl:FadeIn()
end

function BtnTipsCtrl:FadeOut()
end

function BtnTipsCtrl:OnEnable()
end

function BtnTipsCtrl:OnDisable()
end

function BtnTipsCtrl:OnDestroy()
end

function BtnTipsCtrl:OnRelease()
end

function BtnTipsCtrl:OnBtnClick()
  if type(self.callback) == "function" then
    self.callback()
  end
  EventManager.Hit(EventId.ClosePanel, PanelId.BtnTips)
end

return BtnTipsCtrl
