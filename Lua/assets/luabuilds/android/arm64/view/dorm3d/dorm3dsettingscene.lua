local var_0_0 = class("Dorm3dSettingScene", import("view.Setting.NewSettingsScene"))

function var_0_0.getUIName(arg_1_0)
	return "Dorm3dSettingUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0.backBtn = arg_2_0._tf:Find("blur_panel/adapt/top/back_btn")
	arg_2_0.pages = {
		Settings3DPage.New(arg_2_0._tf:Find("pages"), arg_2_0.event, arg_2_0.contextData)
	}
	arg_2_0.toggles = {
		arg_2_0._tf:Find("blur_panel/adapt/left_length/threeD")
	}
	arg_2_0.otherTip = arg_2_0.toggles[1]:Find("tip")
	arg_2_0.descWindow = SettingsMsgBosPage.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_0.didEnter(arg_3_0)
	onButton(arg_3_0, arg_3_0.backBtn, function()
		arg_3_0:closeView()

		return
	end, SFX_CANCEL)
	arg_3_0:SwitchPage(1)
	pg.UIMgr.GetInstance():BlurPanel(arg_3_0._tf)

	return
end

function var_0_0.onBackPressed(arg_5_0)
	arg_5_0:closeView()

	return
end

function var_0_0.willExit(arg_6_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_6_0._tf)
	var_0_0.super.willExit(arg_6_0)

	return
end

return var_0_0
