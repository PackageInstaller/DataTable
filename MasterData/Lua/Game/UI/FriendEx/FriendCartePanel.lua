local FriendCartePanel = class("FriendCartePanel", BasePanel)
FriendCartePanel._bIsMainPanel = false
FriendCartePanel._tbDefine = {
  {
    sPrefabPath = "FriendEx/FriendCartePanel.prefab",
    sCtrlName = "Game.UI.FriendEx.FriendCarteCtrl"
  }
}

function FriendCartePanel:Awake()
end

function FriendCartePanel:OnEnable()
end

function FriendCartePanel:OnDisable()
end

function FriendCartePanel:OnDestroy()
end

return FriendCartePanel
