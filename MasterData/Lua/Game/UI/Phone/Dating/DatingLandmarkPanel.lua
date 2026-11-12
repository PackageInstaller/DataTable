local DatingLandmarkPanel = class("DatingLandmarkPanel", BasePanel)
DatingLandmarkPanel._bIsMainPanel = false
DatingLandmarkPanel._tbDefine = {
  {
    sPrefabPath = "Phone/DatingLandmarkPanel.prefab",
    sCtrlName = "Game.UI.Phone.Dating.DatingLandmarkCtrl"
  }
}

function DatingLandmarkPanel:Awake()
end

function DatingLandmarkPanel:OnEnable()
end

function DatingLandmarkPanel:OnAfterEnter()
end

function DatingLandmarkPanel:OnDisable()
end

function DatingLandmarkPanel:OnDestroy()
end

function DatingLandmarkPanel:OnRelease()
end

return DatingLandmarkPanel
