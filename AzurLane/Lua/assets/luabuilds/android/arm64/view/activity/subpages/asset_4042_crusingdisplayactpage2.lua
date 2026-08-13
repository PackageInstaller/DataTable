class = var_0_10000

local var_0_0 = "CrusingDisplayActPage2"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bgBase = var_1.Find(var_1_0, "bg_base")

	local var_1_1 = arg_1_0._tf

	arg_1_0.bgPay = var_1.Find(var_1_1, "bg_pay")

	local var_1_2 = arg_1_0._tf

	arg_1_0.btnGo = var_1.Find(var_1_2, "AD/btn_go")
	setText = var_1

	local var_1_3 = arg_1_0.btnGo
	local var_1_4 = var_3.Find(var_1_3, "Text")

	i18n = var_4

	var_1(var_1_4, var_4("cruise_tip_skin"))

	onButton = var_1

	local var_1_5 = arg_1_0
	local var_1_6 = arg_1_0.btnGo

	local function var_1_7()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_2_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_2_1(var_2_0, var_2_2, var_2_10004.CRUSING)

		return
	end

	SFX_CONFIRM = var_6

	var_1(var_1_5, var_1_6, var_1_7, var_6)

	local var_1_8 = arg_1_0._tf

	arg_1_0.btnPay = var_1.Find(var_1_8, "AD/btn_pay")
	setText = var_1

	local var_1_9 = arg_1_0.btnPay
	local var_1_10 = var_3.Find(var_1_9, "Text")

	i18n = var_4

	var_1(var_1_10, var_4("cruise_btn_pay"))

	onButton = var_1

	local var_1_11 = arg_1_0
	local var_1_12 = arg_1_0.btnPay

	local function var_1_13()
		local var_3_0 = arg_1_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_3_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_3_3 = var_2_10004.CHARGE
		local var_3_4 = {}

		ChargeScene = var_2_10006
		var_3_4.warp = var_2_10006.TYPE_PICK

		var_3_1(var_3_0, var_3_2, var_3_3, var_3_4)

		return
	end

	SFX_CONFIRM = var_6

	var_1(var_1_11, var_1_12, var_1_13, var_6)

	local var_1_14 = arg_1_0._tf
	local var_1_15 = var_1.Find(var_1_14, "AD/info_panel")

	arg_1_0.toggleBase = var_1.Find(var_1_15, "toggle_base")
	setText = var_2

	local var_1_16 = arg_1_0.toggleBase
	local var_1_17 = var_4.Find(var_1_16, "Text")

	i18n = var_5

	var_2(var_1_17, var_5("cruise_tip_base"))

	onToggle = var_2

	local var_1_18 = arg_1_0
	local var_1_19 = arg_1_0.toggleBase

	local function var_1_20(arg_4_0)
		setTextAlpha = var_2_10001

		local var_4_0 = arg_1_0.toggleBase

		var_2_10001(var_3.Find(var_4_0, "Text"), arg_4_0 and 1 or 0.3)

		if arg_1_0.LTBase then
			LeanTween = var_1

			var_1.cancel(arg_1_0.LTBase)
		end

		local var_4_1 = arg_1_0

		LeanTween = var_2_10002
		var_4_1.LTBase = var_2_10002.alpha(arg_1_0.bgBase, arg_4_0 and 1 or 0, 0.5).uniqueId

		return
	end

	SFX_PANEL = var_7

	var_2(var_1_18, var_1_19, var_1_20, var_7)

	arg_1_0.togglePay = var_1:Find("toggle_pay")
	setText = var_2

	local var_1_21 = arg_1_0.togglePay
	local var_1_22 = var_4.Find(var_1_21, "Text")

	i18n = var_5

	var_2(var_1_22, var_5("cruise_tip_upgrade"))

	onToggle = var_2

	local var_1_23 = arg_1_0
	local var_1_24 = arg_1_0.togglePay

	local function var_1_25(arg_5_0)
		setTextAlpha = var_2_10001

		local var_5_0 = arg_1_0.togglePay

		var_2_10001(var_3.Find(var_5_0, "Text"), arg_5_0 and 1 or 0.3)

		if arg_1_0.LTPay then
			LeanTween = var_1

			var_1.cancel(arg_1_0.LTPay)
		end

		local var_5_1 = arg_1_0

		LeanTween = var_2_10002
		var_5_1.LTPay = var_2_10002.alpha(arg_1_0.bgPay, arg_5_0 and 1 or 0, 0.5).uniqueId

		return
	end

	SFX_PANEL = var_7

	var_2(var_1_23, var_1_24, var_1_25, var_7)

	arg_1_0.textPay = var_1:Find("text_pay")

	return
end

function var_0_1.OnDataSetting(arg_6_0)
	arg_6_0.isPay = arg_6_0.activity.data2 == 1

	return
end

function var_0_1.OnUpdateFlush(arg_7_0)
	setActive = var_1_10001

	local var_7_0 = arg_7_0.textPay

	var_1_10001(var_3.Find(var_7_0, "before"), not arg_7_0.isPay)

	setActive = var_1_10001

	local var_7_1 = arg_7_0.textPay

	var_1_10001(var_3.Find(var_7_1, "after"), arg_7_0.isPay)

	setActive = var_1_10001

	var_1_10001(arg_7_0.btnPay, not arg_7_0.isPay)

	setActive = var_1_10001

	local var_7_2 = arg_7_0.btnGo
	local var_7_3 = var_3.Find(var_7_2, "tip")
	local var_7_4 = arg_7_0.activity

	var_1_10001(var_7_3, #var_4.GetCrusingUnreceiveAward(var_7_4) > 0)

	if arg_7_0.isPay then
		triggerToggle = var_1

		var_1(arg_7_0.togglePay, true)
	else
		triggerToggle = var_1

		var_1(arg_7_0.toggleBase, true)

		PlayerPrefs = var_1

		if var_1.GetInt("first_crusing_page_display:" .. arg_7_0.activity.id, 0) == 0 then
			PlayerPrefs = var_1

			var_1.SetInt("first_crusing_page_display:" .. arg_7_0.activity.id, 1)

			LeanTween = var_1

			local var_7_5 = var_1.delayedCall
			local var_7_6 = 3

			System = var_4
			arg_7_0.LTFirst = var_7_5(var_7_6, var_4.Action(function()
				triggerToggle = var_2_10000

				var_2_10000(arg_7_0.togglePay, true)

				local var_8_0 = arg_7_0

				LeanTween = var_2_10001

				local var_8_1 = var_2_10001.delayedCall
				local var_8_2 = 3

				System = var_2_10004
				var_8_0.LTFirst = var_8_1(var_8_2, var_2_10004.Action(function()
					triggerToggle = var_3_10000

					var_3_10000(arg_7_0.toggleBase, true)

					return
				end)).uniqueId

				return
			end)).uniqueId
		end
	end

	return
end

function var_0_1.OnHideFlush(arg_10_0)
	if arg_10_0.LTFirst then
		LeanTween = var_1

		var_1.cancel(arg_10_0.LTFirst)

		arg_10_0.LTFirst = nil
	end

	return
end

function var_0_1.OnDestroy(arg_11_0)
	if arg_11_0.LTFirst then
		LeanTween = var_1

		var_1.cancel(arg_11_0.LTFirst)

		arg_11_0.LTFirst = nil
	end

	if arg_11_0.LTBase then
		LeanTween = var_1

		var_1.cancel(arg_11_0.LTBase)

		arg_11_0.LTBase = nil
	end

	if arg_11_0.LTPay then
		LeanTween = var_1

		var_1.cancel(arg_11_0.LTPay)

		arg_11_0.LTPay = nil
	end

	return
end

return var_0_1
