local SoldierBossTemplateTipsPanel = class("SoldierBossTemplateTipsPanel", BasePanel)
SoldierBossTemplateTipsPanel._bIsMainPanel = false
SoldierBossTemplateTipsPanel._tbDefine = {
  {
    sPrefabPath = "Soldier/Tips/SoldierBossTemplateTips.prefab",
    sCtrlName = "Game.UI.Soldier.BossTemplate.SoldierBossTemplateTipsCtrl"
  }
}

function SoldierBossTemplateTipsPanel:Awake()
end

function SoldierBossTemplateTipsPanel:OnEnable()
end

function SoldierBossTemplateTipsPanel:OnAfterEnter()
end

function SoldierBossTemplateTipsPanel:OnDisable()
end

function SoldierBossTemplateTipsPanel:OnDestroy()
end

function SoldierBossTemplateTipsPanel:OnRelease()
end

return SoldierBossTemplateTipsPanel
