class = var_0_10000

local var_0_0 = "CrusingDisplayActPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseActivityPage"))

function var_0_1.OnInit(arg_1_0)
	local var_1_0 = arg_1_0._tf

	arg_1_0.bgBase = var_1.Find(var_1_0, "bg_base")

	local var_1_1 = arg_1_0._tf

	arg_1_0.bgPay = var_1.Find(var_1_1, "bg_pay")

	local var_1_2 = arg_1_0._tf

	arg_1_0.btnGoBase = var_1.Find(var_1_2, "AD/btn_go_base")
	onButton = var_1

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.btnGoBase

	local function var_1_5()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_2_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_2_1(var_2_0, var_2_2, var_2_10004.CRUSING)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_1_3, var_1_4, var_1_5, var_1_10006)

	local var_1_6 = arg_1_0._tf

	arg_1_0.btnGoPay = var_1.Find(var_1_6, "AD/btn_go_pay")
	onButton = var_1

	local var_1_7 = arg_1_0
	local var_1_8 = arg_1_0.btnGoPay

	local function var_1_9()
		local var_3_0 = arg_1_0
		local var_3_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_3_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		var_3_1(var_3_0, var_3_2, var_2_10004.CRUSING)

		return
	end

	SFX_CONFIRM = var_1_10006

	var_1(var_1_7, var_1_8, var_1_9, var_1_10006)

	local var_1_10 = arg_1_0._tf
	local var_1_11 = var_1.Find(var_1_10, "AD/info_panel")

	arg_1_0.toggleBase = var_1.Find(var_1_11, "toggle_base")
	onToggle = var_2

	local var_1_12 = arg_1_0
	local var_1_13 = arg_1_0.toggleBase

	local function var_1_14(arg_4_0)
		if arg_1_0.LTBase then
			LeanTween = var_1

			var_1.cancel(arg_1_0.LTBase)
		end

		local var_4_0 = arg_1_0

		LeanTween = var_2_10002
		var_4_0.LTBase = var_2_10002.alpha(arg_1_0.bgBase, arg_4_0 and 1 or 0, 0.5).uniqueId

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_1_12, var_1_13, var_1_14, var_1_10007)

	arg_1_0.togglePay = var_1:Find("toggle_pay")
	onToggle = var_2

	local var_1_15 = arg_1_0
	local var_1_16 = arg_1_0.togglePay

	local function var_1_17(arg_5_0)
		if arg_1_0.LTPay then
			LeanTween = var_1

			var_1.cancel(arg_1_0.LTPay)
		end

		local var_5_0 = arg_1_0

		LeanTween = var_2_10002
		var_5_0.LTPay = var_2_10002.alpha(arg_1_0.bgPay, arg_5_0 and 1 or 0, 0.5).uniqueId

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_1_15, var_1_16, var_1_17, var_1_10007)

	arg_1_0.btnPay = var_1:Find("unlock_panel/btn_unlock")
	onButton = var_2

	local var_1_18 = arg_1_0
	local var_1_19 = arg_1_0.btnPay

	local function var_1_20()
		local var_6_0 = arg_1_0
		local var_6_1 = var_0.emit

		ActivityMediator = var_2_10003

		local var_6_2 = var_2_10003.EVENT_GO_SCENE

		SCENE = var_2_10004

		local var_6_3 = var_2_10004.CHARGE
		local var_6_4 = {}

		ChargeScene = var_2_10006
		var_6_4.wrap = var_2_10006.TYPE_PICK

		var_6_1(var_6_0, var_6_2, var_6_3, var_6_4)

		return
	end

	SFX_CONFIRM = var_1_10007

	var_2(var_1_18, var_1_19, var_1_20, var_1_10007)

	arg_1_0.markPay = var_1:Find("unlock_panel/mark_unlocked")
	arg_1_0.textPay = var_1:Find("text_pay")

	return
end

function var_0_1.OnDataSetting(arg_7_0)
	arg_7_0.isPay = arg_7_0.activity.data2 == 1

	return
end

function var_0_1.OnUpdateFlush(arg_8_0)
	setActive = var_1_10001

	local var_8_0 = arg_8_0.textPay

	var_1_10001(var_3.Find(var_8_0, "before"), not arg_8_0.isPay)

	setActive = var_1_10001

	local var_8_1 = arg_8_0.textPay

	var_1_10001(var_3.Find(var_8_1, "after"), arg_8_0.isPay)

	setActive = var_1_10001

	var_1_10001(arg_8_0.btnPay, not arg_8_0.isPay)

	setActive = var_1_10001

	var_1_10001(arg_8_0.markPay, arg_8_0.isPay)

	local var_8_2 = arg_8_0.activity
	local var_8_3 = #var_1.GetCrusingUnreceiveAward(var_8_2)
	local var_8_4 = 0 < var_8_3

	setActive = var_2

	local var_8_5 = arg_8_0.btnGoBase

	var_2(var_4.Find(var_8_5, "tip"), var_8_4)

	setActive = var_2

	local var_8_6 = arg_8_0.btnGoPay

	var_2(var_4.Find(var_8_6, "tip"), var_8_4)

	onNextTick = var_2

	var_2(function()
		if arg_8_0.isPay then
			triggerToggle = var_0

			var_0(arg_8_0.togglePay, true)
		else
			triggerToggle = var_0

			var_0(arg_8_0.toggleBase, true)

			PlayerPrefs = var_0

			if var_0.GetInt("first_crusing_page_display:" .. arg_8_0.activity.id, 0) == 0 then
				PlayerPrefs = var_0

				var_0.SetInt("first_crusing_page_display:" .. arg_8_0.activity.id, 1)

				local var_9_0 = arg_8_0

				LeanTween = var_2_10001

				local var_9_1 = var_2_10001.delayedCall
				local var_9_2 = 3

				System = var_2_10004
				var_9_0.LTFirst = var_9_1(var_9_2, var_2_10004.Action(function()
					triggerToggle = var_3_10000

					var_3_10000(arg_8_0.togglePay, true)

					local var_10_0 = arg_8_0

					LeanTween = var_3_10001

					local var_10_1 = var_3_10001.delayedCall
					local var_10_2 = 3

					System = var_3_10004
					var_10_0.LTFirst = var_10_1(var_10_2, var_3_10004.Action(function()
						triggerToggle = var_4_10000

						var_4_10000(arg_8_0.toggleBase, true)

						return
					end)).uniqueId

					return
				end)).uniqueId
			end
		end

		return
	end)

	return
end

function var_0_1.OnHideFlush(arg_12_0)
	if arg_12_0.LTFirst then
		LeanTween = var_1

		var_1.cancel(arg_12_0.LTFirst)

		arg_12_0.LTFirst = nil
	end

	return
end

function var_0_1.OnDestroy(arg_13_0)
	if arg_13_0.LTFirst then
		LeanTween = var_1

		var_1.cancel(arg_13_0.LTFirst)

		arg_13_0.LTFirst = nil
	end

	if arg_13_0.LTBase then
		LeanTween = var_1

		var_1.cancel(arg_13_0.LTBase)

		arg_13_0.LTBase = nil
	end

	if arg_13_0.LTPay then
		LeanTween = var_1

		var_1.cancel(arg_13_0.LTPay)

		arg_13_0.LTPay = nil
	end

	return
end

return var_0_1
