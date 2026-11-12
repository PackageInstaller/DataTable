local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillRankUpPanel_Mode2 = class("JointDrillRankUpPanel_Mode2", BasePanel)
JointDrillRankUpPanel_Mode2._bIsMainPanel = false
JointDrillRankUpPanel_Mode2._sUIResRootPath = "UI_Activity/"

function JointDrillRankUpPanel_Mode2:Awake()
  local nActId = JointDrillContext.GetActIdForMode(GameEnum.JointDrillMode.JointDrill_Mode_2)
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "RankUp"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_2.JointDrillRankUpCtrl"
    }
  }
end

function JointDrillRankUpPanel_Mode2:OnEnable()
end

function JointDrillRankUpPanel_Mode2:OnAfterEnter()
end

function JointDrillRankUpPanel_Mode2:OnDisable()
end

function JointDrillRankUpPanel_Mode2:OnDestroy()
end

function JointDrillRankUpPanel_Mode2:OnRelease()
end

return JointDrillRankUpPanel_Mode2
