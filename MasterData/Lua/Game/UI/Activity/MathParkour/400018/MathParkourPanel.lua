local MathParkourPanel = class("MathParkourPanel", BasePanel)
local GamepadUIManager = require("GameCore.Module.GamepadUIManager")
MathParkourPanel._sUIResRootPath = "UI_Activity/"
MathParkourPanel._tbDefine = {
  {
    sPrefabPath = "_400018/MathParkourPanel.prefab",
    sCtrlName = "Game.UI.Activity.MathParkour.MathParkourCtrl"
  },
  {
    sPrefabPath = "_400018/MathParkourSkillDisplayPanel.prefab",
    sCtrlName = "Game.UI.Activity.MathParkour.MathParkourSkillDisplayCtrl"
  }
}

function MathParkourPanel:Awake()
  GamepadUIManager.EnterAdventure(true)
  GamepadUIManager.EnableGamepadUI("MathParkourCtrl", {}, nil, true)
end

function MathParkourPanel:OnEnable()
end

function MathParkourPanel:OnAfterEnter()
end

function MathParkourPanel:OnDisable()
end

function MathParkourPanel:OnDestroy()
  GamepadUIManager.DisableGamepadUI("MathParkourCtrl")
  GamepadUIManager.QuitAdventure()
end

function MathParkourPanel:OnRelease()
end

return MathParkourPanel
