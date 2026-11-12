local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillLevelSelectPanel_Mode1 = class("JointDrillLevelSelectPanel_Mode1", BasePanel)
JointDrillLevelSelectPanel_Mode1._sUIResRootPath = "UI_Activity/"

function JointDrillLevelSelectPanel_Mode1:Awake()
  local nActId = self._tbParam[1]
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "LevelSelect"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_1.JointDrillLevelSelectCtrl"
    }
  }
end

function JointDrillLevelSelectPanel_Mode1:OnEnable()
end

function JointDrillLevelSelectPanel_Mode1:OnAfterEnter()
end

function JointDrillLevelSelectPanel_Mode1:OnDisable()
end

function JointDrillLevelSelectPanel_Mode1:OnDestroy()
end

function JointDrillLevelSelectPanel_Mode1:OnRelease()
end

return JointDrillLevelSelectPanel_Mode1
