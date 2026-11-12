local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillRaidPanel_Mode1 = class("JointDrillRaidPanel_Mode1", BasePanel)
JointDrillRaidPanel_Mode1._bIsMainPanel = false
JointDrillRaidPanel_Mode1._sUIResRootPath = "UI_Activity/"

function JointDrillRaidPanel_Mode1:Awake()
  local nActId = JointDrillContext.GetActIdForMode(GameEnum.JointDrillMode.JointDrill_Mode_1)
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "Raid"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_1.JointDrillRaidCtrl"
    }
  }
end

function JointDrillRaidPanel_Mode1:OnEnable()
end

function JointDrillRaidPanel_Mode1:OnAfterEnter()
end

function JointDrillRaidPanel_Mode1:OnDisable()
end

function JointDrillRaidPanel_Mode1:OnDestroy()
end

function JointDrillRaidPanel_Mode1:OnRelease()
end

return JointDrillRaidPanel_Mode1
