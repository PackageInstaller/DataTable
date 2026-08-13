class = var_0_10000

local var_0_0 = "CourtYardMoveableFurniture"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".CourtYardFurniture"))
local var_0_2 = 0
local var_0_3 = 1
local var_0_4 = 2
local var_0_5 = 3

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.moveState = var_0_2
	arg_1_0.playPreheatAction = false

	return
end

function var_0_1.IsCar(arg_2_0)
	if arg_2_0.config.spine then
		return arg_2_0.config.spine[1] and var_1[4] ~= nil
	end

	return false
end

function var_0_1.GetAroundPositions(arg_3_0)
	local var_3_0 = var_0_1.super.GetAroundPositions(arg_3_0)
	local var_3_1 = arg_3_0

	if not arg_3_0.IsCar(var_3_1) then
		return var_3_0
	end

	local var_3_2 = arg_3_0.config.spine[1][4]

	type = var_3_1

	if var_3_1(var_3_2) == "table" then
		local var_3_3 = {}

		ipairs = var_4

		for iter_3_0, iter_3_1 in var_4(var_3_0) do
			table = var_1_10009

			if var_1_10009.contains(var_3_2, iter_3_0) then
				table = var_1_10009

				var_1_10009.insert(var_3_3, iter_3_1)
			end
		end

		return var_3_3
	else
		return var_3_0
	end

	return
end

function var_0_1._ChangeState(arg_4_0, arg_4_1)
	var_0_1.super._ChangeState(arg_4_0, arg_4_1)

	CourtYardFurniture = var_2

	if var_2.STATE_TOUCH == arg_4_0.state then
		arg_4_0:ChangeMoveState(var_0_3)
	end

	return
end

function var_0_1.ChangeState(arg_5_0, arg_5_1)
	var_0_1.super.ChangeState(arg_5_0, arg_5_1)

	CourtYardFurniture = var_2

	if var_2.STATE_TOUCH == arg_5_0.state then
		-- block empty
	elseif arg_5_0:IsMoving() then
		arg_5_0:Idle()
	end

	return
end

function var_0_1.IsMoveableSlot(arg_6_0, arg_6_1)
	return arg_6_1.id == 1
end

function var_0_1.IsReadyMove(arg_7_0)
	return arg_7_0.moveState == var_0_3
end

function var_0_1.IsMoving(arg_8_0)
	return arg_8_0.moveState == var_0_4
end

function var_0_1.IsStop(arg_9_0)
	return arg_9_0.moveState == var_0_5
end

function var_0_1.SetPosition(arg_10_0, arg_10_1)
	if arg_10_0.moveState == var_0_4 then
		var_0_1.super.super.SetPosition(arg_10_0, arg_10_1)
	else
		var_0_1.super.SetPosition(arg_10_0, arg_10_1)
	end

	return
end

function var_0_1.GetSpeed(arg_11_0)
	local var_11_0 = 1

	if arg_11_0.config.spine and arg_11_0.config.spine[7] then
		var_11_0 = arg_11_0.config.spine[7]
	end

	return var_11_0
end

function var_0_1.GetMoveTime(arg_12_0)
	return 1 / arg_12_0:GetSpeed()
end

function var_0_1.Move(arg_13_0, arg_13_1)
	arg_13_0:RemoveTimer()
	arg_13_0:ChangeMoveState(var_0_4)

	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.GetMoveTime(var_13_0)

	Timer = var_13_0
	arg_13_0.moveTimer = var_13_0.New(function()
		local var_14_0 = arg_13_0

		var_0.ChangeMoveState(var_14_0, var_0_3)

		return
	end, var_13_1, 1)

	local var_13_2 = arg_13_0.moveTimer

	var_3.Start(var_13_2)

	local var_13_3 = arg_13_0
	local var_13_4 = arg_13_0.DispatchEvent

	CourtYardEvent = var_5

	var_13_4(var_13_3, var_5.FURNITURE_MOVE, arg_13_1)

	return
end

function var_0_1.Rest(arg_15_0)
	arg_15_0:RemoveTimer()
	arg_15_0:ChangeMoveState(var_0_2)

	math = var_1

	local var_15_0 = var_1.random(1)

	Timer = var_2

	local var_15_1 = var_2.New

	local function var_15_2()
		local var_16_0 = arg_15_0

		var_0.ChangeMoveState(var_16_0, var_0_3)

		return
	end

	math = var_1_10004
	arg_15_0.moveTimer = var_15_1(var_15_2, var_1_10004.random(10, 20), 1)

	local var_15_3 = arg_15_0.moveTimer

	var_2.Start(var_15_3)

	return
end

function var_0_1.Idle(arg_17_0)
	arg_17_0:RemoveTimer()
	arg_17_0:ChangeMoveState(var_0_2)
	arg_17_0:SetPosition(arg_17_0:GetPosition())

	local var_17_0 = arg_17_0
	local var_17_1 = arg_17_0.DispatchEvent

	CourtYardEvent = var_3

	var_17_1(var_17_0, var_3.FURNITURE_STOP_MOVE)

	return
end

function var_0_1.Stop(arg_18_0)
	arg_18_0:RemoveTimer()
	arg_18_0:ChangeMoveState(var_0_5)
	arg_18_0:SetPosition(arg_18_0:GetPosition())

	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.DispatchEvent

	CourtYardEvent = var_3

	var_18_1(var_18_0, var_3.FURNITURE_STOP_MOVE)

	return
end

function var_0_1.ReStart(arg_19_0)
	arg_19_0:ChangeMoveState(var_0_3)

	return
end

function var_0_1.ChangeMoveState(arg_20_0, arg_20_1)
	arg_20_0.moveState = arg_20_1

	return
end

function var_0_1.IsSpineSlotAndExistPreheatAction(arg_21_0, arg_21_1)
	isa = var_1_10002

	local var_21_0 = arg_21_1

	CourtYardFurnitureSpineSlot = var_1_10004

	if not var_1_10002(var_21_0, var_1_10004) then
		return false
	end

	return arg_21_1.preheatAction ~= nil
end

function var_0_1.StartInteraction(arg_22_0, arg_22_1)
	if arg_22_0:IsSpineSlotAndExistPreheatAction(arg_22_1) then
		arg_22_0.playPreheatAction = true

		local var_22_0 = arg_22_0
		local var_22_1 = arg_22_0._ChangeState

		CourtYardFurniture = var_4

		var_22_1(var_22_0, var_4.STATE_INTERACT)

		local var_22_2 = arg_22_0
		local var_22_3 = arg_22_0.DispatchEvent

		CourtYardEvent = var_4

		var_22_3(var_22_2, var_4.FURNITURE_START_INTERACTION, arg_22_1)
		arg_22_0:Idle()
	else
		var_0_1.super.StartInteraction(arg_22_0, arg_22_1)

		if arg_22_0:IsMoveableSlot(arg_22_1) then
			arg_22_0:ChangeMoveState(var_0_3)
		end
	end

	return
end

function var_0_1.OnPreheatActionEnd(arg_23_0, arg_23_1)
	if arg_23_0:IsSpineSlotAndExistPreheatAction(arg_23_1) then
		arg_23_0.playPreheatAction = false

		arg_23_0:ChangeMoveState(var_0_3)
	end

	return
end

function var_0_1.CanInterAction(arg_24_0)
	if arg_24_0.playPreheatAction then
		return false
	end

	return var_0_1.super.CanInterAction(arg_24_0)
end

function var_0_1.ClearInteraction(arg_25_0, arg_25_1)
	if arg_25_0:IsSpineSlotAndExistPreheatAction(arg_25_1) then
		_ = var_2

		if #var_2.select(arg_25_0.slots, function(arg_26_0)
			return arg_26_0.id ~= arg_25_1.id and arg_26_0:IsUsing()
		end) == 0 then
			local var_25_0 = arg_25_0
			local var_25_1 = arg_25_0._ChangeState

			CourtYardFurniture = var_1_10005

			var_25_1(var_25_0, var_1_10005.STATE_IDLE)
			arg_25_0:Idle()
		end

		local var_25_2 = arg_25_0
		local var_25_3 = arg_25_0.DispatchEvent

		CourtYardEvent = var_1_10005

		var_25_3(var_25_2, var_1_10005.FURNITURE_STOP_INTERACTION, arg_25_1)
	else
		var_0_1.super.ClearInteraction(arg_25_0, arg_25_1)

		if arg_25_0:IsMoveableSlot(arg_25_1) then
			arg_25_0:Idle()
		end
	end

	return
end

function var_0_1.RemoveTimer(arg_27_0)
	if arg_27_0.moveTimer then
		local var_27_0 = arg_27_0.moveTimer

		var_1.Stop(var_27_0)

		arg_27_0.moveTimer = nil
	end

	return
end

function var_0_1.IsDifferentDirectionForCard(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:GetPosition()
	local var_28_1

	if arg_28_0.config.dir ~= 1 or not {
		1,
		2
	} then
		var_28_1 = {
			2,
			1
		}
	end

	local var_28_2

	if arg_28_1.x > var_28_0.x then
		var_28_2 = var_28_1[1]
	elseif arg_28_1.y > var_28_0.y then
		var_28_2 = var_28_1[2]
	else
		var_28_2 = (arg_28_1.x < var_28_0.x and arg_28_1.y == var_28_0.y or arg_28_1.y > var_28_0.y and arg_28_1.x == var_28_0.x) and var_28_1[1] or var_28_1[2]
	end

	return arg_28_0.dir ~= var_28_2
end

function var_0_1.IsDifferentDirection(arg_29_0, arg_29_1)
	if arg_29_0:IsCar() then
		return arg_29_0:IsDifferentDirectionForCard(arg_29_1)
	else
		return var_0_1.super.IsDifferentDirection(arg_29_0, arg_29_1)
	end

	return
end

function var_0_1.Dispose(arg_30_0)
	var_0_1.super.Dispose(arg_30_0)
	arg_30_0:RemoveTimer()

	arg_30_0.playPreheatAction = false

	return
end

return var_0_1
