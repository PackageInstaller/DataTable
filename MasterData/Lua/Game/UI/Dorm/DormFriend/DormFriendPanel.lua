local DormFriendPanel = class("DormFriendPanel", BasePanel)
DormFriendPanel._bIsMainPanel = false
DormFriendPanel._tbDefine = {
  {
    sPrefabPath = "Dorm/DormFriendPanel.prefab",
    sCtrlName = "Game.UI.Dorm.DormFriend.DormFriendCtrl"
  }
}

function DormFriendPanel:Awake()
end

function DormFriendPanel:OnEnable()
end

function DormFriendPanel:OnAfterEnter()
end

function DormFriendPanel:OnDisable()
end

function DormFriendPanel:OnDestroy()
end

function DormFriendPanel:OnRelease()
end

return DormFriendPanel
