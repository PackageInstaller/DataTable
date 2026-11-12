local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillRankingPanel_Mode1 = class("JointDrillRankingPanel_Mode1", BasePanel)
JointDrillRankingPanel_Mode1._sUIResRootPath = "UI_Activity/"

function JointDrillRankingPanel_Mode1:Awake()
  local nActId = self._tbParam[1]
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "Ranking"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_1.JointDrillRankingCtrl"
    }
  }
end

function JointDrillRankingPanel_Mode1:OnEnable()
end

function JointDrillRankingPanel_Mode1:OnAfterEnter()
end

function JointDrillRankingPanel_Mode1:OnDisable()
end

function JointDrillRankingPanel_Mode1:OnDestroy()
end

function JointDrillRankingPanel_Mode1:OnRelease()
end

return JointDrillRankingPanel_Mode1
