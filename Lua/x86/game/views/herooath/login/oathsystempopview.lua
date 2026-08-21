local var_0_0 = class("OathSystemPopView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "Widget/System/Hero_Oath/HeroOathSystemPopUI"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiPop.transform
end

function var_0_0.Init(arg_3_0)
	arg_3_0:InitUI()
	arg_3_0:AddUIListener()
end

function var_0_0.InitUI(arg_4_0)
	arg_4_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_5_0)
	arg_5_0:AddBtnListener(arg_5_0.closeBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "wedding_picture_open_tip",
			source = 1,
			sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM
		})
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.maskBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "wedding_picture_open_tip",
			source = 1,
			sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM
		})
		arg_5_0:Back()
	end)
	arg_5_0:AddBtnListener(arg_5_0.goBtn_, nil, function()
		OperationRecorder.RecordButtonTouch({
			button_name = "wedding_picture_open_tip",
			source = 2,
			sys_id = ViewConst.SYSTEM_ID.OATH_SYSTEM
		})
		arg_5_0:Back()
		JumpTools.GoToSystem("/adminHomePageView", nil, ViewConst.SYSTEM_ID.ADMIN_SYSTEM)
	end)
end

function var_0_0.OnEnter(arg_9_0)
	arg_9_0:RefreshUI()
end

function var_0_0.RefreshUI(arg_10_0)
	arg_10_0.descText_.text = GetTips("WEDDING_SYSTEM_UNLOCK_DESC")
end

function var_0_0.OnExit(arg_11_0)
	OathSupportData:SavePopTag(OathConst.OATH_OPEN_TAG_ID)
end

function var_0_0.OnTop(arg_12_0)
	manager.windowBar:SwitchBar({})
end

function var_0_0.Dispose(arg_13_0)
	arg_13_0.super.Dispose(arg_13_0)
end

return var_0_0
