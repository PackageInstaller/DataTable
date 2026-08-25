local LoadingPanel, Super = System.NewClass("LoadingPanel", UIBasePanel)
LoadingPanel.uiResCls = UI_Loading_PanelResource

function LoadingPanel:ctor()
  Super.ctor(self)
end

function LoadingPanel:OnBind(binder)
  Super.OnBind(self, binder)
end

return LoadingPanel
