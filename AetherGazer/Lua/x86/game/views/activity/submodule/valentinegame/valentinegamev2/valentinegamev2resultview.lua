local var_0_0 = class("ValentineGameV2ResultView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaValentineUI/IndiaValentineResultUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()

	arg_4_0.controller_ = ControllerUtil.GetController(arg_4_0.transform_, "isright")
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.btn_, nil, function()
		manager.story:StartStoryById(ActivityValentineWordCfg[arg_5_0.curQID_].stroy_id_list[arg_5_0.selectIndex_], function(arg_7_0)
			JumpTools.OpenPageByJump("/valentineGameV2HeroInfoView", {
				activityID = arg_5_0.activityID_
			})
		end, true)
	end)
end

function var_0_0.OnEnter(arg_8_0)
	arg_8_0.activityID_ = arg_8_0.params_.activityID
	arg_8_0.curQID_ = arg_8_0.params_.qID
	arg_8_0.selectIndex_ = arg_8_0.params_.selectIndex

	arg_8_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_9_0)
	if arg_9_0.selectIndex_ == ActivityValentineWordCfg[arg_9_0.curQID_].correct_answer then
		arg_9_0.controller_:SetSelectedState("true")
	else
		arg_9_0.controller_:SetSelectedState("false")
	end
end

function var_0_0.OnTop(arg_10_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function()
		JumpTools.OpenPageByJump("/valentineGameV2HeroInfoView", {
			activityID = arg_10_0.activityID_
		})
	end)
end

function var_0_0.OnExit(arg_12_0)
	manager.windowBar:HideBar()
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.super.Dispose(arg_13_0)
end

return var_0_0
