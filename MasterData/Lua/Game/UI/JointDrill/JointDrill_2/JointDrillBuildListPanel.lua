local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillBuildListPanel_Mode2 = class("JointDrillBuildListPanel_Mode2", BasePanel)
JointDrillBuildListPanel_Mode2._sUIResRootPath = "UI_Activity/"

function JointDrillBuildListPanel_Mode2:Awake()
  local nActId = JointDrillContext.GetActIdForMode(GameEnum.JointDrillMode.JointDrill_Mode_2)
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "BuildList"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_2.JointDrillBuildListCtrl"
    }
  }
end

function JointDrillBuildListPanel_Mode2:OnEnable()
end

function JointDrillBuildListPanel_Mode2:OnAfterEnter()
end

function JointDrillBuildListPanel_Mode2:OnDisable()
end

function JointDrillBuildListPanel_Mode2:OnDestroy()
end

function JointDrillBuildListPanel_Mode2:OnRelease()
end

return JointDrillBuildListPanel_Mode2
