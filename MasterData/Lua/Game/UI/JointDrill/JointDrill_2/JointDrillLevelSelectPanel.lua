local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillLevelSelectPanel_Mode2 = class("JointDrillLevelSelectPanel_Mode2", BasePanel)
JointDrillLevelSelectPanel_Mode2._sUIResRootPath = "UI_Activity/"

function JointDrillLevelSelectPanel_Mode2:Awake()
  local nActId = self._tbParam[1]
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "LevelSelect"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_2.JointDrillLevelSelectCtrl"
    }
  }
end

function JointDrillLevelSelectPanel_Mode2:OnEnable()
end

function JointDrillLevelSelectPanel_Mode2:OnAfterEnter()
end

function JointDrillLevelSelectPanel_Mode2:OnDisable()
end

function JointDrillLevelSelectPanel_Mode2:OnDestroy()
end

function JointDrillLevelSelectPanel_Mode2:OnRelease()
end

return JointDrillLevelSelectPanel_Mode2
