local MathParkourSkillDisplayPanel = class("MathParkourSkillDisplayPanel", BasePanel)
MathParkourSkillDisplayPanel._bIsMainPanel = false
MathParkourSkillDisplayPanel._tbDefine = {
  {
    sPrefabPath = "Activity/MathParkour/400018/MathParkourSkillDisplayPanel.prefab",
    sCtrlName = "Game.UI.Activity.MathParkour.MathParkourSkillDisplayPanelCtrl"
  }
}

function MathParkourSkillDisplayPanel:Awake()
end

function MathParkourSkillDisplayPanel:OnEnable()
end

function MathParkourSkillDisplayPanel:OnAfterEnter()
end

function MathParkourSkillDisplayPanel:OnDisable()
end

function MathParkourSkillDisplayPanel:OnDestroy()
end

function MathParkourSkillDisplayPanel:OnRelease()
end

return MathParkourSkillDisplayPanel
