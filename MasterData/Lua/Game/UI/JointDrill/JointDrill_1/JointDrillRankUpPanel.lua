local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillRankUpPanel_Mode1 = class("JointDrillRankUpPanel_Mode1", BasePanel)
JointDrillRankUpPanel_Mode1._bIsMainPanel = false
JointDrillRankUpPanel_Mode1._sUIResRootPath = "UI_Activity/"

function JointDrillRankUpPanel_Mode1:Awake()
  local nActId = JointDrillContext.GetActIdForMode(GameEnum.JointDrillMode.JointDrill_Mode_1)
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "RankUp"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_1.JointDrillRankUpCtrl"
    }
  }
end

function JointDrillRankUpPanel_Mode1:OnEnable()
end

function JointDrillRankUpPanel_Mode1:OnAfterEnter()
end

function JointDrillRankUpPanel_Mode1:OnDisable()
end

function JointDrillRankUpPanel_Mode1:OnDestroy()
end

function JointDrillRankUpPanel_Mode1:OnRelease()
end

return JointDrillRankUpPanel_Mode1
