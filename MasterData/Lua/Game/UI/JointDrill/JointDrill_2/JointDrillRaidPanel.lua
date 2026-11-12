local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillRaidPanel_Mode2 = class("JointDrillRaidPanel_Mode2", BasePanel)
JointDrillRaidPanel_Mode2._bIsMainPanel = false
JointDrillRaidPanel_Mode2._sUIResRootPath = "UI_Activity/"

function JointDrillRaidPanel_Mode2:Awake()
  local nActId = JointDrillContext.GetActIdForMode(GameEnum.JointDrillMode.JointDrill_Mode_2)
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "Raid"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_2.JointDrillRaidCtrl"
    }
  }
end

function JointDrillRaidPanel_Mode2:OnEnable()
end

function JointDrillRaidPanel_Mode2:OnAfterEnter()
end

function JointDrillRaidPanel_Mode2:OnDisable()
end

function JointDrillRaidPanel_Mode2:OnDestroy()
end

function JointDrillRaidPanel_Mode2:OnRelease()
end

return JointDrillRaidPanel_Mode2
