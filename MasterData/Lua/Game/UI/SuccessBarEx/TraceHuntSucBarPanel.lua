local TraceHuntSucBarPanel = class("TraceHuntSucBarPanel", BasePanel)
TraceHuntSucBarPanel._bIsMainPanel = false
TraceHuntSucBarPanel._tbDefine = {
  {
    sPrefabPath = "SuccessBarEx/TraceHuntSucBarPanel.prefab",
    sCtrlName = "Game.UI.SuccessBarEx.TraceHuntSucBarCtrl"
  }
}

function TraceHuntSucBarPanel:Awake()
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.mapData = tbParam[1]
    self.callback = tbParam[2]
  end
end

function TraceHuntSucBarPanel:OnEnable()
end

function TraceHuntSucBarPanel:OnDisable()
end

function TraceHuntSucBarPanel:OnDestroy()
end

return TraceHuntSucBarPanel
