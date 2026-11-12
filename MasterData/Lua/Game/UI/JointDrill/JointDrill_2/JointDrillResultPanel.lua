local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillResultPanel_Mode2 = class("JointDrillResultPanel_Mode2", BasePanel)
JointDrillResultPanel_Mode2._sUIResRootPath = "UI_Activity/"

function JointDrillResultPanel_Mode2:Awake()
  local nActId = JointDrillContext.GetActIdForMode(GameEnum.JointDrillMode.JointDrill_Mode_2)
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "Result"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_2.JointDrillResultCtrl"
    }
  }
end

function JointDrillResultPanel_Mode2:OnEnable()
end

function JointDrillResultPanel_Mode2:OnAfterEnter()
end

function JointDrillResultPanel_Mode2:OnDisable()
end

function JointDrillResultPanel_Mode2:OnDestroy()
end

function JointDrillResultPanel_Mode2:OnRelease()
end

return JointDrillResultPanel_Mode2
