local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillBuildListPanel_Mode1 = class("JointDrillBuildListPanel_Mode1", BasePanel)
JointDrillBuildListPanel_Mode1._sUIResRootPath = "UI_Activity/"

function JointDrillBuildListPanel_Mode1:Awake()
  local nActId = JointDrillContext.GetActIdForMode(GameEnum.JointDrillMode.JointDrill_Mode_1)
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "BuildList"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_1.JointDrillBuildListCtrl"
    }
  }
end

function JointDrillBuildListPanel_Mode1:OnEnable()
end

function JointDrillBuildListPanel_Mode1:OnAfterEnter()
end

function JointDrillBuildListPanel_Mode1:OnDisable()
end

function JointDrillBuildListPanel_Mode1:OnDestroy()
end

function JointDrillBuildListPanel_Mode1:OnRelease()
end

return JointDrillBuildListPanel_Mode1
