local SoldierTechPreviewPanel = class("SoldierTechPreviewPanel", BasePanel)
SoldierTechPreviewPanel._bIsMainPanel = false
SoldierTechPreviewPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Technology/SoldierTechnologyPreview.prefab",
    sCtrlName = "Game.UI.Soldier.Technology.SoldierTechPreviewCtrl"
  }
}

function SoldierTechPreviewPanel:Awake()
end

function SoldierTechPreviewPanel:OnEnable()
end

function SoldierTechPreviewPanel:OnAfterEnter()
end

function SoldierTechPreviewPanel:OnDisable()
end

function SoldierTechPreviewPanel:OnDestroy()
end

function SoldierTechPreviewPanel:OnRelease()
end

return SoldierTechPreviewPanel
