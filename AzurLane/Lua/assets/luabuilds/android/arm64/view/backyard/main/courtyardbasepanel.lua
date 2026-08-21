local var_0_0 = class("CourtYardBasePanel", import("...base.BasePanel"))
local var_0_1 = 0.5
local var_0_2 = 0
local var_0_3 = 1

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.state = var_0_2

	local var_1_0 = arg_1_1._tf:Find((arg_1_0:GetUIName()))

	arg_1_0._go = var_1_0.gameObject
	arg_1_0._tf = var_1_0
	arg_1_0.contextData = arg_1_1.contextData

	arg_1_0:Attach(arg_1_1)

	return
end

function var_0_0.Attach(arg_2_0, arg_2_1)
	var_0_0.super.attach(arg_2_0, arg_2_1)
	arg_2_0:init()
	arg_2_0:Active()

	arg_2_0.state = var_0_3

	return
end

function var_0_0.Active(arg_3_0)
	if arg_3_0:IsVisit() then
		arg_3_0:OnVisitRegister()
	else
		arg_3_0:OnRegister()
	end

	return
end

function var_0_0.Detach(arg_4_0)
	if arg_4_0.state == var_0_3 then
		arg_4_0.state = var_0_2

		var_0_0.super.detach(arg_4_0)
	end

	arg_4_0:OnDispose()

	return
end

function var_0_0.Fold(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:GetMoveX()
	local var_5_1 = arg_5_0:GetMoveY()

	if _.any(var_5_1, function(arg_6_0)
		return LeanTween.isTweening(go(arg_6_0[1]))
	end) or _.any(var_5_0, function(arg_7_0)
		return LeanTween.isTweening(go(arg_7_0[1]))
	end) then
		return
	end

	_.each(var_5_0, function(arg_8_0)
		local var_8_0 = 0

		if arg_5_1 then
			var_8_0 = arg_8_0[1].anchoredPosition3D.x + arg_8_0[1].rect.width * arg_8_0[2]
		end

		arg_5_0:Tween("moveX", arg_5_1, arg_8_0[1], var_8_0)

		return
	end)
	_.each(var_5_1, function(arg_9_0)
		local var_9_0 = 0

		if arg_5_1 then
			var_9_0 = arg_9_0[1].anchoredPosition3D.y + arg_9_0[1].rect.height * arg_9_0[2]
		end

		arg_5_0:Tween("moveY", arg_5_1, arg_9_0[1], var_9_0)

		return
	end)

	return
end

function var_0_0.Flush(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.state == var_0_3 then
		arg_10_0.dorm = arg_10_1

		if arg_10_0:IsVisit() then
			arg_10_0:OnVisitFlush()
		else
			arg_10_0:OnFlush(arg_10_2)
		end
	end

	return
end

function var_0_0.GetMoveX(arg_11_0)
	return {}
end

function var_0_0.GetMoveY(arg_12_0)
	return {}
end

function var_0_0.Tween(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	LeanTween[arg_13_1](arg_13_3, arg_13_4, var_0_1):setOnComplete(System.Action(function()
		if arg_13_2 then
			setActive(arg_13_3, false)
		end

		return
	end)):setOnStart(System.Action(function()
		if not arg_13_2 then
			setActive(arg_13_3, true)
		end

		return
	end))

	return
end

function var_0_0.IsInner(arg_16_0)
	local var_16_0 = arg_16_0.contextData.floor

	return arg_16_0.contextData.floor == 1 or var_16_0 == 2
end

function var_0_0.OnEnterOrExitEdit(arg_17_0, arg_17_1)
	if arg_17_1 then
		arg_17_0:OnEnterEditMode()
	else
		arg_17_0:OnExitEditMode()
	end

	return
end

function var_0_0.IsVisit(arg_18_0)
	return arg_18_0.contextData.mode == CourtYardConst.SYSTEM_VISIT
end

function var_0_0.OnEnterEditMode(arg_19_0)
	setActive(arg_19_0._tf, false)

	return
end

function var_0_0.OnExitEditMode(arg_20_0)
	setActive(arg_20_0._tf, true)

	return
end

function var_0_0.GetUIName(arg_21_0)
	assert(false)

	return
end

function var_0_0.OnRegister(arg_22_0)
	return
end

function var_0_0.OnVisitRegister(arg_23_0)
	return
end

function var_0_0.OnDispose(arg_24_0)
	return
end

function var_0_0.OnVisitFlush(arg_25_0)
	return
end

function var_0_0.OnFlush(arg_26_0, arg_26_1)
	return
end

function var_0_0.OnRemoveLayer(arg_27_0, arg_27_1)
	return
end

function var_0_0.onBackPressed(arg_28_0)
	return false
end

function var_0_0.UpdateFloor(arg_29_0)
	return
end

function var_0_0.SetActive(arg_30_0, arg_30_1, arg_30_2)
	setActiveViaLayer(arg_30_1, arg_30_2)

	return
end

return var_0_0
