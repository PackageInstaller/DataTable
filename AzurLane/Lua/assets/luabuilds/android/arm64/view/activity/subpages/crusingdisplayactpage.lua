local var_0_0 = class("CrusingDisplayActPage", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bgBase = arg_1_0._tf:Find("bg_base")
	arg_1_0.bgPay = arg_1_0._tf:Find("bg_pay")
	arg_1_0.btnGoBase = arg_1_0._tf:Find("AD/btn_go_base")

	onButton(arg_1_0, arg_1_0.btnGoBase, function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CRUSING)

		return
	end, SFX_CONFIRM)

	arg_1_0.btnGoPay = arg_1_0._tf:Find("AD/btn_go_pay")

	onButton(arg_1_0, arg_1_0.btnGoPay, function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CRUSING)

		return
	end, SFX_CONFIRM)

	local var_1_0 = arg_1_0._tf:Find("AD/info_panel")

	arg_1_0.toggleBase = var_1_0:Find("toggle_base")

	onToggle(arg_1_0, arg_1_0.toggleBase, function(arg_4_0)
		if arg_1_0.LTBase then
			LeanTween.cancel(arg_1_0.LTBase)
		end

		arg_1_0.LTBase = LeanTween.alpha(arg_1_0.bgBase, arg_4_0 and 1 or 0, 0.5).uniqueId

		return
	end, SFX_PANEL)

	arg_1_0.togglePay = var_1_0:Find("toggle_pay")

	onToggle(arg_1_0, arg_1_0.togglePay, function(arg_5_0)
		if arg_1_0.LTPay then
			LeanTween.cancel(arg_1_0.LTPay)
		end

		arg_1_0.LTPay = LeanTween.alpha(arg_1_0.bgPay, arg_5_0 and 1 or 0, 0.5).uniqueId

		return
	end, SFX_PANEL)

	arg_1_0.btnPay = var_1_0:Find("unlock_panel/btn_unlock")

	onButton(arg_1_0, arg_1_0.btnPay, function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
			wrap = ChargeScene.TYPE_PICK
		})

		return
	end, SFX_CONFIRM)

	arg_1_0.markPay = var_1_0:Find("unlock_panel/mark_unlocked")
	arg_1_0.textPay = var_1_0:Find("text_pay")

	return
end

function var_0_0.OnDataSetting(arg_7_0)
	arg_7_0.isPay = arg_7_0.activity.data2 == 1

	return
end

function var_0_0.OnUpdateFlush(arg_8_0)
	setActive(arg_8_0.textPay:Find("before"), not arg_8_0.isPay)
	setActive(arg_8_0.textPay:Find("after"), arg_8_0.isPay)
	setActive(arg_8_0.btnPay, not arg_8_0.isPay)
	setActive(arg_8_0.markPay, arg_8_0.isPay)

	local var_8_0 = #arg_8_0.activity:GetCrusingUnreceiveAward() > 0

	setActive(arg_8_0.btnGoBase:Find("tip"), var_8_0)
	setActive(arg_8_0.btnGoPay:Find("tip"), var_8_0)
	onNextTick(function()
		if arg_8_0.isPay then
			triggerToggle(arg_8_0.togglePay, true)
		else
			triggerToggle(arg_8_0.toggleBase, true)

			if PlayerPrefs.GetInt("first_crusing_page_display:" .. arg_8_0.activity.id, 0) == 0 then
				PlayerPrefs.SetInt("first_crusing_page_display:" .. arg_8_0.activity.id, 1)

				arg_8_0.LTFirst = LeanTween.delayedCall(3, System.Action(function()
					triggerToggle(arg_8_0.togglePay, true)

					arg_8_0.LTFirst = LeanTween.delayedCall(3, System.Action(function()
						triggerToggle(arg_8_0.toggleBase, true)

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

function var_0_0.OnHideFlush(arg_12_0)
	if arg_12_0.LTFirst then
		LeanTween.cancel(arg_12_0.LTFirst)

		arg_12_0.LTFirst = nil
	end

	return
end

function var_0_0.OnDestroy(arg_13_0)
	if arg_13_0.LTFirst then
		LeanTween.cancel(arg_13_0.LTFirst)

		arg_13_0.LTFirst = nil
	end

	if arg_13_0.LTBase then
		LeanTween.cancel(arg_13_0.LTBase)

		arg_13_0.LTBase = nil
	end

	if arg_13_0.LTPay then
		LeanTween.cancel(arg_13_0.LTPay)

		arg_13_0.LTPay = nil
	end

	return
end

return var_0_0
