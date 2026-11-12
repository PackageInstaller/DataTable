local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillRankDetailPanel_Mode1 = class("JointDrillRankDetailPanel_Mode1", BasePanel)
JointDrillRankDetailPanel_Mode1._bIsMainPanel = false
JointDrillRankDetailPanel_Mode1._sUIResRootPath = "UI_Activity/"

function JointDrillRankDetailPanel_Mode1:Awake()
  local nActId = JointDrillContext.GetActIdForMode(GameEnum.JointDrillMode.JointDrill_Mode_1)
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "RankDetail"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_1.JointDrillRankDetailCtrl"
    }
  }
end

function JointDrillRankDetailPanel_Mode1:OnEnable()
end

function JointDrillRankDetailPanel_Mode1:OnAfterEnter()
end

function JointDrillRankDetailPanel_Mode1:OnDisable()
end

function JointDrillRankDetailPanel_Mode1:OnDestroy()
end

function JointDrillRankDetailPanel_Mode1:OnRelease()
end

return JointDrillRankDetailPanel_Mode1
