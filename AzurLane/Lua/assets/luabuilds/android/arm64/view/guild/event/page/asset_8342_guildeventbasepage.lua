class = var_0_10000

local var_0_0 = "GuildEventBasePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("....base.BaseSubView"))

function var_0_1.Show(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:UpdateData(arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Show(arg_1_0)

	assert = var_4

	var_4(arg_1_0._tf)

	pg = var_4

	local var_1_0 = var_4.UIMgr.GetInstance()

	var_4.BlurPanel(var_1_0, arg_1_0._tf)
	arg_1_0:OnShow()

	arg_1_0.inAnim = true

	arg_1_0:EnterAnim(function()
		arg_1_0.inAnim = false

		return
	end)

	return
end

function var_0_1.SetHideCallBack(arg_3_0, arg_3_1)
	arg_3_0.exitCallback = arg_3_1

	return
end

function var_0_1.UpdateData(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.guild = arg_4_1
	arg_4_0.player = arg_4_2
	arg_4_0.extraData = arg_4_3

	return
end

function var_0_1.Hide(arg_5_0, arg_5_1)
	local function var_5_0()
		arg_5_0.inAnim = false

		var_0_1.super.Hide(arg_5_0)

		assert = var_0

		var_0(arg_5_0._tf)

		assert = var_0

		var_0(arg_5_0._parentTf)

		pg = var_0

		local var_6_0 = var_0.UIMgr.GetInstance()

		var_0.UnOverlayPanel(var_6_0, arg_5_0._tf, arg_5_0._parentTf)

		if not arg_5_1 and arg_5_0.exitCallback then
			arg_5_0.exitCallback()
		end

		return
	end

	if not arg_5_1 then
		arg_5_0.inAnim = true

		arg_5_0:ExistAnim(var_5_0)
	else
		var_5_0()
	end

	return
end

function var_0_1.OnDestroy(arg_7_0)
	arg_7_0:Hide(true)

	return
end

function var_0_1.emit(arg_8_0, ...)
	if arg_8_0.inAnim then
		return
	end

	var_0_1.super.emit(arg_8_0, ...)

	return
end

function var_0_1.EnterAnim(arg_9_0, arg_9_1)
	arg_9_1()

	return
end

function var_0_1.ExistAnim(arg_10_0, arg_10_1)
	arg_10_1()

	return
end

function var_0_1.OnShow(arg_11_0)
	return
end

return var_0_1
