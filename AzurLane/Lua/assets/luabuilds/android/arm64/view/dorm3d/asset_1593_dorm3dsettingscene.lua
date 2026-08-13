class = var_0_10000

local var_0_0 = "Dorm3dSettingScene"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.Setting.NewSettingsScene"))

function var_0_1.getUIName(arg_1_0)
	return "Dorm3dSettingUI"
end

function var_0_1.init(arg_2_0)
	local var_2_0 = arg_2_0._tf

	arg_2_0.backBtn = var_1.Find(var_2_0, "blur_panel/adapt/top/back_btn")

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.Find(var_2_1, "pages")
	local var_2_3 = {}

	Settings3DPage = var_2_1
	var_2_3[1] = var_2_1.New(var_2_2, arg_2_0.event, arg_2_0.contextData)
	arg_2_0.pages = var_2_3

	local var_2_4 = {}
	local var_2_5 = arg_2_0._tf

	var_2_4[1] = var_3.Find(var_2_5, "blur_panel/adapt/left_length/threeD")
	arg_2_0.toggles = var_2_4

	local var_2_6 = arg_2_0.toggles[1]

	arg_2_0.otherTip = var_2.Find(var_2_6, "tip")
	SettingsMsgBosPage = var_2
	arg_2_0.descWindow = var_2.New(arg_2_0._tf, arg_2_0.event)

	return
end

function var_0_1.didEnter(arg_3_0)
	onButton = var_1_10001

	local var_3_0 = arg_3_0
	local var_3_1 = arg_3_0.backBtn

	local function var_3_2()
		local var_4_0 = arg_3_0

		var_0.closeView(var_4_0)

		return
	end

	SFX_CANCEL = var_1_10006

	var_1_10001(var_3_0, var_3_1, var_3_2, var_1_10006)
	arg_3_0:SwitchPage(1)

	pg = var_1

	local var_3_3 = var_1.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_3, arg_3_0._tf)

	return
end

function var_0_1.onBackPressed(arg_5_0)
	arg_5_0:closeView()

	return
end

function var_0_1.willExit(arg_6_0)
	pg = var_1_10001

	local var_6_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_6_0, arg_6_0._tf)
	var_0_1.super.willExit(arg_6_0)

	return
end

return var_0_1
