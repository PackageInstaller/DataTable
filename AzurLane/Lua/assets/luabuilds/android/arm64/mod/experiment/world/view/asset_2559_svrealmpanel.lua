class = var_0_10000

local var_0_0 = "SVRealmPanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "SVRealmPanel"
end

function var_0_1.OnLoaded(arg_2_0)
	return
end

function var_0_1.OnInit(arg_3_0)
	local var_3_0 = arg_3_0._tf
	local var_3_1 = var_1.Find(var_3_0, "panel")

	arg_3_0.btnBLHX = var_2.Find(var_3_1, "blhx")
	arg_3_0.btnCSZZ = var_2:Find("cszz")
	setActive = var_3

	var_3(arg_3_0.btnBLHX, true)

	setActive = var_3

	var_3(arg_3_0.btnCSZZ, true)

	onButton = var_3

	local var_3_2 = arg_3_0
	local var_3_3 = arg_3_0.btnBLHX

	local function var_3_4()
		local var_4_0 = arg_3_0

		var_0.PlayAnim(var_4_0, arg_3_0.btnBLHX, function()
			local var_5_0 = arg_3_0

			var_0.Hide(var_5_0)
			arg_3_0.onConfirm(1)

			return
		end)

		return
	end

	SFX_PANEL = var_1_10008

	var_3(var_3_2, var_3_3, var_3_4, var_1_10008)

	onButton = var_3

	var_3(arg_3_0, arg_3_0.btnCSZZ, function()
		local var_6_0 = arg_3_0

		var_0.PlayAnim(var_6_0, arg_3_0.btnCSZZ, function()
			local var_7_0 = arg_3_0

			var_0.Hide(var_7_0)
			arg_3_0.onConfirm(2)

			return
		end)

		return
	end)

	return
end

function var_0_1.OnDestroy(arg_8_0)
	return
end

function var_0_1.Show(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.UIMgr.GetInstance()

	var_1.OverlayPanel(var_9_0, arg_9_0._tf)

	setActive = var_1

	var_1(arg_9_0._tf, true)

	return
end

function var_0_1.Hide(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_10_0, arg_10_0._tf, arg_10_0._parentTf)

	setActive = var_1

	var_1(arg_10_0._tf, false)

	return
end

function var_0_1.Setup(arg_11_0, arg_11_1)
	arg_11_0.onConfirm = arg_11_1

	return
end

function var_0_1.PlayAnim(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_1:Find("bg")

	setActive = var_1_10004

	var_1_10004(var_12_0, true)

	LeanTween = var_1_10004

	local var_12_1 = var_1_10004.value

	go = var_6

	local var_12_2 = var_12_1(var_6(var_12_0), 1, 1.2, 0.2)
	local var_12_3 = var_4.setOnUpdate

	System = var_7

	local var_12_4 = var_12_3(var_12_2, var_7.Action_float(function(arg_13_0)
		local var_13_0 = var_12_0

		Vector3 = var_2_10002
		var_13_0.localScale = var_2_10002(arg_13_0, arg_13_0, 1)

		return
	end))
	local var_12_5 = var_4.setOnComplete

	System = var_7

	var_12_5(var_12_4, var_7.Action(function()
		setActive = var_2_10000

		var_2_10000(var_12_0, false)

		local var_14_0 = var_12_0

		Vector3 = var_2_10001
		var_14_0.localScale = var_2_10001(1, 1, 1)

		arg_12_2()

		return
	end))

	LeanTween = var_12_5

	local var_12_6 = var_12_5.value

	go = var_12_4

	var_12_6(var_12_4(var_12_0), 1, 0.7, 0.2)

	return
end

return var_0_1
