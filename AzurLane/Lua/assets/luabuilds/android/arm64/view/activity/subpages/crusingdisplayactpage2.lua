local var_0_0 = class("CrusingDisplayActPage2", import("view.base.BaseActivityPage"))

function var_0_0.OnInit(arg_1_0)
	arg_1_0.bgBase = arg_1_0._tf:Find("bg_base")
	arg_1_0.bgPay = arg_1_0._tf:Find("bg_pay")
	arg_1_0.btnGo = arg_1_0._tf:Find("AD/btn_go")

	setText(arg_1_0.btnGo:Find("Text"), i18n("cruise_tip_skin"))
	onButton(arg_1_0, arg_1_0.btnGo, function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CRUSING)

		return
	end, SFX_CONFIRM)

	arg_1_0.btnPay = arg_1_0._tf:Find("AD/btn_pay")

	setText(arg_1_0.btnPay:Find("Text"), i18n("cruise_btn_pay"))
	onButton(arg_1_0, arg_1_0.btnPay, function()
		arg_1_0:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.CHARGE, {
			warp = ChargeScene.TYPE_PICK
		})

		return
	end, SFX_CONFIRM)

	local var_1_0 = arg_1_0._tf:Find("AD/info_panel")

	arg_1_0.toggleBase = var_1_0:Find("toggle_base")

	setText(arg_1_0.toggleBase:Find("Text"), i18n("cruise_tip_base"))
	onToggle(arg_1_0, arg_1_0.toggleBase, function(arg_4_0)
		setTextAlpha(arg_1_0.toggleBase:Find("Text"), arg_4_0 and 1 or 0.3)

		if arg_1_0.LTBase then
			LeanTween.cancel(arg_1_0.LTBase)
		end

		arg_1_0.LTBase = LeanTween.alpha(arg_1_0.bgBase, arg_4_0 and 1 or 0, 0.5).uniqueId

		return
	end, SFX_PANEL)

	arg_1_0.togglePay = var_1_0:Find("toggle_pay")

	setText(arg_1_0.togglePay:Find("Text"), i18n("cruise_tip_upgrade"))
	onToggle(arg_1_0, arg_1_0.togglePay, function(arg_5_0)
		setTextAlpha(arg_1_0.togglePay:Find("Text"), arg_5_0 and 1 or 0.3)

		if arg_1_0.LTPay then
			LeanTween.cancel(arg_1_0.LTPay)
		end

		arg_1_0.LTPay = LeanTween.alpha(arg_1_0.bgPay, arg_5_0 and 1 or 0, 0.5).uniqueId

		return
	end, SFX_PANEL)

	arg_1_0.textPay = var_1_0:Find("text_pay")

	return
end

function var_0_0.OnDataSetting(arg_6_0)
	arg_6_0.isPay = arg_6_0.activity.data2 == 1

	return
end

function var_0_0.OnUpdateFlush(arg_7_0)
	setActive(arg_7_0.textPay:Find("before"), not arg_7_0.isPay)
	setActive(arg_7_0.textPay:Find("after"), arg_7_0.isPay)
	setActive(arg_7_0.btnPay, not arg_7_0.isPay)
	setActive(arg_7_0.btnGo:Find("tip"), #arg_7_0.activity:GetCrusingUnreceiveAward() > 0)

	if arg_7_0.isPay then
		triggerToggle(arg_7_0.togglePay, true)
	else
		triggerToggle(arg_7_0.toggleBase, true)

		if PlayerPrefs.GetInt("first_crusing_page_display:" .. arg_7_0.activity.id, 0) == 0 then
			PlayerPrefs.SetInt("first_crusing_page_display:" .. arg_7_0.activity.id, 1)

			arg_7_0.LTFirst = LeanTween.delayedCall(3, System.Action(function()
				triggerToggle(arg_7_0.togglePay, true)

				arg_7_0.LTFirst = LeanTween.delayedCall(3, System.Action(function()
					triggerToggle(arg_7_0.toggleBase, true)

					return
				end)).uniqueId

				return
			end)).uniqueId
		end
	end

	return
end

function var_0_0.OnHideFlush(arg_10_0)
	if arg_10_0.LTFirst then
		LeanTween.cancel(arg_10_0.LTFirst)

		arg_10_0.LTFirst = nil
	end

	return
end

function var_0_0.OnDestroy(arg_11_0)
	if arg_11_0.LTFirst then
		LeanTween.cancel(arg_11_0.LTFirst)

		arg_11_0.LTFirst = nil
	end

	if arg_11_0.LTBase then
		LeanTween.cancel(arg_11_0.LTBase)

		arg_11_0.LTBase = nil
	end

	if arg_11_0.LTPay then
		LeanTween.cancel(arg_11_0.LTPay)

		arg_11_0.LTPay = nil
	end

	return
end

return var_0_0
