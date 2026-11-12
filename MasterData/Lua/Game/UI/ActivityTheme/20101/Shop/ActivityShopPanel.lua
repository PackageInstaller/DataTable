local ActivityShopPanel = class("ActivityShopPanel", BasePanel)
ActivityShopPanel._sUIResRootPath = "UI_Activity/"
ActivityShopPanel._tbDefine = {
  {
    sPrefabPath = "20101/Shop/ActivityShopPanel.prefab",
    sCtrlName = "Game.UI.ActivityTheme.20101.Shop.ActivityShopCtrl"
  }
}

function ActivityShopPanel:Awake()
  self.nDefaultId = nil
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nActId = tbParam[1]
    self.nDefaultId = tbParam[2]
  end
  self.actShopData = PlayerData.Activity:GetActivityDataById(self.nActId)
end

function ActivityShopPanel:OnEnable()
end

function ActivityShopPanel:OnDisable()
end

function ActivityShopPanel:OnDestroy()
end

return ActivityShopPanel
