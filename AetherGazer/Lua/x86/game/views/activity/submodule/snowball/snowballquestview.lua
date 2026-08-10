local var_0_0 = class("SnowballQuestView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballQuestPopup"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

local function var_0_1(arg_3_0)
	return AssignmentCfg[arg_3_0.id].type == TaskConst.TASK_TYPE.SNOWBALL_TASK_CHALLENGE
end

function var_0_0.Init(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.questSubView = ActivityQuestSubView.New(arg_4_0.gameObject_, SnowballGameData.activityID, var_0_1, SnowballQuestItem, true)

	arg_4_0:AddBtnListener(arg_4_0.maskBtn_, nil, JumpTools.Back)
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.questSubView:OnEnter()
end

function var_0_0.OnExit(arg_6_0)
	arg_6_0.questSubView:OnExit()
end

function var_0_0.OnTop(arg_7_0)
	return
end

function var_0_0.OnBehind(arg_8_0)
	return
end

function var_0_0.Dispose(arg_9_0)
	arg_9_0.questSubView:Dispose()
	var_0_0.super.Dispose(arg_9_0)
end

return var_0_0
