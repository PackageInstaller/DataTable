local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillQuestPanel_Mode2 = class("JointDrillQuestPanel_Mode2", BasePanel)
JointDrillQuestPanel_Mode2._bIsMainPanel = false
JointDrillQuestPanel_Mode2._sUIResRootPath = "UI_Activity/"

function JointDrillQuestPanel_Mode2:Awake()
  local nActId = self._tbParam[1]
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "Quest"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_2.JointDrillQuestCtrl"
    }
  }
end

function JointDrillQuestPanel_Mode2:OnEnable()
end

function JointDrillQuestPanel_Mode2:OnAfterEnter()
end

function JointDrillQuestPanel_Mode2:OnDisable()
end

function JointDrillQuestPanel_Mode2:OnDestroy()
end

function JointDrillQuestPanel_Mode2:OnRelease()
end

return JointDrillQuestPanel_Mode2
