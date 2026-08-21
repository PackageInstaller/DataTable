local var_0_0 = class("ActivityPushBoxQuitView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/BoxGamePausePopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListeners()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListeners(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.okBtn_, nil, function()
		PushBoxTool:SendSdk(arg_5_0.params_.activityID, arg_5_0.params_.id, 3)

		if arg_5_0.params_.way == "back" then
			JumpTools.OpenPageByJump("/activityPushBoxMaterial", {
				activityID = arg_5_0.params_.activityID
			})
		elseif arg_5_0.params_.way == "home" then
			JumpTools.OpenPageByJump("/home")
		end
	end)
	arg_5_0:AddBtnListener(arg_5_0.cancelBtn_, nil, function()
		arg_5_0:Back()
	end)
end

function var_0_0.OnEnter(arg_8_0)
	return
end

function var_0_0.OnExit(arg_9_0)
	return
end

function var_0_0.Dispose(arg_10_0)
	arg_10_0:RemoveAllListeners()
	arg_10_0.super.Dispose(arg_10_0)
end

return var_0_0
