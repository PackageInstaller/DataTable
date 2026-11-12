local SkillInstanceResultPanel = class("SkillInstanceResultPanel", BasePanel)
SkillInstanceResultPanel._bAddToBackHistory = false
SkillInstanceResultPanel._tbDefine = {
  {
    sPrefabPath = "BattleResult/BattleResultPanel.prefab",
    sCtrlName = "Game.UI.BattleResult.SkillInstanceResultCtrl"
  }
}

function SkillInstanceResultPanel:Awake()
end

function SkillInstanceResultPanel:OnEnable()
end

function SkillInstanceResultPanel:OnDisable()
end

function SkillInstanceResultPanel:OnDestroy()
end

return SkillInstanceResultPanel
