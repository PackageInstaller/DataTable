class = var_0_10000

local var_0_0 = "NewEducateSetCallLayer"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.newEducate.base.NewEducateBaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "NewEducateSetCallUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_1.initData(arg_3_0)
	i18n = var_1_10001
	arg_3_0.defaultName = var_1_10001("child_default_callname")
	PLATFORM_CODE = var_3_0
	PLATFORM_CH = var_1_10002

	local var_3_0 = var_3_0 == var_1_10002 and var_3_0

	arg_3_0.lockNamed = var_3_0

	return
end

function var_0_1.findUI(arg_4_0)
	local var_4_0 = arg_4_0._tf

	arg_4_0.bgTF = var_1.Find(var_4_0, "Image")

	local var_4_1 = arg_4_0._tf

	arg_4_0.blurPanel = var_1.Find(var_4_1, "bg")

	local var_4_2 = arg_4_0._tf

	arg_4_0.callInput = var_1.Find(var_4_2, "bg/panel/input/nickname")

	local var_4_3 = arg_4_0._tf

	arg_4_0.sureBtn = var_1.Find(var_4_3, "bg/panel/sure_button")
	setText = var_1

	local var_4_4 = arg_4_0.sureBtn
	local var_4_5 = var_3.Find(var_4_4, "Image")

	i18n = var_4

	var_1(var_4_5, var_4("word_ok"))

	setText = var_1

	local var_4_6 = arg_4_0.callInput
	local var_4_7 = var_3.Find(var_4_6, "Placeholder")

	i18n = var_4

	var_1(var_4_7, var_4("child_callname_tip"))

	local var_4_8 = arg_4_0.callInput
	local var_4_9 = var_1.GetComponent

	typeof = var_4
	InputField = var_6

	local var_4_10 = var_4_9(var_4_8, var_4(var_6))

	var_4_10.interactable = not arg_4_0.lockNamed
	setActive = var_4_10

	local var_4_11 = arg_4_0._tf

	var_4_10(var_3.Find(var_4_11, "bg/panel/input/pan"), not arg_4_0.lockNamed)

	return
end

function var_0_1.addListener(arg_5_0)
	onButton = var_1_10001

	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.sureBtn

	local function var_5_2()
		getInputText = var_2_10000

		if var_2_10000(arg_5_0.callInput) == "" then
			return
		end

		nameValidityCheck = var_2_10001

		if not var_2_10001(var_0, 4, 14, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"login_newPlayerScene_invalideName"
		}) then
			return
		end

		local var_6_0 = arg_5_0
		local var_6_1 = var_1.emit

		NewEducateSetCallediator = var_4

		var_6_1(var_6_0, var_4.ON_SET_CALL, var_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1_10001(var_5_0, var_5_1, var_5_2, var_1_10006)

	return
end

function var_0_1.didEnter(arg_7_0)
	local var_7_0 = arg_7_0.contextData.char
	local var_7_1 = var_1.getConfig(var_7_0, "name_background")

	setImageSprite = var_1_10002

	local var_7_2 = arg_7_0.bgTF

	LoadSprite = var_1_10005

	var_1_10002(var_7_2, var_1_10005("bg/" .. var_7_1), false)
	arg_7_0:OverlayPanel(arg_7_0.blurPanel, {
		groupDelta = 1,
		pbList = {
			arg_7_0.blurPanel
		}
	})

	setInputText = var_2

	var_2(arg_7_0.callInput, arg_7_0.defaultName)

	return
end

function var_0_1.onBackPressed(arg_8_0)
	return
end

function var_0_1.willExit(arg_9_0)
	if arg_9_0.contextData.callback then
		var_1()
	end

	arg_9_0:UnOverlayPanel(arg_9_0.blurPanel, arg_9_0._tf)

	return
end

return var_0_1
