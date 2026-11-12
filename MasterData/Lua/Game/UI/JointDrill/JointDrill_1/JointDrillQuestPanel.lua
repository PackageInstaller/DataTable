local JointDrillContext = require("Game.UI.JointDrill.JointDrillContext")
local JointDrillQuestPanel_Mode1 = class("JointDrillQuestPanel_Mode1", BasePanel)
JointDrillQuestPanel_Mode1._bIsMainPanel = false
JointDrillQuestPanel_Mode1._sUIResRootPath = "UI_Activity/"

function JointDrillQuestPanel_Mode1:Awake()
  local nActId = self._tbParam[1]
  self._tbDefine = {
    {
      sPrefabPath = JointDrillContext.GetPrefabPath(nActId, "Quest"),
      sCtrlName = "Game.UI.JointDrill.JointDrill_1.JointDrillQuestCtrl"
    }
  }
end

function JointDrillQuestPanel_Mode1:OnEnable()
end

function JointDrillQuestPanel_Mode1:OnAfterEnter()
end

function JointDrillQuestPanel_Mode1:OnDisable()
end

function JointDrillQuestPanel_Mode1:OnDestroy()
end

function JointDrillQuestPanel_Mode1:OnRelease()
end

return JointDrillQuestPanel_Mode1
