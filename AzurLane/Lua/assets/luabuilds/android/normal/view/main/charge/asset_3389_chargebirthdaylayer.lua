class = var_0_10000

local var_0_0 = "ChargeBirthdayLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.BaseUI"))

function var_0_1.getUIName(arg_1_0)
	return "ChargeBirthdayUI"
end

function var_0_1.init(arg_2_0)
	arg_2_0:initData()
	arg_2_0:findUI()
	arg_2_0:addListener()
	arg_2_0:initUIText()

	return
end

function var_0_1.didEnter(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.UIMgr.GetInstance()

	var_1.BlurPanel(var_3_0, arg_3_0._tf)

	return
end

function var_0_1.willExit(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_4_0, arg_4_0._tf)

	return
end

function var_0_1.initData(arg_5_0)
	return
end

function var_0_1.initUIText(arg_6_0)
	arg_6_0.inputSC.text = ""

	return
end

function var_0_1.findUI(arg_7_0)
	local var_7_0 = arg_7_0._tf

	arg_7_0.bg = var_1.Find(var_7_0, "bg")

	local var_7_1 = arg_7_0._tf

	arg_7_0.window = var_1.Find(var_7_1, "window")

	local var_7_2 = arg_7_0.window

	arg_7_0.inputField = var_1.Find(var_7_2, "birthday_input_panel/InputField")
	GetComponent = var_1

	local var_7_3 = arg_7_0.inputField

	typeof = var_3
	InputField = var_1_10004
	arg_7_0.inputSC = var_1(var_7_3, var_3(var_1_10004))

	local var_7_4 = arg_7_0.window

	arg_7_0.cancelBtn = var_1.Find(var_7_4, "birthday_input_panel/btns/cancel_btn")

	local var_7_5 = arg_7_0.window

	arg_7_0.confirmBtn = var_1.Find(var_7_5, "birthday_input_panel/btns/confirm_btn")

	local var_7_6 = arg_7_0.window

	arg_7_0.closeBtn = var_1.Find(var_7_6, "top/btnBack")

	return
end

function var_0_1.addListener(arg_8_0)
	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.bg, function()
		local var_9_0 = arg_8_0

		var_0.closeView(var_9_0)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.cancelBtn, function()
		local var_10_0 = arg_8_0

		var_0.closeView(var_10_0)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.closeBtn, function()
		local var_11_0 = arg_8_0

		var_0.closeView(var_11_0)

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_8_0, arg_8_0.confirmBtn, function()
		checkBirthFormat = var_2_10000

		local var_12_1

		if not var_2_10000(arg_8_0.inputSC.text) then
			pg = var_12_1

			local var_12_0 = var_12_1.TipsMgr.GetInstance()

			var_12_1 = var_12_1.ShowTips
			i18n = var_2_10002

			var_12_1(var_12_0, var_2_10002("set_birth_empty_tip"))
		else
			pg = var_12_1

			local var_12_2 = var_12_1.MsgboxMgr.GetInstance()
			local var_12_3 = var_0.ShowMsgBox
			local var_12_4 = {
				modal = true
			}

			i18n = var_2_10003
			var_12_4.title = var_2_10003("set_birth_title")
			i18n = var_3
			var_12_4.content = var_3("set_birth_confirm_tip", arg_8_0.inputSC.text)

			function var_12_4.onYes()
				pg = var_3_10000

				local var_13_0 = var_3_10000.SdkMgr.GetInstance()

				var_0.SetBirth(var_13_0, arg_8_0.inputSC.text)

				local var_13_1 = arg_8_0

				var_0.closeView(var_13_1)

				return
			end

			var_12_3(var_12_2, var_12_4)
		end

		return
	end)

	return
end

return var_0_1
