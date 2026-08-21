local var_0_0 = class("CourtYardEmptyFoodPage", import("...base.BaseSubView"))

function var_0_0.getUIName(arg_1_0)
	return "CourtYardEmptyFoodUI"
end

function var_0_0.OnLoaded(arg_2_0)
	arg_2_0.confirmBtn = arg_2_0._tf:Find("frame/ok_btn")
	arg_2_0.cancelBtn = arg_2_0._tf:Find("frame/cancel_btn")

	setButtonText(arg_2_0.confirmBtn, i18n("text_nofood_yes"))
	setButtonText(arg_2_0.cancelBtn, i18n("text_nofood_no"))

	arg_2_0.frame = arg_2_0._tf:Find("frame")

	return
end

function var_0_0.OnInit(arg_3_0)
	onButton(arg_3_0, arg_3_0.confirmBtn, function()
		arg_3_0:emit(CourtYardMediator.GO_GRANARY)
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0.cancelBtn, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)
	onButton(arg_3_0, arg_3_0._tf, function()
		arg_3_0:Hide()

		return
	end, SFX_PANEL)

	return
end

function var_0_0.Flush(arg_7_0)
	arg_7_0:Show()

	return
end

function var_0_0.Show(arg_8_0)
	var_0_0.super.Show(arg_8_0)
	pg.UIMgr.GetInstance():BlurPanel(arg_8_0._tf)
	LeanTween.cancel(go(arg_8_0.frame))

	arg_8_0.frame.localScale = Vector3(0, 0, 0)

	LeanTween.scale(arg_8_0.frame, Vector3(1, 1, 1), 0.3):setEase(LeanTweenType.easeOutBack)

	return
end

function var_0_0.Hide(arg_9_0)
	LeanTween.cancel(go(arg_9_0.frame))
	var_0_0.super.Hide(arg_9_0)
	pg.UIMgr.GetInstance():UnOverlayPanel(arg_9_0._tf, arg_9_0._parentTf)

	return
end

function var_0_0.OnDestroy(arg_10_0)
	arg_10_0:Hide()

	return
end

return var_0_0
