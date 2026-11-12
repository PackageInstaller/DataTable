local MainBattlePausePanel = class("MainBattlePausePanel", BasePanel)
MainBattlePausePanel._bIsMainPanel = false
MainBattlePausePanel._tbDefine = {
  {
    sPrefabPath = "Battle/MainBattlePausePanel.prefab",
    sCtrlName = "Game.UI.Battle.MainBattlePauseCtrl"
  }
}

function MainBattlePausePanel:Awake()
end

function MainBattlePausePanel:OnEnable()
end

function MainBattlePausePanel:OnDisable()
end

function MainBattlePausePanel:OnDestroy()
end

return MainBattlePausePanel
