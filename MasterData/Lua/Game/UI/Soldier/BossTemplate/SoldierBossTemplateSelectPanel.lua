local SoldierBossTemplateSelectPanel = class("SoldierBossTemplateSelectPanel", BasePanel)
SoldierBossTemplateSelectPanel._bIsMainPanel = false
SoldierBossTemplateSelectPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Level/SoldierBossTemplateSelect.prefab",
    sCtrlName = "Game.UI.Soldier.BossTemplate.SoldierBossTemplateSelectCtrl"
  }
}

function SoldierBossTemplateSelectPanel:Awake()
end

function SoldierBossTemplateSelectPanel:OnEnable()
end

function SoldierBossTemplateSelectPanel:OnAfterEnter()
end

function SoldierBossTemplateSelectPanel:OnDisable()
end

function SoldierBossTemplateSelectPanel:OnDestroy()
end

function SoldierBossTemplateSelectPanel:OnRelease()
end

return SoldierBossTemplateSelectPanel
