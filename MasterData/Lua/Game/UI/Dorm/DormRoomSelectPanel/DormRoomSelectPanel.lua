local DormRoomSelectPanel = class("DormRoomSelectPanel", BasePanel)
DormRoomSelectPanel._bIsMainPanel = false
DormRoomSelectPanel._tbDefine = {
  {
    sPrefabPath = "Dorm/DormRoomSelectPanel.prefab",
    sCtrlName = "Game.UI.Dorm.DormRoomSelectPanel.DormRoomSelectCtrl"
  }
}

function DormRoomSelectPanel:Awake()
end

function DormRoomSelectPanel:OnEnable()
end

function DormRoomSelectPanel:OnAfterEnter()
end

function DormRoomSelectPanel:OnDisable()
end

function DormRoomSelectPanel:OnDestroy()
end

function DormRoomSelectPanel:OnRelease()
end

return DormRoomSelectPanel
