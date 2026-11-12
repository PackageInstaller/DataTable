local MathParkourLevelSelectPanel = class("MathParkourLevelSelectPanel", BasePanel)
MathParkourLevelSelectPanel._sUIResRootPath = "UI_Activity/"
MathParkourLevelSelectPanel._tbDefine = {
  {
    sPrefabPath = "_400018/MathParkourLevelsSelect.prefab",
    sCtrlName = "Game.UI.Activity.MathParkour.MathParkourLevelSelectCtrl"
  }
}

function MathParkourLevelSelectPanel:Awake()
  self.nSelectIndex = 0
end

function MathParkourLevelSelectPanel:OnEnable()
end

function MathParkourLevelSelectPanel:OnAfterEnter()
end

function MathParkourLevelSelectPanel:OnDisable()
end

function MathParkourLevelSelectPanel:OnDestroy()
end

function MathParkourLevelSelectPanel:OnRelease()
end

return MathParkourLevelSelectPanel
