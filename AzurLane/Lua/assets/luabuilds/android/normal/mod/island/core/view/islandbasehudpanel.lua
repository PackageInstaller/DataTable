class = var_0_10000

local var_0_0 = "IslandBaseHudPanel"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseUnit"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.parentTF = arg_1_3
	arg_1_0.data = arg_1_2
	arg_1_0.unitId = arg_1_2.id
	arg_1_0.unitType = arg_1_2.type
	arg_1_0.unitTransform = arg_1_2.unitTransform
	arg_1_0.positionX = arg_1_2.positionX
	arg_1_0.positionY = arg_1_2.positionY
	arg_1_0.param1 = arg_1_2.param1

	return
end

function var_0_1.Init(arg_2_0, ...)
	PoolMgr = var_1_10001

	local var_2_0 = var_1_10001.GetInstance()

	var_1.GetUI(var_2_0, arg_2_0:GetUIName(), true, function(arg_3_0)
		arg_2_0._go = arg_3_0

		local var_3_0 = arg_2_0

		var_3_0._tf = arg_3_0.transform
		setParent = var_3_0

		var_3_0(arg_3_0, arg_2_0.parentTF)
		var_0_1.super.Init(arg_2_0, arg_3_0)

		local var_3_1 = arg_2_0

		var_1.Show(var_3_1)

		local var_3_2 = arg_2_0

		var_1.Refresh(var_3_2, arg_2_0.data)

		return
	end)

	return
end

function var_0_1.GetUIName(arg_4_0)
	assert = var_1_10001

	var_1_10001(false, "overwrite me")

	return
end

function var_0_1.OnInit(arg_5_0)
	return
end

function var_0_1.OnShow(arg_6_0)
	return
end

function var_0_1.Refresh(arg_7_0, arg_7_1)
	return
end

function var_0_1.RefreshHud(arg_8_0)
	return
end

function var_0_1.Show(arg_9_0)
	arg_9_0.active = true

	if not arg_9_0._tf then
		return
	end

	setActive = var_1

	var_1(arg_9_0._tf, true)
	arg_9_0:OnShow()

	return
end

function var_0_1.Hide(arg_10_0)
	if not arg_10_0._tf then
		return
	end

	arg_10_0.active = false
	setActive = var_1

	var_1(arg_10_0._tf, false)

	return
end

function var_0_1.OnDispose(arg_11_0)
	PoolMgr = var_1_10001

	local var_11_0 = var_1_10001.GetInstance()

	var_1.ReturnUI(var_11_0, arg_11_0:GetUIName(), arg_11_0._go)

	return
end

return var_0_1
