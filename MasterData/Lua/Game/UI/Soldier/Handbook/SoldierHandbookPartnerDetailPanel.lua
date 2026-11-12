local SoldierHandbookPartnerDetailPanel = class("SoldierHandbookPartnerDetailPanel", BasePanel)
SoldierHandbookPartnerDetailPanel._bIsMainPanel = false
SoldierHandbookPartnerDetailPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/SoldierHandbookPartnerDetailPanel.prefab",
    sCtrlName = "Game.UI.Soldier.Handbook.SoldierHandbookPartnerDetailCtrl"
  }
}

function SoldierHandbookPartnerDetailPanel:Awake()
end

function SoldierHandbookPartnerDetailPanel:OnEnable()
end

function SoldierHandbookPartnerDetailPanel:OnAfterEnter()
end

function SoldierHandbookPartnerDetailPanel:OnDisable()
end

function SoldierHandbookPartnerDetailPanel:OnDestroy()
end

function SoldierHandbookPartnerDetailPanel:OnRelease()
end

return SoldierHandbookPartnerDetailPanel
