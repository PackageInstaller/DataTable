local var_0_0 = class("IslandBaseHudPanel", import(".IslandBaseUnit"))

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

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

function var_0_0.Init(arg_2_0, ...)
	PoolMgr.GetInstance():GetUI(arg_2_0:GetUIName(), true, function(arg_3_0)
		arg_2_0._go = arg_3_0
		arg_2_0._tf = arg_3_0.transform

		setParent(arg_3_0, arg_2_0.parentTF)
		var_0_0.super.Init(arg_2_0, arg_3_0)
		arg_2_0:Show()
		arg_2_0:Refresh(arg_2_0.data)

		return
	end)

	return
end

function var_0_0.GetUIName(arg_4_0)
	assert(false, "overwrite me")

	return
end

function var_0_0.OnInit(arg_5_0)
	return
end

function var_0_0.OnShow(arg_6_0)
	return
end

function var_0_0.Refresh(arg_7_0, arg_7_1)
	return
end

function var_0_0.RefreshHud(arg_8_0)
	return
end

function var_0_0.Show(arg_9_0)
	arg_9_0.active = true

	if not arg_9_0._tf then
		return
	end

	setActive(arg_9_0._tf, true)
	arg_9_0:OnShow()

	return
end

function var_0_0.Hide(arg_10_0)
	if not arg_10_0._tf then
		return
	end

	arg_10_0.active = false

	setActive(arg_10_0._tf, false)

	return
end

function var_0_0.OnDispose(arg_11_0)
	PoolMgr.GetInstance():ReturnUI(arg_11_0:GetUIName(), arg_11_0._go)

	return
end

return var_0_0
