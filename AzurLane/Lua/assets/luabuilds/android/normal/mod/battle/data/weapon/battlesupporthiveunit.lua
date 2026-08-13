ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleSupportHiveUnit = var_0_10004("BattleSupportHiveUnit", var_0.Battle.BattleWeaponUnit)
var_0.Battle.BattleSupportHiveUnit.__name = "BattleSupportHiveUnit"

local var_0_4 = var_0.Battle.BattleSupportHiveUnit

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.Update(arg_2_0)
	arg_2_0:UpdateReload()
	arg_2_0:updateMovementInfo()

	if arg_2_0._currentState == arg_2_0.STATE_READY then
		local var_2_0 = arg_2_0._host

		if var_1.GetUnitType(var_2_0) ~= var_0_1.UnitType.PLAYER_UNIT then
			if arg_2_0._preCastInfo.time == nil then
				arg_2_0._currentState = arg_2_0.STATE_PRECAST_FINISH
			else
				arg_2_0:PreCast()
			end
		elseif #var_0.Battle.BattleTargetChoise.TargetAircraftGB(arg_2_0._host) > 0 then
			arg_2_0._currentState = arg_2_0.STATE_PRECAST_FINISH
		end
	end

	if arg_2_0._currentState == arg_2_0.STATE_PRECAST_FINISH then
		arg_2_0:updateMovementInfo()
		arg_2_0:Fire()
	end

	return
end

function var_0_4.Fire(arg_3_0)
	arg_3_0:DispatchGCD()

	arg_3_0._currentState = arg_3_0.STATE_ATTACK

	arg_3_0:DoAttack()

	return true
end

function var_0_4.createMajorEmitter(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	local function var_4_0(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
		local var_5_0 = arg_4_0
		local var_5_1, var_5_2 = var_5.SpwanAircraft(var_5_0, arg_5_2)

		var_5_1:AddCreateTimer(var_5_2, 1.5)

		if arg_4_0._debugRecordDEFAircraft then
			table = var_7

			var_7.insert(arg_4_0._debugRecordDEFAircraft, var_5_1)
		end

		return
	end

	var_0_4.super.createMajorEmitter(arg_4_0, arg_4_1, arg_4_2, nil, var_4_0, nil)

	return
end

function var_0_4.SpwanAircraft(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._dataProxy
	local var_6_1 = var_2.CreateAircraft(var_6_0, arg_6_0._host, arg_6_0._tmpData.id, arg_6_0:GetPotential(), arg_6_0._skinID)
	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.GetBaseAngle(var_6_2) + arg_6_1

	math = var_6_2

	local var_6_4 = var_6_2.deg2Rad * var_6_3

	Vector3 = var_5
	math = var_6

	local var_6_5 = var_6.cos(var_6_4)
	local var_6_6 = 0

	math = var_1_10008

	local var_6_7 = var_5(var_6_5, var_6_6, var_1_10008.sin(var_6_4))

	return var_6_1, var_6_7
end

function var_0_4.GetATKAircraftList(arg_7_0)
	local var_7_0

	if not arg_7_0._debugRecordATKAircraft then
		var_7_0 = {}
	end

	arg_7_0._debugRecordATKAircraft = var_7_0

	return arg_7_0._debugRecordATKAircraft
end

function var_0_4.GetDEFAircraftList(arg_8_0)
	local var_8_0

	if not arg_8_0._debugRecordDEFAircraft then
		var_8_0 = {}
	end

	arg_8_0._debugRecordDEFAircraft = var_8_0

	return arg_8_0._debugRecordDEFAircraft
end

function var_0_4.GetDamageSUM(arg_9_0)
	local var_9_0 = 0
	local var_9_1 = arg_9_0
	local var_9_2 = arg_9_0.GetDEFAircraftList(var_9_1)

	ipairs = var_9_1

	for iter_9_0, iter_9_1 in var_9_1(var_9_2) do
		local var_9_3 = iter_9_1
		local var_9_4 = iter_9_1.GetWeapon(var_9_3)

		ipairs = var_9_3

		for iter_9_2, iter_9_3 in var_9_3(var_9_4) do
			var_9_0 = var_9_0 + iter_9_3:GetDamageSUM()
		end
	end

	return var_9_0
end

return
