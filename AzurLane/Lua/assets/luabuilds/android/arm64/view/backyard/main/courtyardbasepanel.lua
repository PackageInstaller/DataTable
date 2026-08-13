class = var_0_10000

local var_0_0 = "CourtYardBasePanel"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.BasePanel"))
local var_0_2 = 0.5
local var_0_3 = 0
local var_0_4 = 1

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.state = var_0_3

	local var_1_0 = arg_1_0:GetUIName()
	local var_1_1 = arg_1_1._tf

	arg_1_0._go = var_3.Find(var_1_1, var_1_0).gameObject
	arg_1_0._tf = var_3
	arg_1_0.contextData = arg_1_1.contextData

	arg_1_0:Attach(arg_1_1)

	return
end

function var_0_1.Attach(arg_2_0, arg_2_1)
	var_0_1.super.attach(arg_2_0, arg_2_1)
	arg_2_0:init()
	arg_2_0:Active()

	arg_2_0.state = var_0_4

	return
end

function var_0_1.Active(arg_3_0)
	if arg_3_0:IsVisit() then
		arg_3_0:OnVisitRegister()
	else
		arg_3_0:OnRegister()
	end

	return
end

function var_0_1.Detach(arg_4_0)
	if arg_4_0.state == var_0_4 then
		arg_4_0.state = var_0_3

		var_0_1.super.detach(arg_4_0)
	end

	arg_4_0:OnDispose()

	return
end

function var_0_1.Fold(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.GetMoveX(var_5_0)
	local var_5_2 = arg_5_0:GetMoveY()

	_ = var_5_0

	if not var_5_0.any(var_5_2, function(arg_6_0)
		LeanTween = var_2_10001

		local var_6_0 = var_2_10001.isTweening

		go = var_2_10003

		return var_6_0(var_2_10003(arg_6_0[1]))
	end) then
		_ = var_4

		if var_4.any(var_5_1, function(arg_7_0)
			LeanTween = var_2_10001

			local var_7_0 = var_2_10001.isTweening

			go = var_2_10003

			return var_7_0(var_2_10003(arg_7_0[1]))
		end) then
			return
		end

		_ = var_4

		var_4.each(var_5_1, function(arg_8_0)
			local var_8_0 = 0

			if arg_5_1 then
				var_8_0 = arg_8_0[1].anchoredPosition3D.x + arg_8_0[1].rect.width * arg_8_0[2]
			end

			local var_8_1 = arg_5_0

			var_2.Tween(var_8_1, "moveX", arg_5_1, arg_8_0[1], var_8_0)

			return
		end)

		_ = var_4

		var_4.each(var_5_2, function(arg_9_0)
			local var_9_0 = 0

			if arg_5_1 then
				var_9_0 = arg_9_0[1].anchoredPosition3D.y + arg_9_0[1].rect.height * arg_9_0[2]
			end

			local var_9_1 = arg_5_0

			var_2.Tween(var_9_1, "moveY", arg_5_1, arg_9_0[1], var_9_0)

			return
		end)

		return
	end
end

function var_0_1.Flush(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.state == var_0_4 then
		arg_10_0.dorm = arg_10_1

		if arg_10_0:IsVisit() then
			arg_10_0:OnVisitFlush()
		else
			arg_10_0:OnFlush(arg_10_2)
		end
	end

	return
end

function var_0_1.GetMoveX(arg_11_0)
	return {}
end

function var_0_1.GetMoveY(arg_12_0)
	return {}
end

function var_0_1.Tween(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	LeanTween = var_1_10005

	local var_13_0 = var_1_10005[arg_13_1](arg_13_3, arg_13_4, var_0_2)
	local var_13_1 = var_5.setOnComplete

	System = var_8

	local var_13_2 = var_13_1(var_13_0, var_8.Action(function()
		if arg_13_2 then
			setActive = var_0

			var_0(arg_13_3, false)
		end

		return
	end))
	local var_13_3 = var_5.setOnStart

	System = var_8

	var_13_3(var_13_2, var_8.Action(function()
		if not arg_13_2 then
			setActive = var_0

			var_0(arg_13_3, true)
		end

		return
	end))

	return
end

function var_0_1.IsInner(arg_16_0)
	return arg_16_0.contextData.floor == 1 or var_1 == 2
end

function var_0_1.OnEnterOrExitEdit(arg_17_0, arg_17_1)
	if arg_17_1 then
		arg_17_0:OnEnterEditMode()
	else
		arg_17_0:OnExitEditMode()
	end

	return
end

function var_0_1.IsVisit(arg_18_0)
	local var_18_0 = arg_18_0.contextData.mode

	CourtYardConst = var_1_10002

	return var_18_0 == var_1_10002.SYSTEM_VISIT
end

function var_0_1.OnEnterEditMode(arg_19_0)
	setActive = var_1_10001

	var_1_10001(arg_19_0._tf, false)

	return
end

function var_0_1.OnExitEditMode(arg_20_0)
	setActive = var_1_10001

	var_1_10001(arg_20_0._tf, true)

	return
end

function var_0_1.GetUIName(arg_21_0)
	assert = var_1_10001

	var_1_10001(false)

	return
end

function var_0_1.OnRegister(arg_22_0)
	return
end

function var_0_1.OnVisitRegister(arg_23_0)
	return
end

function var_0_1.OnDispose(arg_24_0)
	return
end

function var_0_1.OnVisitFlush(arg_25_0)
	return
end

function var_0_1.OnFlush(arg_26_0, arg_26_1)
	return
end

function var_0_1.OnRemoveLayer(arg_27_0, arg_27_1)
	return
end

function var_0_1.onBackPressed(arg_28_0)
	return false
end

function var_0_1.UpdateFloor(arg_29_0)
	return
end

function var_0_1.SetActive(arg_30_0, arg_30_1, arg_30_2)
	setActiveViaLayer = var_1_10003

	var_1_10003(arg_30_1, arg_30_2)

	return
end

return var_0_1
