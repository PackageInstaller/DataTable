class = var_0_10000

local var_0_0 = var_0_10000("TowerClimbingPlayerVO")
local var_0_1 = 0
local var_0_2 = 1
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = 4
local var_0_6 = 5
local var_0_7 = 6

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.view = arg_1_1
	arg_1_0.id = arg_1_2.id
	arg_1_0.life = arg_1_2.life
	arg_1_0.pageIndex = arg_1_2.pageIndex

	local var_1_0

	if not arg_1_2.higestscore then
		var_1_0 = 0
	end

	arg_1_0.higestscore = var_1_0
	pg = var_1_0
	arg_1_0.shipConfig = var_1_0.ship_data_statistics[arg_1_0.id]
	arg_1_0.skinId = arg_1_0.shipConfig.skin_id
	pg = var_3
	arg_1_0.shipName = var_3.ship_skin_template[arg_1_0.skinId].prefab

	local var_1_1

	if not arg_1_2.mapScore then
		var_1_1 = 0
	end

	arg_1_0.mapScore = var_1_1
	TowerClimbingGameSettings = var_1_1
	arg_1_0.verticalVelocity = var_1_1.JUMP_VELOCITY
	TowerClimbingGameSettings = var_3
	arg_1_0.horizontalVelocity = var_3.MOVE_VELOCITY
	TowerClimbingGameSettings = var_3
	arg_1_0.beInjuredVelocity = var_3.BEINJURED_VELOCITY
	arg_1_0.state = var_0_1
	arg_1_0.isStand = true
	arg_1_0.prevMoveDir = var_0_3
	arg_1_0.score = 0
	arg_1_0.isStand = true
	arg_1_0.InvincibleTime = 0

	return
end

function var_0_0.IsOverMapScore(arg_2_0)
	return arg_2_0.score > arg_2_0.mapScore
end

function var_0_0.UpdateStand(arg_3_0, arg_3_1)
	arg_3_0.isStand = arg_3_1

	return
end

function var_0_0.SetPosition(arg_4_0, arg_4_1)
	arg_4_0.position = arg_4_1

	arg_4_0:SendPlayerEvent("ChangePosition", arg_4_1)

	return
end

function var_0_0.GetShipName(arg_5_0)
	return arg_5_0.shipName
end

function var_0_0.CanJump(arg_6_0)
	return not arg_6_0:IsDeath() and arg_6_0.state ~= var_0_2 and arg_6_0.isStand
end

function var_0_0.Jump(arg_7_0)
	if arg_7_0:IsFatalInjured() then
		return
	end

	if not arg_7_0:CanJump() then
		return
	end

	arg_7_0:SendPlayerEvent("Jump", arg_7_0.verticalVelocity)

	arg_7_0.state = var_0_2

	return
end

function var_0_0.MoveRight(arg_8_0)
	if arg_8_0:IsFatalInjured() then
		return
	end

	if arg_8_0:IsDeath() then
		return
	end

	arg_8_0.prevMoveDir = var_0_4

	arg_8_0:SendPlayerEvent("MoveRight", arg_8_0.horizontalVelocity)

	arg_8_0.state = var_0_4

	return
end

function var_0_0.MoveLeft(arg_9_0)
	if arg_9_0:IsFatalInjured() then
		return
	end

	if arg_9_0:IsDeath() then
		return
	end

	arg_9_0.prevMoveDir = var_0_3

	arg_9_0:SendPlayerEvent("MoveLeft", arg_9_0.horizontalVelocity)

	arg_9_0.state = var_0_3

	return
end

function var_0_0.Idle(arg_10_0)
	if arg_10_0:IsDeath() then
		return
	end

	arg_10_0:SendPlayerEvent("Idle")

	arg_10_0.state = var_0_1

	return
end

function var_0_0.BeInjured(arg_11_0)
	if arg_11_0:IsFatalInjured() then
		return
	end

	if arg_11_0:IsDeath() then
		return
	end

	local var_11_0 = arg_11_0.beInjuredVelocity

	if arg_11_0.prevMoveDir == var_0_4 then
		var_11_0.x = -var_11_0.x
	end

	arg_11_0:SendPlayerEvent("BeInjured", var_11_0)

	arg_11_0.state = var_0_5

	arg_11_0:ReduceLife(1)

	return
end

function var_0_0.BeFatalInjured(arg_12_0, arg_12_1)
	if arg_12_0:IsFatalInjured() then
		return
	end

	if arg_12_0:IsDeath() then
		return
	end

	arg_12_0.state = var_0_7

	arg_12_0:ReduceLife(1)
	arg_12_0:SendPlayerEvent("BeFatalInjured", arg_12_1)

	return
end

function var_0_0.ReduceLife(arg_13_0, arg_13_1)
	arg_13_0.life = arg_13_0.life - arg_13_1

	if arg_13_0.life == 0 then
		arg_13_0.state = var_0_6

		arg_13_0:SendPlayerEvent("Dead")
	end

	arg_13_0:SendMapEvent("OnPlayerLifeUpdate", arg_13_0.life)

	return
end

function var_0_0.IsIdle(arg_14_0)
	return arg_14_0.state == var_0_1
end

function var_0_0.IsDeath(arg_15_0)
	return arg_15_0.state == var_0_6
end

function var_0_0.IsFatalInjured(arg_16_0)
	return arg_16_0.state == var_0_7
end

function var_0_0.AddScore(arg_17_0)
	arg_17_0.score = arg_17_0.score + 1

	arg_17_0:SendMapEvent("OnScoreUpdate", arg_17_0.score)

	return
end

function var_0_0.AddInvincibleEffect(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:IsInvincible()

	arg_18_0.InvincibleTime = arg_18_1

	if var_18_0 ~= arg_18_0:IsInvincible() then
		arg_18_0:SendPlayerEvent("Invincible", var_3)
	end

	return
end

function var_0_0.GetInvincibleTime(arg_19_0)
	return arg_19_0.InvincibleTime
end

function var_0_0.SetInvincibleTime(arg_20_0, arg_20_1)
	arg_20_0:AddInvincibleEffect(arg_20_1)

	return
end

function var_0_0.IsInvincible(arg_21_0)
	return arg_21_0.InvincibleTime > 0
end

function var_0_0.SendPlayerEvent(arg_22_0, arg_22_1, ...)
	local var_22_0 = arg_22_0.view.map
	local var_22_1 = var_2.GetPlayer(var_22_0)[arg_22_1]
	local var_22_2 = var_2

	unpack = var_1_10006

	var_22_1(var_22_2, var_1_10006({
		...
	}))

	return
end

function var_0_0.SendMapEvent(arg_23_0, arg_23_1, ...)
	local var_23_0 = arg_23_0.view.map[arg_23_1]
	local var_23_1 = var_2

	unpack = var_1_10006

	var_23_0(var_23_1, var_1_10006({
		...
	}))

	return
end

function var_0_0.IsOverHigestScore(arg_24_0)
	return arg_24_0.score > arg_24_0.higestscore
end

function var_0_0.Dispose(arg_25_0)
	return
end

return var_0_0
