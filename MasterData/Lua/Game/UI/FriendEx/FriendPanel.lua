local FriendPanel = class("FriendPanel", BasePanel)
FriendPanel._tbDefine = {
  {
    sPrefabPath = "FriendEx/FriendPanel.prefab",
    sCtrlName = "Game.UI.FriendEx.FriendCtrl"
  }
}

function FriendPanel:Awake()
  self.tbAddCache = {}
  self.nDefaultTog = nil
  local tbParam = self:GetPanelParam()
  if type(tbParam) == "table" then
    self.nDefaultTog = tbParam[1]
  end
end

function FriendPanel:OnEnable()
end

function FriendPanel:OnDisable()
end

function FriendPanel:OnDestroy()
end

return FriendPanel
