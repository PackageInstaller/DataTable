local FriendAddStrangerPanel = class("FriendAddStrangerPanel", BasePanel)
FriendAddStrangerPanel._bIsMainPanel = false
FriendAddStrangerPanel._tbDefine = {
  {
    sPrefabPath = "FriendEx/FriendAddStrangerPanel.prefab",
    sCtrlName = "Game.UI.FriendEx.FriendAddStrangerCtrl"
  }
}

function FriendAddStrangerPanel:Awake()
end

function FriendAddStrangerPanel:OnEnable()
end

function FriendAddStrangerPanel:OnDisable()
end

function FriendAddStrangerPanel:OnDestroy()
end

return FriendAddStrangerPanel
