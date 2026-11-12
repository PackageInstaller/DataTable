local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillRankDetailPanel_Mode2 = class("JointDrillRankDetailPanel_Mode2", BasePanel)
JointDrillRankDetailPanel_Mode2._bIsMainPanel = false
JointDrillRankDetailPanel_Mode2._sUIResRootPath = "UI_Activity/"

function JointDrillRankDetailPanel_Mode2:Awake()
  local nActId = JointDrillContext.GetActIdForMode(GameEnum.JointDrillMode.JointDrill_Mode_2)
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "RankDetail"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_2.JointDrillRankDetailCtrl"
    }
  }
end

function JointDrillRankDetailPanel_Mode2:OnEnable()
end

function JointDrillRankDetailPanel_Mode2:OnAfterEnter()
end

function JointDrillRankDetailPanel_Mode2:OnDisable()
end

function JointDrillRankDetailPanel_Mode2:OnDestroy()
end

function JointDrillRankDetailPanel_Mode2:OnRelease()
end

return JointDrillRankDetailPanel_Mode2
