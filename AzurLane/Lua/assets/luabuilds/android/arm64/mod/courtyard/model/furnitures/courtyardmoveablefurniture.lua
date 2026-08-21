local var_0_0 = class("CourtYardMoveableFurniture", import(".CourtYardFurniture"))
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.moveState = var_0_1
	arg_1_0.playPreheatAction = false

	return
end

function var_0_0.IsCar(arg_2_0)
	if arg_2_0.config.spine then
		return arg_2_0.config.spine[1] and arg_2_0.config.spine[1][4] ~= nil
	end

	return false
end

function var_0_0.GetAroundPositions(arg_3_0)
	local var_3_0 = var_0_0.super.GetAroundPositions(arg_3_0)

	if not arg_3_0:IsCar() then
		return var_3_0
	end

	local var_3_1 = arg_3_0.config.spine[1][4]

	if type(arg_3_0.config.spine[1][4]) == "table" then
		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if table.contains(var_3_1, iter_3_0) then
				table.insert({}, iter_3_1)
			end
		end

		return {}
	else
		return var_3_0
	end

	return
end

function var_0_0._ChangeState(arg_4_0, arg_4_1)
	var_0_0.super._ChangeState(arg_4_0, arg_4_1)

	if CourtYardFurniture.STATE_TOUCH == arg_4_0.state then
		arg_4_0:ChangeMoveState(var_0_2)
	end

	return
end

function var_0_0.ChangeState(arg_5_0, arg_5_1)
	var_0_0.super.ChangeState(arg_5_0, arg_5_1)

	if CourtYardFurniture.STATE_TOUCH == arg_5_0.state then
		-- block empty
	elseif arg_5_0:IsMoving() then
		arg_5_0:Idle()
	end

	return
end

function var_0_0.IsMoveableSlot(arg_6_0, arg_6_1)
	return arg_6_1.id == 1
end

function var_0_0.IsReadyMove(arg_7_0)
	return arg_7_0.moveState == var_0_2
end

function var_0_0.IsMoving(arg_8_0)
	return arg_8_0.moveState == var_0_3
end

function var_0_0.IsStop(arg_9_0)
	return arg_9_0.moveState == var_0_4
end

function var_0_0.SetPosition(arg_10_0, arg_10_1)
	if arg_10_0.moveState == var_0_3 then
		var_0_0.super.super.SetPosition(arg_10_0, arg_10_1)
	else
		var_0_0.super.SetPosition(arg_10_0, arg_10_1)
	end

	return
end

function var_0_0.GetSpeed(arg_11_0)
	local var_11_0 = 1

	if arg_11_0.config.spine and arg_11_0.config.spine[7] then
		var_11_0 = arg_11_0.config.spine[7]
	end

	return var_11_0
end

function var_0_0.GetMoveTime(arg_12_0)
	return 1 / arg_12_0:GetSpeed()
end

function var_0_0.Move(arg_13_0, arg_13_1)
	arg_13_0:RemoveTimer()
	arg_13_0:ChangeMoveState(var_0_3)

	arg_13_0.moveTimer = Timer.New(function()
		arg_13_0:ChangeMoveState(var_0_2)

		return
	end, arg_13_0:GetMoveTime(), 1)

	arg_13_0.moveTimer:Start()
	arg_13_0:DispatchEvent(CourtYardEvent.FURNITURE_MOVE, arg_13_1)

	return
end

function var_0_0.Rest(arg_15_0)
	arg_15_0:RemoveTimer()
	arg_15_0:ChangeMoveState(var_0_1)

	local var_15_0 = math.random(1)

	arg_15_0.moveTimer = Timer.New(function()
		arg_15_0:ChangeMoveState(var_0_2)

		return
	end, math.random(10, 20), 1)

	arg_15_0.moveTimer:Start()

	return
end

function var_0_0.Idle(arg_17_0)
	arg_17_0:RemoveTimer()
	arg_17_0:ChangeMoveState(var_0_1)
	arg_17_0:SetPosition(arg_17_0:GetPosition())
	arg_17_0:DispatchEvent(CourtYardEvent.FURNITURE_STOP_MOVE)

	return
end

function var_0_0.Stop(arg_18_0)
	arg_18_0:RemoveTimer()
	arg_18_0:ChangeMoveState(var_0_4)
	arg_18_0:SetPosition(arg_18_0:GetPosition())
	arg_18_0:DispatchEvent(CourtYardEvent.FURNITURE_STOP_MOVE)

	return
end

function var_0_0.ReStart(arg_19_0)
	arg_19_0:ChangeMoveState(var_0_2)

	return
end

function var_0_0.ChangeMoveState(arg_20_0, arg_20_1)
	arg_20_0.moveState = arg_20_1

	return
end

function var_0_0.IsSpineSlotAndExistPreheatAction(arg_21_0, arg_21_1)
	if not isa(arg_21_1, CourtYardFurnitureSpineSlot) then
		return false
	end

	return arg_21_1.preheatAction ~= nil
end

function var_0_0.StartInteraction(arg_22_0, arg_22_1)
	if arg_22_0:IsSpineSlotAndExistPreheatAction(arg_22_1) then
		arg_22_0.playPreheatAction = true

		arg_22_0:_ChangeState(CourtYardFurniture.STATE_INTERACT)
		arg_22_0:DispatchEvent(CourtYardEvent.FURNITURE_START_INTERACTION, arg_22_1)
		arg_22_0:Idle()
	else
		var_0_0.super.StartInteraction(arg_22_0, arg_22_1)

		if arg_22_0:IsMoveableSlot(arg_22_1) then
			arg_22_0:ChangeMoveState(var_0_2)
		end
	end

	return
end

function var_0_0.OnPreheatActionEnd(arg_23_0, arg_23_1)
	if arg_23_0:IsSpineSlotAndExistPreheatAction(arg_23_1) then
		arg_23_0.playPreheatAction = false

		arg_23_0:ChangeMoveState(var_0_2)
	end

	return
end

function var_0_0.CanInterAction(arg_24_0)
	if arg_24_0.playPreheatAction then
		return false
	end

	return var_0_0.super.CanInterAction(arg_24_0)
end

function var_0_0.ClearInteraction(arg_25_0, arg_25_1)
	if arg_25_0:IsSpineSlotAndExistPreheatAction(arg_25_1) then
		if #_.select(arg_25_0.slots, function(arg_26_0)
			return arg_26_0.id ~= arg_25_1.id and arg_26_0:IsUsing()
		end) == 0 then
			arg_25_0:_ChangeState(CourtYardFurniture.STATE_IDLE)
			arg_25_0:Idle()
		end

		arg_25_0:DispatchEvent(CourtYardEvent.FURNITURE_STOP_INTERACTION, arg_25_1)
	else
		var_0_0.super.ClearInteraction(arg_25_0, arg_25_1)

		if arg_25_0:IsMoveableSlot(arg_25_1) then
			arg_25_0:Idle()
		end
	end

	return
end

function var_0_0.RemoveTimer(arg_27_0)
	if arg_27_0.moveTimer then
		arg_27_0.moveTimer:Stop()

		arg_27_0.moveTimer = nil
	end

	return
end

function var_0_0.IsDifferentDirectionForCard(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:GetPosition()

	if arg_28_0.config.dir == 1 then
		local var_28_1 = {
			1,
			2
		}

		if not {
			1,
			2
		} then
			var_28_1 = {
				2,
				1
			}
		end

		local var_28_2 = arg_28_1.x > var_28_0.x and var_28_1[1] or arg_28_1.y > var_28_0.y and var_28_1[2] or (arg_28_1.x < var_28_0.x and arg_28_1.y == var_28_0.y or arg_28_1.y > var_28_0.y and arg_28_1.x == var_28_0.x) and var_28_1[1] or var_28_1[2]

		return arg_28_0.dir ~= var_28_2
	end
end

function var_0_0.IsDifferentDirection(arg_29_0, arg_29_1)
	if arg_29_0:IsCar() then
		return arg_29_0:IsDifferentDirectionForCard(arg_29_1)
	else
		return var_0_0.super.IsDifferentDirection(arg_29_0, arg_29_1)
	end

	return
end

function var_0_0.Dispose(arg_30_0)
	var_0_0.super.Dispose(arg_30_0)
	arg_30_0:RemoveTimer()

	arg_30_0.playPreheatAction = false

	return
end

return var_0_0
