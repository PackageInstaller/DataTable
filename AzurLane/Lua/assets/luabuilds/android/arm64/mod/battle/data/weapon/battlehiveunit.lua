ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleConfig

ys.Battle.BattleHiveUnit = class("BattleHiveUnit", ys.Battle.BattleWeaponUnit)
ys.Battle.BattleHiveUnit.__name = "BattleHiveUnit"

local var_0_3 = ys.Battle.BattleHiveUnit

function ys.Battle.BattleHiveUnit.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleHiveUnit.Update(arg_2_0)
	arg_2_0:UpdateReload()
	arg_2_0:updateMovementInfo()

	if arg_2_0._currentState == arg_2_0.STATE_READY then
		if arg_2_0._host:GetUnitType() ~= var_0_1.UnitType.PLAYER_UNIT then
			if arg_2_0._preCastInfo.time == nil then
				arg_2_0._currentState = arg_2_0.STATE_PRECAST_FINISH
			else
				arg_2_0:PreCast()
			end
		else
			local var_2_0

			if arg_2_0._antiSub then
				var_2_0 = var_0_0.Battle.BattleTargetChoise.LegalTarget(arg_2_0._host)
				var_2_0 = var_0_0.Battle.BattleTargetChoise.TargetDiveState(nil, nil, var_2_0)
				var_2_0 = var_0_0.Battle.BattleTargetChoise.TargetDetectedUnit(nil, nil, var_2_0)
			else
				var_2_0 = var_0_0.Battle.BattleTargetChoise.TargetAircraftHarm(arg_2_0._host)
			end

			if #var_2_0 > 0 then
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

function ys.Battle.BattleHiveUnit.SetTemplateData(arg_3_0, arg_3_1)
	var_0_3.super.SetTemplateData(arg_3_0, arg_3_1)

	arg_3_0._antiSub = table.contains(arg_3_1.search_condition, var_0_1.OXY_STATE.DIVE)

	return
end

function ys.Battle.BattleHiveUnit.Fire(arg_4_0)
	arg_4_0:DispatchGCD()

	arg_4_0._currentState = arg_4_0.STATE_ATTACK

	if arg_4_0._tmpData.action_index == "" then
		arg_4_0:DoAttack()
	else
		arg_4_0:DispatchFireEvent(nil, arg_4_0._tmpData.action_index)
	end

	arg_4_0._host:CloakExpose(arg_4_0._tmpData.expose)

	return true
end

function ys.Battle.BattleHiveUnit.createMajorEmitter(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	var_0_3.super.createMajorEmitter(arg_5_0, arg_5_1, arg_5_2, nil, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4)
		local var_6_0, var_6_1 = arg_5_0:SpwanAircraft(arg_6_2)

		var_6_0:AddCreateTimer(var_6_1, 1.5)

		if arg_5_0._debugRecordDEFAircraft then
			table.insert(arg_5_0._debugRecordDEFAircraft, var_6_0)
		end

		return
	end, nil)

	return
end

function ys.Battle.BattleHiveUnit.SingleFire(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._tempEmitterList = {}
	arg_7_2 = arg_7_2 or var_0_3.EMITTER_SHOTGUN

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._tmpData.barrage_ID) do
		arg_7_0._tempEmitterList[#arg_7_0._tempEmitterList + 1] = var_0_0.Battle[arg_7_2].New(function(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
			local var_8_0, var_8_1 = arg_7_0:SpwanAircraft(arg_8_2)

			var_0_0.Battle.BattleVariable.AddExempt(var_8_0:GetSpeedExemptKey(), var_8_0:GetIFF(), var_0_2.SPEED_FACTOR_FOCUS_CHARACTER)
			var_8_0:AddCreateTimer(var_8_1, 1)

			if arg_7_0._debugRecordATKAircraft then
				table.insert(arg_7_0._debugRecordATKAircraft, var_8_0)
			end

			return
		end, function()
			for iter_9_0, iter_9_1 in ipairs(arg_7_0._tempEmitterList) do
				if iter_9_1:GetState() ~= iter_9_1.STATE_STOP then
					return
				end
			end

			for iter_9_2, iter_9_3 in ipairs(arg_7_0._tempEmitterList) do
				iter_9_3:Destroy()
			end

			arg_7_0._tempEmitterList = nil

			if arg_7_3 then
				arg_7_3()
			end

			return
		end, iter_7_1)
	end

	for iter_7_2, iter_7_3 in ipairs(arg_7_0._tempEmitterList) do
		iter_7_3:Ready()
		iter_7_3:Fire(arg_7_1, arg_7_0:GetDirection(), arg_7_0:GetAttackAngle())
		iter_7_3:SetTimeScale(false)
	end

	arg_7_0._host:CloakExpose(arg_7_0._tmpData.expose)

	return
end

function ys.Battle.BattleHiveUnit.SpwanAircraft(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._dataProxy:CreateAircraft(arg_10_0._host, arg_10_0._tmpData.id, arg_10_0:GetPotential(), arg_10_0._skinID)

	if arg_10_0:GetStandHost() then
		var_10_0:SetAttr(arg_10_0:GetStandHost())
	end

	local var_10_1 = math.deg2Rad * (arg_10_0:GetBaseAngle() + arg_10_1)

	arg_10_0:TriggerBuffWhenSpawnAircraft(var_10_0)

	if arg_10_0._strikePoint then
		var_10_0:SetStrikePoint(arg_10_0._strikePoint)
	end

	return var_10_0, (Vector3(math.cos(var_10_1), 0, math.sin(var_10_1)))
end

function ys.Battle.BattleHiveUnit.TriggerBuffWhenSpawnAircraft(arg_11_0, arg_11_1)
	arg_11_0._host:TriggerBuff(var_0_1.BuffEffectType.ON_AIRCRAFT_CREATE, {
		aircraft = arg_11_1,
		equipIndex = arg_11_0._equipmentIndex
	})

	return
end

function ys.Battle.BattleHiveUnit.SetStrikePoint(arg_12_0, arg_12_1)
	arg_12_0._strikePoint = arg_12_1

	return
end

function ys.Battle.BattleHiveUnit.GetStrikePoint(arg_13_0)
	return arg_13_0._strikePoint
end

function ys.Battle.BattleHiveUnit.GetATKAircraftList(arg_14_0)
	arg_14_0._debugRecordATKAircraft = arg_14_0._debugRecordATKAircraft or {}

	return arg_14_0._debugRecordATKAircraft
end

function ys.Battle.BattleHiveUnit.GetDEFAircraftList(arg_15_0)
	arg_15_0._debugRecordDEFAircraft = arg_15_0._debugRecordDEFAircraft or {}

	return arg_15_0._debugRecordDEFAircraft
end

function ys.Battle.BattleHiveUnit.GetDamageSUM(arg_16_0)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in ipairs((arg_16_0:GetDEFAircraftList())) do
		for iter_16_2, iter_16_3 in ipairs((iter_16_1:GetWeapon())) do
			var_16_0 = var_16_0 + iter_16_3:GetDamageSUM()
		end
	end

	return var_16_0
end

return
