local ShopPanel = class("ShopPanel", BasePanel)
ShopPanel._tbDefine = {
  {
    sPrefabPath = "ShopEx/ShopPanel.prefab",
    sCtrlName = "Game.UI.ShopEx.ShopCtrl"
  }
}

function ShopPanel:Awake()
  self.nDefaultId = nil
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nDefaultId = tbParam[1]
  end
end

function ShopPanel:OnEnable()
end

function ShopPanel:OnDisable()
end

function ShopPanel:OnDestroy()
end

return ShopPanel
