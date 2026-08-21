local var_0_0 = class("EducateNewCharLayer", import(".base.EducateBaseUI"))

function var_0_0.getUIName(arg_1_0)
	return "EducateNewCharUI"
end

function var_0_0.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()

	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0.char = getProxy(EducateProxy):GetCharData()
	arg_3_0.defaultName = i18n("child_default_callname")
	arg_3_0.lockNamed = PLATFORM_CODE == PLATFORM_CH and LOCK_NAMED

	return
end

function var_0_0.findUI(arg_4_0)
	arg_4_0.blurPanel = arg_4_0._tf:Find("bg")
	arg_4_0.callInput = arg_4_0._tf:Find("bg/panel/input/nickname")
	arg_4_0.sureBtn = arg_4_0._tf:Find("bg/panel/sure_button")

	setText(arg_4_0.sureBtn:Find("Image"), i18n("word_ok"))
	setText(arg_4_0.callInput:Find("Placeholder"), i18n("child_callname_tip"))

	arg_4_0.callInput:GetComponent(typeof(InputField)).interactable = not arg_4_0.lockNamed

	setActive(arg_4_0._tf:Find("bg/panel/input/pan"), not arg_4_0.lockNamed)

	return
end

function var_0_0.addListener(arg_5_0)
	onButton(arg_5_0, arg_5_0.sureBtn, function()
		local var_6_0 = getInputText(arg_5_0.callInput)

		if var_6_0 == "" then
			return
		end

		if not nameValidityCheck(var_6_0, 4, 14, {
			"spece_illegal_tip",
			"login_newPlayerScene_name_tooShort",
			"login_newPlayerScene_name_tooLong",
			"login_newPlayerScene_invalideName"
		}) then
			return
		end

		arg_5_0:emit(EducateNewCharMediator.ON_SET_CALL, var_6_0)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.didEnter(arg_7_0)
	arg_7_0:OverlayPanel(arg_7_0.blurPanel, {
		groupDelta = 1,
		pbList = {
			arg_7_0.blurPanel
		}
	})
	setInputText(arg_7_0.callInput, arg_7_0.defaultName)

	return
end

function var_0_0.onBackPressed(arg_8_0)
	return
end

function var_0_0.willExit(arg_9_0)
	if arg_9_0.contextData.callback then
		arg_9_0.contextData.callback()
	end

	arg_9_0:UnOverlayPanel(arg_9_0.blurPanel, arg_9_0._tf)

	return
end

return var_0_0
