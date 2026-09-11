local SnowballQuestView = class("SnowballQuestView", ReduxView)

function SnowballQuestView:UIName()
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballQuestPopup"
end

function SnowballQuestView:UIParent()
	return manager.ui.uiMain.transform
end

local function var_0_1(arg_3_0)
	return AssignmentCfg[arg_3_0.id].type == TaskConst.TASK_TYPE.SNOWBALL_TASK_CHALLENGE
end

function SnowballQuestView:Init()
	self:BindCfgUI()

	self.questSubView = ActivityQuestSubView.New(self.gameObject_, SnowballGameData.activityID, var_0_1, SnowballQuestItem, true)

	self:AddBtnListener(self.maskBtn_, nil, JumpTools.Back)
end

function SnowballQuestView:OnEnter()
	self.questSubView:OnEnter()
end

function SnowballQuestView:OnExit()
	self.questSubView:OnExit()
end

function SnowballQuestView:OnTop()
	return
end

function SnowballQuestView:OnBehind()
	return
end

function SnowballQuestView:Dispose()
	self.questSubView:Dispose()
	SnowballQuestView.super.Dispose(self)
end

return SnowballQuestView
