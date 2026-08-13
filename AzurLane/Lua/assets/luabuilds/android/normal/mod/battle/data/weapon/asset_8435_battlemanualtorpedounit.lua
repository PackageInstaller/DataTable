ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent

class = var_0_10002

local var_0_2 = var_0_10002("BattleManualTorpedoUnit", var_0.Battle.BattleTorpedoUnit)

var_0.Battle.BattleManualTorpedoUnit = var_0_2
var_0_2.__name = "BattleManualTorpedoUnit"

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.createMajorEmitter(arg_2_0, arg_2_1, arg_2_2)
	local function var_2_0(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = arg_2_0._emitBulletIDList[arg_2_2]
		local var_3_1 = arg_2_0
		local var_3_2 = var_5.Spawn(var_3_1, var_3_0, nil, var_0_2.INTERNAL)

		var_5.SetOffsetPriority(var_3_2, arg_3_3)
		var_5:SetShiftInfo(arg_3_0, arg_3_1)
		var_5:SetRotateInfo(nil, arg_2_0._botAutoAimAngle, arg_3_2)

		local var_3_3 = arg_2_0

		var_6.DispatchBulletEvent(var_3_3, var_5)

		return var_5
	end

	local function var_2_1()
		return
	end

	var_0_2.super.createMajorEmitter(arg_2_0, arg_2_1, arg_2_2, nil, var_2_0, var_2_1)

	return
end

function var_0_2.Update(arg_5_0)
	arg_5_0:UpdateReload()

	return
end

function var_0_2.SetPlayerTorpedoWeaponVO(arg_6_0, arg_6_1)
	arg_6_0._playerTorpedoVO = arg_6_1

	return
end

function var_0_2.TriggerBuffOnReady(arg_7_0)
	local var_7_0 = arg_7_0._host

	var_1.TriggerBuff(var_7_0, var_0.Battle.BattleConst.BuffEffectType.ON_MANUAL_TORPEDO_READY, {})

	return
end

function var_0_2.Fire(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0:updateMovementInfo()

		local var_8_0 = var_0.Battle.BattleTargetChoise.TargetHarmRandomByWeight
		local var_8_1 = arg_8_0._host
		local var_8_2
		local var_8_3 = arg_8_0

		if var_8_0(var_8_1, var_8_2, arg_8_0.GetFilteredList(var_8_3))[1] then
			local var_8_4 = var_2:GetPosition()
			local var_8_5 = arg_8_0._host
			local var_8_6 = var_4.GetPosition(var_8_5)

			math = var_8_5

			local var_8_7 = var_8_5.rad2Deg

			math = var_8_3
			arg_8_0._botAutoAimAngle = var_8_7 * var_8_3.atan2(var_8_4.z - var_8_6.z, var_8_4.x - var_8_6.x)
		else
			arg_8_0._botAutoAimAngle = arg_8_0:GetBaseAngle()
		end
	else
		arg_8_0._botAutoAimAngle = arg_8_0:GetBaseAngle()
	end

	return var_0_2.super.Fire(arg_8_0)
end

function var_0_2.DoAttack(arg_9_0)
	arg_9_0:DispatchEvent(var_0.Event.New(var_0_1.TORPEDO_WEAPON_FIRE, {}))
	var_0_2.super.DoAttack(arg_9_0)
	arg_9_0:DispatchEvent(var_0.Event.New(var_0_1.MANUAL_WEAPON_FIRE, {}))

	return
end

function var_0_2.InitialCD(arg_10_0)
	var_0_2.super.InitialCD(arg_10_0)

	local var_10_0 = arg_10_0._playerTorpedoVO

	var_1.InitialDeduct(var_10_0, arg_10_0)

	local var_10_1 = arg_10_0._playerTorpedoVO

	var_1.Charge(var_10_1, arg_10_0)

	return
end

function var_0_2.EnterCoolDown(arg_11_0)
	var_0_2.super.EnterCoolDown(arg_11_0)

	local var_11_0 = arg_11_0._playerTorpedoVO

	var_1.Charge(var_11_0, arg_11_0)

	return
end

function var_0_2.OverHeat(arg_12_0)
	var_0_2.super.OverHeat(arg_12_0)

	local var_12_0 = arg_12_0._playerTorpedoVO

	var_1.Deduct(var_12_0, arg_12_0)

	return
end

function var_0_2.Cease(arg_13_0)
	if arg_13_0._currentState == var_0_2.STATE_OVER_HEAT then
		arg_13_0:interruptAllEmitter()
	end

	return
end

function var_0_2.handleCoolDown(arg_14_0)
	arg_14_0._currentState = arg_14_0.STATE_READY

	local var_14_0 = arg_14_0._playerTorpedoVO

	var_1.Plus(var_14_0, arg_14_0)
	arg_14_0:DispatchEvent(var_0.Event.New(var_0_1.TORPEDO_WEAPON_READY, {}))
	arg_14_0:DispatchEvent(var_0.Event.New(var_0_1.MANUAL_WEAPON_READY, {}))
	arg_14_0:TriggerBuffOnReady()

	arg_14_0._CDstartTime = nil
	arg_14_0._reloadBoostList = {}

	return
end

function var_0_2.FlushReloadMax(arg_15_0, arg_15_1)
	if var_0_2.super.FlushReloadMax(arg_15_0, arg_15_1) then
		return true
	end

	local var_15_0 = arg_15_0._playerTorpedoVO

	var_3.RefreshReloadingBar(var_15_0)

	return
end

function var_0_2.FlushReloadRequire(arg_16_0)
	if var_0_2.super.FlushReloadRequire(arg_16_0) then
		return true
	end

	local var_16_0 = arg_16_0._playerTorpedoVO

	var_2.RefreshReloadingBar(var_16_0)

	return
end

function var_0_2.QuickCoolDown(arg_17_0)
	if arg_17_0._currentState == arg_17_0.STATE_OVER_HEAT then
		arg_17_0._currentState = arg_17_0.STATE_READY

		local var_17_0 = arg_17_0._playerTorpedoVO

		var_1.InstantCoolDown(var_17_0, arg_17_0)
		arg_17_0:DispatchEvent(var_0.Event.New(var_0_1.MANUAL_WEAPON_INSTANT_READY, {}))

		arg_17_0._CDstartTime = nil
		arg_17_0._reloadBoostList = {}
	end

	return
end

function var_0_2.Prepar(arg_18_0)
	local var_18_0 = arg_18_0._host

	if var_1.IsCease(var_18_0) then
		return false
	else
		arg_18_0._currentState = arg_18_0.STATE_PRECAST

		local var_18_1 = {}
		local var_18_2 = var_0.Event.New(var_0_1.TORPEDO_WEAPON_PREPAR, var_18_1)

		arg_18_0:DispatchEvent(var_18_2)

		return true
	end

	return
end

function var_0_2.Cancel(arg_19_0)
	arg_19_0._currentState = arg_19_0.STATE_READY

	local var_19_0 = var_0.Event.New(var_0_1.TORPEDO_WEAPON_CANCEL, {})

	arg_19_0:DispatchEvent(var_19_0)

	return
end

function var_0_2.ReloadBoost(arg_20_0, arg_20_1)
	local var_20_0 = 0

	ipairs = var_1_10003

	for iter_20_0, iter_20_1 in var_1_10003(arg_20_0._reloadBoostList) do
		var_20_0 = var_20_0 + iter_20_1
	end

	local var_20_1 = var_20_0 + arg_20_1

	pg = var_3

	local var_20_2 = var_3.TimeMgr.GetInstance()
	local var_20_3 = var_3.GetCombatTime(var_20_2) - arg_20_0._jammingTime - arg_20_0._CDstartTime
	local var_20_4

	if var_20_1 < 0 then
		math = var_6
		var_20_4 = var_6.max(var_20_1, (arg_20_0._reloadRequire - var_20_3) * -1)
	else
		math = var_6
		var_20_4 = var_6.min(var_20_1, var_20_3)
	end

	local var_20_5 = var_20_4 - var_20_1 + arg_20_1

	table = fixValue

	local var_20_6 = var_6.insert
	local var_20_7 = arg_20_0._reloadBoostList

	fixValue = var_1_10008

	var_20_6(var_20_7, var_1_10008)

	return
end

function var_0_2.AppendReloadBoost(arg_21_0, arg_21_1)
	if arg_21_0._currentState == arg_21_0.STATE_OVER_HEAT then
		local var_21_0 = arg_21_0._playerTorpedoVO

		var_2.ReloadBoost(var_21_0, arg_21_0, arg_21_1)
	end

	return
end

return
