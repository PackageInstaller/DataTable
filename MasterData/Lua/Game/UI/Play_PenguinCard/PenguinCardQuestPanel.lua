local PenguinCardQuestPanel = class("PenguinCardQuestPanel", BasePanel)
PenguinCardQuestPanel._sSortingLayerName = AllEnum.SortingLayerName.UI
PenguinCardQuestPanel._bIsMainPanel = false
PenguinCardQuestPanel._tbDefine = {
  {
    sPrefabPath = "Play_PenguinCard/PenguinCardQuestPanel.prefab",
    sCtrlName = "Game.UI.Play_PenguinCard.PenguinCardQuestCtrl"
  }
}

function PenguinCardQuestPanel:Awake()
end

function PenguinCardQuestPanel:OnEnable()
end

function PenguinCardQuestPanel:OnAfterEnter()
end

function PenguinCardQuestPanel:OnDisable()
end

function PenguinCardQuestPanel:OnDestroy()
end

function PenguinCardQuestPanel:OnRelease()
end

return PenguinCardQuestPanel
