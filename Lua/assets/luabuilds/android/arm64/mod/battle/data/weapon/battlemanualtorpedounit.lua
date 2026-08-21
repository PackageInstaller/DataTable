ys = ys or {}

local var_0_0 = ys.Battle.BattleUnitEvent
local var_0_1 = class("BattleManualTorpedoUnit", ys.Battle.BattleTorpedoUnit)

ys.Battle.BattleManualTorpedoUnit = var_0_1
var_0_1.__name = "BattleManualTorpedoUnit"

function var_0_1.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function var_0_1.createMajorEmitter(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.createMajorEmitter(arg_2_0, arg_2_1, arg_2_2, nil, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = arg_2_0:Spawn(arg_2_0._emitBulletIDList[arg_2_2], nil, var_0_1.INTERNAL)

		var_3_0:SetOffsetPriority(arg_3_3)
		var_3_0:SetShiftInfo(arg_3_0, arg_3_1)
		var_3_0:SetRotateInfo(nil, arg_2_0._botAutoAimAngle, arg_3_2)
		arg_2_0:DispatchBulletEvent(var_3_0)

		return var_3_0
	end, function()
		return
	end)

	return
end

function var_0_1.Update(arg_5_0)
	arg_5_0:UpdateReload()

	return
end

function var_0_1.SetPlayerTorpedoWeaponVO(arg_6_0, arg_6_1)
	arg_6_0._playerTorpedoVO = arg_6_1

	return
end

function var_0_1.TriggerBuffOnReady(arg_7_0)
	arg_7_0._host:TriggerBuff(var_0.Battle.BattleConst.BuffEffectType.ON_MANUAL_TORPEDO_READY, {})

	return
end

function var_0_1.Fire(arg_8_0, arg_8_1)
	if arg_8_1 then
		arg_8_0:updateMovementInfo()

		local var_8_0 = var_0.Battle.BattleTargetChoise.TargetHarmRandomByWeight(arg_8_0._host, nil, arg_8_0:GetFilteredList())[1]

		if var_8_0 then
			local var_8_1 = var_8_0:GetPosition()
			local var_8_2 = arg_8_0._host:GetPosition()

			arg_8_0._botAutoAimAngle = math.rad2Deg * math.atan2(var_8_1.z - var_8_2.z, var_8_1.x - var_8_2.x)
		else
			arg_8_0._botAutoAimAngle = arg_8_0:GetBaseAngle()
		end
	else
		arg_8_0._botAutoAimAngle = arg_8_0:GetBaseAngle()
	end

	return var_0_1.super.Fire(arg_8_0)
end

function var_0_1.DoAttack(arg_9_0)
	arg_9_0:DispatchEvent(var_0.Event.New(var_0_0.TORPEDO_WEAPON_FIRE, {}))
	var_0_1.super.DoAttack(arg_9_0)
	arg_9_0:DispatchEvent(var_0.Event.New(var_0_0.MANUAL_WEAPON_FIRE, {}))

	return
end

function var_0_1.InitialCD(arg_10_0)
	var_0_1.super.InitialCD(arg_10_0)
	arg_10_0._playerTorpedoVO:InitialDeduct(arg_10_0)
	arg_10_0._playerTorpedoVO:Charge(arg_10_0)

	return
end

function var_0_1.EnterCoolDown(arg_11_0)
	var_0_1.super.EnterCoolDown(arg_11_0)
	arg_11_0._playerTorpedoVO:Charge(arg_11_0)

	return
end

function var_0_1.OverHeat(arg_12_0)
	var_0_1.super.OverHeat(arg_12_0)
	arg_12_0._playerTorpedoVO:Deduct(arg_12_0)

	return
end

function var_0_1.Cease(arg_13_0)
	if arg_13_0._currentState == var_0_1.STATE_OVER_HEAT then
		arg_13_0:interruptAllEmitter()
	end

	return
end

function var_0_1.handleCoolDown(arg_14_0)
	arg_14_0._currentState = arg_14_0.STATE_READY

	arg_14_0._playerTorpedoVO:Plus(arg_14_0)
	arg_14_0:DispatchEvent(var_0.Event.New(var_0_0.TORPEDO_WEAPON_READY, {}))
	arg_14_0:DispatchEvent(var_0.Event.New(var_0_0.MANUAL_WEAPON_READY, {}))
	arg_14_0:TriggerBuffOnReady()

	arg_14_0._CDstartTime = nil
	arg_14_0._reloadBoostList = {}

	return
end

function var_0_1.FlushReloadMax(arg_15_0, arg_15_1)
	if var_0_1.super.FlushReloadMax(arg_15_0, arg_15_1) then
		return true
	end

	arg_15_0._playerTorpedoVO:RefreshReloadingBar()

	return
end

function var_0_1.FlushReloadRequire(arg_16_0)
	if var_0_1.super.FlushReloadRequire(arg_16_0) then
		return true
	end

	arg_16_0._playerTorpedoVO:RefreshReloadingBar()

	return
end

function var_0_1.QuickCoolDown(arg_17_0)
	if arg_17_0._currentState == arg_17_0.STATE_OVER_HEAT then
		arg_17_0._currentState = arg_17_0.STATE_READY

		arg_17_0._playerTorpedoVO:InstantCoolDown(arg_17_0)
		arg_17_0:DispatchEvent(var_0.Event.New(var_0_0.MANUAL_WEAPON_INSTANT_READY, {}))

		arg_17_0._CDstartTime = nil
		arg_17_0._reloadBoostList = {}
	end

	return
end

function var_0_1.Prepar(arg_18_0)
	if arg_18_0._host:IsCease() then
		return false
	else
		arg_18_0._currentState = arg_18_0.STATE_PRECAST

		arg_18_0:DispatchEvent((var_0.Event.New(var_0_0.TORPEDO_WEAPON_PREPAR, {})))

		return true
	end

	return
end

function var_0_1.Cancel(arg_19_0)
	arg_19_0._currentState = arg_19_0.STATE_READY

	arg_19_0:DispatchEvent((var_0.Event.New(var_0_0.TORPEDO_WEAPON_CANCEL, {})))

	return
end

function var_0_1.ReloadBoost(arg_20_0, arg_20_1)
	local var_20_0 = 0

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._reloadBoostList) do
		var_20_0 = var_20_0 + iter_20_1
	end

	local var_20_1 = var_20_0 + arg_20_1
	local var_20_2 = var_20_0 + arg_20_1 < 0 and math.max(var_20_1, (arg_20_0._reloadRequire - (pg.TimeMgr.GetInstance():GetCombatTime() - arg_20_0._jammingTime - arg_20_0._CDstartTime)) * -1) or math.min(var_20_1, pg.TimeMgr.GetInstance():GetCombatTime() - arg_20_0._jammingTime - arg_20_0._CDstartTime)

	fixValue = var_20_2 - var_20_1 + arg_20_1

	table.insert(arg_20_0._reloadBoostList, fixValue)

	return
end

function var_0_1.AppendReloadBoost(arg_21_0, arg_21_1)
	if arg_21_0._currentState == arg_21_0.STATE_OVER_HEAT then
		arg_21_0._playerTorpedoVO:ReloadBoost(arg_21_0, arg_21_1)
	end

	return
end

return
