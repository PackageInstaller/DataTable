local PenguinCardSelectPanel = class("PenguinCardSelectPanel", BasePanel)
PenguinCardSelectPanel._bIsMainPanel = true
PenguinCardSelectPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
PenguinCardSelectPanel._tbDefine = {
  {
    sPrefabPath = "Play_PenguinCard/PenguinCardSelectPanel.prefab",
    sCtrlName = "Game.UI.Play_PenguinCard.PenguinCardSelectCtrl"
  }
}

function PenguinCardSelectPanel:Awake()
  self.nPos = nil
end

function PenguinCardSelectPanel:OnEnable()
end

function PenguinCardSelectPanel:OnAfterEnter()
end

function PenguinCardSelectPanel:OnDisable()
end

function PenguinCardSelectPanel:OnDestroy()
end

function PenguinCardSelectPanel:OnRelease()
end

return PenguinCardSelectPanel
