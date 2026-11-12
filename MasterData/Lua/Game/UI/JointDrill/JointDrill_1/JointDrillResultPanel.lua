local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillResultPanel_Mode1 = class("JointDrillResultPanel_Mode1", BasePanel)
JointDrillResultPanel_Mode1._sUIResRootPath = "UI_Activity/"

function JointDrillResultPanel_Mode1:Awake()
  local nActId = JointDrillContext.GetActIdForMode(GameEnum.JointDrillMode.JointDrill_Mode_1)
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "Result"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_1.JointDrillResultCtrl"
    }
  }
end

function JointDrillResultPanel_Mode1:OnEnable()
end

function JointDrillResultPanel_Mode1:OnAfterEnter()
end

function JointDrillResultPanel_Mode1:OnDisable()
end

function JointDrillResultPanel_Mode1:OnDestroy()
end

function JointDrillResultPanel_Mode1:OnRelease()
end

return JointDrillResultPanel_Mode1
