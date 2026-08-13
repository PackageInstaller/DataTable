ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleHiveUnit = var_0_10004("BattleHiveUnit", var_0.Battle.BattleWeaponUnit)
var_0.Battle.BattleHiveUnit.__name = "BattleHiveUnit"

local var_0_4 = var_0.Battle.BattleHiveUnit

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
		else
			local var_2_1

			if arg_2_0._antiSub then
				var_2_1 = var_0.Battle.BattleTargetChoise.LegalTarget(arg_2_0._host)
				var_2_1 = var_0.Battle.BattleTargetChoise.TargetDiveState(nil, nil, var_2_1)
				var_2_1 = var_0.Battle.BattleTargetChoise.TargetDetectedUnit(nil, nil, var_2_1)
			else
				var_2_1 = var_0.Battle.BattleTargetChoise.TargetAircraftHarm(arg_2_0._host)
			end

			if #var_2_1 > 0 then
				arg_2_0._currentState = arg_2_0.STATE_PRECAST_FINISH
			end
		end
	end

	if arg_2_0._currentState == arg_2_0.STATE_PRECAST_FINISH then
		arg_2_0:updateMovementInfo()
		arg_2_0:Fire()
	end

	return
end

function var_0_4.SetTemplateData(arg_3_0, arg_3_1)
	var_0_4.super.SetTemplateData(arg_3_0, arg_3_1)

	table = var_2
	arg_3_0._antiSub = var_2.contains(arg_3_1.search_condition, var_0_1.OXY_STATE.DIVE)

	return
end

function var_0_4.Fire(arg_4_0)
	arg_4_0:DispatchGCD()

	arg_4_0._currentState = arg_4_0.STATE_ATTACK

	if arg_4_0._tmpData.action_index == "" then
		arg_4_0:DoAttack()
	else
		arg_4_0:DispatchFireEvent(nil, arg_4_0._tmpData.action_index)
	end

	local var_4_0 = arg_4_0._host

	var_1.CloakExpose(var_4_0, arg_4_0._tmpData.expose)

	return true
end

function var_0_4.createMajorEmitter(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local function var_5_0(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		local var_6_0 = arg_5_0
		local var_6_1, var_6_2 = var_5.SpwanAircraft(var_6_0, arg_6_2)

		var_6_1:AddCreateTimer(var_6_2, 1.5)

		if arg_5_0._debugRecordDEFAircraft then
			table = var_7

			var_7.insert(arg_5_0._debugRecordDEFAircraft, var_6_1)
		end

		return
	end

	var_0_4.super.createMajorEmitter(arg_5_0, arg_5_1, arg_5_2, nil, var_5_0, nil)

	return
end

function var_0_4.SingleFire(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._tempEmitterList = {}

	local function var_7_0(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
		local var_8_0 = arg_7_0
		local var_8_1, var_8_2 = var_5.SpwanAircraft(var_8_0, arg_8_2)

		var_0.Battle.BattleVariable.AddExempt(var_8_1:GetSpeedExemptKey(), var_8_1:GetIFF(), var_0_2.SPEED_FACTOR_FOCUS_CHARACTER)
		var_8_1:AddCreateTimer(var_8_2, 1)

		if arg_7_0._debugRecordATKAircraft then
			table = var_7

			var_7.insert(arg_7_0._debugRecordATKAircraft, var_8_1)
		end

		return
	end

	local function var_7_1()
		ipairs = var_2_10000

		for iter_9_0, iter_9_1 in var_2_10000(arg_7_0._tempEmitterList) do
			if iter_9_1:GetState() ~= iter_9_1.STATE_STOP then
				return
			end
		end

		ipairs = var_0

		for iter_9_2, iter_9_3 in var_0(arg_7_0._tempEmitterList) do
			iter_9_3:Destroy()
		end

		arg_7_0._tempEmitterList = nil

		if arg_7_3 then
			arg_7_3()
		end

		return
	end

	arg_7_2 = arg_7_2 or var_0_4.EMITTER_SHOTGUN
	ipairs = var_1_10006

	for iter_7_0, iter_7_1 in var_1_10006(arg_7_0._tmpData.barrage_ID) do
		local var_7_2 = var_0.Battle[arg_7_2].New(var_7_0, var_7_1, iter_7_1)

		arg_7_0._tempEmitterList[#arg_7_0._tempEmitterList + 1] = var_7_2
	end

	ipairs = var_6

	for iter_7_2, iter_7_3 in var_6(arg_7_0._tempEmitterList) do
		iter_7_3:Ready()
		iter_7_3:Fire(arg_7_1, arg_7_0:GetDirection(), arg_7_0:GetAttackAngle())
		iter_7_3:SetTimeScale(false)
	end

	local var_7_3 = arg_7_0._host

	var_6.CloakExpose(var_7_3, arg_7_0._tmpData.expose)

	return
end

function var_0_4.SpwanAircraft(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._dataProxy
	local var_10_1 = var_2.CreateAircraft(var_10_0, arg_10_0._host, arg_10_0._tmpData.id, arg_10_0:GetPotential(), arg_10_0._skinID)
	local var_10_4

	if arg_10_0:GetStandHost() then
		local var_10_2 = var_10_1
		local var_10_3 = var_10_1.SetAttr

		var_10_4 = arg_10_0

		var_10_3(var_10_2, arg_10_0.GetStandHost(var_10_4))
	end

	local var_10_5 = arg_10_0
	local var_10_6 = arg_10_0.GetBaseAngle(var_10_5) + arg_10_1

	math = var_10_5

	local var_10_7 = var_10_5.deg2Rad * var_10_6

	Vector3 = var_5
	math = var_10_4

	local var_10_8 = var_10_4.cos(var_10_7)
	local var_10_9 = 0

	math = var_1_10008

	local var_10_10 = var_5(var_10_8, var_10_9, var_1_10008.sin(var_10_7))

	arg_10_0:TriggerBuffWhenSpawnAircraft(var_10_1)

	if arg_10_0._strikePoint then
		var_10_1:SetStrikePoint(arg_10_0._strikePoint)
	end

	return var_10_1, var_10_10
end

function var_0_4.TriggerBuffWhenSpawnAircraft(arg_11_0, arg_11_1)
	local var_11_0 = var_0_1.BuffEffectType.ON_AIRCRAFT_CREATE
	local var_11_1 = {
		aircraft = arg_11_1,
		equipIndex = arg_11_0._equipmentIndex
	}
	local var_11_2 = arg_11_0._host

	var_4.TriggerBuff(var_11_2, var_11_0, var_11_1)

	return
end

function var_0_4.SetStrikePoint(arg_12_0, arg_12_1)
	arg_12_0._strikePoint = arg_12_1

	return
end

function var_0_4.GetStrikePoint(arg_13_0)
	return arg_13_0._strikePoint
end

function var_0_4.GetATKAircraftList(arg_14_0)
	local var_14_0

	if not arg_14_0._debugRecordATKAircraft then
		var_14_0 = {}
	end

	arg_14_0._debugRecordATKAircraft = var_14_0

	return arg_14_0._debugRecordATKAircraft
end

function var_0_4.GetDEFAircraftList(arg_15_0)
	local var_15_0

	if not arg_15_0._debugRecordDEFAircraft then
		var_15_0 = {}
	end

	arg_15_0._debugRecordDEFAircraft = var_15_0

	return arg_15_0._debugRecordDEFAircraft
end

function var_0_4.GetDamageSUM(arg_16_0)
	local var_16_0 = 0
	local var_16_1 = arg_16_0
	local var_16_2 = arg_16_0.GetDEFAircraftList(var_16_1)

	ipairs = var_16_1

	for iter_16_0, iter_16_1 in var_16_1(var_16_2) do
		local var_16_3 = iter_16_1
		local var_16_4 = iter_16_1.GetWeapon(var_16_3)

		ipairs = var_16_3

		for iter_16_2, iter_16_3 in var_16_3(var_16_4) do
			var_16_0 = var_16_0 + iter_16_3:GetDamageSUM()
		end
	end

	return var_16_0
end

return
