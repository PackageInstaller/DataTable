class = var_0_10000

local var_0_0 = "Dorm3dDancePhotoWindow"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..Dorm3dGameBaseSubView"))

function var_0_1.Init(arg_1_0)
	arg_1_0.parentTf = arg_1_0._tf.parent

	local var_1_0 = arg_1_0._tf

	arg_1_0.imageTf = var_1.Find(var_1_0, "border/mask/image")

	local var_1_1 = arg_1_0._tf

	arg_1_0.maskTf = var_1.Find(var_1_1, "border/mask")

	local var_1_2 = arg_1_0._tf

	arg_1_0.frameTf = var_1.Find(var_1_2, "border")
	onButton = var_1

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_4.Find(var_1_4, "btn_save")

	local function var_1_6()
		arg_1_0.contextData.onSaveImage(arg_1_0.frameTf)

		return
	end

	SFX_DORM_CLICK = var_1_4

	var_1(var_1_3, var_1_5, var_1_6, var_1_4)

	onButton = var_1

	local var_1_7 = arg_1_0
	local var_1_8 = arg_1_0._tf

	local function var_1_9()
		local var_3_0 = arg_1_0

		var_0.CloseWindow(var_3_0)

		return
	end

	SFX_DORM_CLICK = var_1_4

	var_1(var_1_7, var_1_8, var_1_9, var_1_4)

	return
end

function var_0_1.Flush(arg_4_0, arg_4_1, arg_4_2)
	pg = var_1_10003

	local var_4_0 = var_1_10003.UIMgr.GetInstance()

	var_3.BlurPanel(var_4_0, arg_4_0._tf)
	arg_4_0.contextData.onShowRealImage(arg_4_1, arg_4_0.imageTf, arg_4_0.maskTf)

	setActive = var_3

	local var_4_1 = arg_4_0._tf

	var_3(var_5.Find(var_4_1, "btn_save"), not arg_4_2)

	if arg_4_2 then
		LeanTween = var_3

		local var_4_2 = var_3.delayedCall
		local var_4_3 = 1

		System = var_6
		arg_4_0.tId = var_4_2(var_4_3, var_6.Action(function()
			local var_5_0 = arg_4_0

			var_0.CloseWindow(var_5_0)

			return
		end)).uniqueId
	end

	return
end

function var_0_1.CloseWindow(arg_6_0)
	if arg_6_0.tId then
		LeanTween = var_1

		var_1.cancel(arg_6_0.tId)

		arg_6_0.tId = nil
	end

	pg = var_1

	local var_6_0 = var_1.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_6_0, arg_6_0._tf, arg_6_0.parentTf)
	arg_6_0:Hide()
	arg_6_0.contextData.onHide()

	return
end

function var_0_1.Dispose(arg_7_0)
	isActive = var_1_10001

	if var_1_10001(arg_7_0._tf) then
		arg_7_0:CloseWindow()
	end

	return
end

return var_0_1
