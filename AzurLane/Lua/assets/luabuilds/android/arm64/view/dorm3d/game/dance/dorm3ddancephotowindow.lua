local var_0_0 = class("Dorm3dDancePhotoWindow", import("..Dorm3dGameBaseSubView"))

function var_0_0.Init(arg_1_0)
	arg_1_0.parentTf = arg_1_0._tf.parent
	arg_1_0.imageTf = arg_1_0._tf:Find("border/mask/image")
	arg_1_0.maskTf = arg_1_0._tf:Find("border/mask")
	arg_1_0.frameTf = arg_1_0._tf:Find("border")

	onButton(arg_1_0, arg_1_0._tf:Find("btn_save"), function()
		arg_1_0.contextData.onSaveImage(arg_1_0.frameTf)

		return
	end, SFX_DORM_CLICK)
	onButton(arg_1_0, arg_1_0._tf, function()
		arg_1_0:CloseWindow()

		return
	end, SFX_DORM_CLICK)

	return
end

function var_0_0.Flush(arg_4_0, arg_4_1, arg_4_2)
	pg.UIMgr.GetInstance():BlurPanel(arg_4_0._tf)
	arg_4_0.contextData.onShowRealImage(arg_4_1, arg_4_0.imageTf, arg_4_0.maskTf)
	setActive(arg_4_0._tf:Find("btn_save"), not arg_4_2)

	if arg_4_2 then
		arg_4_0.tId = LeanTween.delayedCall(1, System.Action(function()
			arg_4_0:CloseWindow()

			return
		end)).uniqueId
	end

	return
end

function var_0_0.CloseWindow(arg_6_0)
	if arg_6_0.tId then
		LeanTween.cancel(arg_6_0.tId)

		arg_6_0.tId = nil
	end

	pg.UIMgr.GetInstance():UnOverlayPanel(arg_6_0._tf, arg_6_0.parentTf)
	arg_6_0:Hide()
	arg_6_0.contextData.onHide()

	return
end

function var_0_0.Dispose(arg_7_0)
	if isActive(arg_7_0._tf) then
		arg_7_0:CloseWindow()
	end

	return
end

return var_0_0
