local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillRankingPanel_Mode2 = class("JointDrillRankingPanel_Mode2", BasePanel)
JointDrillRankingPanel_Mode2._sUIResRootPath = "UI_Activity/"

function JointDrillRankingPanel_Mode2:Awake()
  local nActId = self._tbParam[1]
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "Ranking"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_2.JointDrillRankingCtrl"
    }
  }
end

function JointDrillRankingPanel_Mode2:OnEnable()
end

function JointDrillRankingPanel_Mode2:OnAfterEnter()
end

function JointDrillRankingPanel_Mode2:OnDisable()
end

function JointDrillRankingPanel_Mode2:OnDestroy()
end

function JointDrillRankingPanel_Mode2:OnRelease()
end

return JointDrillRankingPanel_Mode2
