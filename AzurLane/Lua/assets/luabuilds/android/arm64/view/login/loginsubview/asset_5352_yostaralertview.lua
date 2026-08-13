class = var_0_10000

local var_0_0 = "YostarAlertView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "YostarAlertView"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.SetShareData(arg_3_0, arg_3_1)
	arg_3_0.shareData = arg_3_1

	return
end

function var_0_1.OnInit(arg_4_0)
	arg_4_0.yostarAlert = arg_4_0._tf

	local var_4_0 = arg_4_0.yostarAlert

	arg_4_0.yostarEmailTxt = var_1.Find(var_4_0, "email_input_txt")

	local var_4_1 = arg_4_0.yostarAlert

	arg_4_0.yostarCodeTxt = var_1.Find(var_4_1, "code_input_txt")

	local var_4_2 = arg_4_0.yostarAlert

	arg_4_0.yostarGenCodeBtn = var_1.Find(var_4_2, "gen_code_btn")

	local var_4_3 = arg_4_0.yostarGenCodeBtn

	arg_4_0.yostarGenTxt = var_1.Find(var_4_3, "Text")

	local var_4_4 = arg_4_0.yostarAlert

	arg_4_0.yostarSureBtn = var_1.Find(var_4_4, "login_btn")

	local var_4_5 = arg_4_0.yostarAlert

	arg_4_0.email_text = var_1.Find(var_4_5, "title1")

	local var_4_6 = arg_4_0.yostarEmailTxt

	arg_4_0.emailhold_text = var_1.Find(var_4_6, "Placeholder")

	local var_4_7 = arg_4_0.yostarAlert

	arg_4_0.code_text = var_1.Find(var_4_7, "title2")

	local var_4_8 = arg_4_0.yostarCodeTxt

	arg_4_0.codehold_text = var_1.Find(var_4_8, "Placeholder")

	local var_4_9 = arg_4_0.yostarGenCodeBtn

	arg_4_0.genBtn_text = var_1.Find(var_4_9, "Text")

	local var_4_10 = arg_4_0.yostarAlert

	arg_4_0.desc_text = var_1.Find(var_4_10, "desc")

	local var_4_11 = arg_4_0.yostarSureBtn

	arg_4_0.loginBtn_text = var_1.Find(var_4_11, "Image")
	setText = var_1

	local var_4_12 = arg_4_0.email_text

	i18n = var_4

	var_1(var_4_12, var_4("email_text"))

	setText = var_1

	local var_4_13 = arg_4_0.emailhold_text

	i18n = var_4

	var_1(var_4_13, var_4("emailhold_text"))

	setText = var_1

	local var_4_14 = arg_4_0.code_text

	i18n = var_4

	var_1(var_4_14, var_4("code_text"))

	setText = var_1

	local var_4_15 = arg_4_0.codehold_text

	i18n = var_4

	var_1(var_4_15, var_4("codehold_text"))

	setText = var_1

	local var_4_16 = arg_4_0.genBtn_text

	i18n = var_4

	var_1(var_4_16, var_4("genBtn_text"))

	setText = var_1

	local var_4_17 = arg_4_0.desc_text

	i18n = var_4

	var_1(var_4_17, var_4("desc_text"))

	setText = var_1

	local var_4_18 = arg_4_0.loginBtn_text

	if arg_4_0.contextData.isLinkMode == true then
		i18n = var_4_19

		local var_4_19

		if not var_4_19("linkBtn_text") then
			i18n = var_4_19
			var_4_19 = var_4_19("loginBtn_text")
		end

		var_1(var_4_18, var_4_19)
		arg_4_0:InitEvent()

		return
	end
end

function var_0_1.InitEvent(arg_5_0)
	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.yostarAlert, function()
		setActive = var_2_10000

		var_2_10000(arg_5_0.yostarAlert, false)

		if arg_5_0.contextData.isDestroyOnClose == true then
			local var_6_0 = arg_5_0

			var_0.Destroy(var_6_0)
		end

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.yostarGenCodeBtn, function()
		getInputText = var_2_10000

		if var_2_10000(arg_5_0.yostarEmailTxt) ~= "" then
			pg = var_2_10001

			local var_7_0 = var_2_10001.SdkMgr.GetInstance()

			var_2_10001.VerificationCodeReq(var_7_0, var_0)

			local var_7_1 = arg_5_0

			var_2_10001.CheckAiriGenCodeCounter(var_7_1)
		else
			pg = var_2_10001

			local var_7_2 = var_2_10001.TipsMgr.GetInstance()
			local var_7_3 = var_1.ShowTips

			i18n = var_2_10004

			var_7_3(var_7_2, var_2_10004("verification_code_req_tip1"))
		end

		return
	end)

	onButton = var_1_10001

	var_1_10001(arg_5_0, arg_5_0.yostarSureBtn, function()
		getInputText = var_2_10000

		local var_8_0 = var_2_10000(arg_5_0.yostarEmailTxt)

		getInputText = var_2_10001

		local var_8_1 = var_2_10001(arg_5_0.yostarCodeTxt)
		local var_8_3

		if var_8_0 ~= "" and var_8_1 ~= "" then
			if arg_5_0.contextData.isLinkMode == true then
				pg = var_8_3

				local var_8_2 = var_8_3.SdkMgr.GetInstance()

				var_8_3 = var_8_3.LinkSocial
				AIRI_PLATFORM_YOSTAR = var_2_10005

				var_8_3(var_8_2, var_2_10005, var_8_0, var_8_1)
			else
				pg = var_8_3

				local var_8_4 = var_8_3.SdkMgr.GetInstance()

				var_8_3 = var_8_3.LoginWithSocial
				AIRI_PLATFORM_YOSTAR = var_2_10005

				var_8_3(var_8_4, var_2_10005, var_8_0, var_8_1)
			end
		else
			pg = var_8_3

			local var_8_5 = var_8_3.TipsMgr.GetInstance()
			local var_8_6 = var_2.ShowTips

			i18n = var_2_10005

			var_8_6(var_8_5, var_2_10005("verification_code_req_tip3"))
		end

		return
	end)
	arg_5_0:CheckAiriGenCodeCounter()

	return
end

function var_0_1.CheckAiriGenCodeCounter(arg_9_0)
	GetAiriGenCodeTimeRemain = var_1_10001

	if var_1_10001() > 0 then
		setButtonEnabled = var_1

		var_1(arg_9_0.yostarGenCodeBtn, false)

		Timer = var_1
		arg_9_0.genCodeTimer = var_1.New(function()
			GetAiriGenCodeTimeRemain = var_2_10000

			local var_10_0 = var_2_10000()

			if 0 < var_10_0 then
				setText = var_1

				var_1(arg_9_0.yostarGenTxt, "(" .. var_10_0 .. ")")
			else
				setText = var_1

				local var_10_1 = arg_9_0.yostarGenTxt

				i18n = var_2_10004

				var_1(var_10_1, var_2_10004("genBtn_text"))

				local var_10_2 = arg_9_0

				var_1.ClearAiriGenCodeTimer(var_10_2)
			end

			return
		end, 1, -1)

		local var_9_0 = arg_9_0.genCodeTimer

		var_1.Start(var_9_0)
	end

	return
end

function var_0_1.ClearAiriGenCodeTimer(arg_11_0)
	setButtonEnabled = var_1_10001

	var_1_10001(arg_11_0.yostarGenCodeBtn, true)

	if arg_11_0.genCodeTimer then
		local var_11_0 = arg_11_0.genCodeTimer

		var_1.Stop(var_11_0)

		arg_11_0.genCodeTimer = nil
	end

	return
end

function var_0_1.OnDestroy(arg_12_0)
	arg_12_0:ClearAiriGenCodeTimer()

	return
end

return var_0_1
