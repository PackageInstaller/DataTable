ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig

class = var_0_10003

local var_0_3 = var_0_10003("BattleEnvironmentBehaviour")

var_0.Battle.BattleEnvironmentBehaviour = var_0_3
var_0_3.__name = "BattleEnvironmentBehaviour"
var_0_3.STATE_DELAY = "STATE_DELAY"
var_0_3.STATE_READY = "STATE_READY"
var_0_3.STATE_OVERHEAT = "STATE_OVERHEAT"
var_0_3.STATE_EXPIRE = "STATE_EXPIRE"

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._cldUnitList = {}

	return
end

function var_0_3.SetUnitRef(arg_2_0, arg_2_1)
	assert = var_1_10002

	var_1_10002(arg_2_1, "Shounld Bind A Unit")

	arg_2_0._unit = arg_2_1

	return
end

function var_0_3.SetTemplate(arg_3_0, arg_3_1)
	arg_3_0._tmpData = arg_3_1

	if arg_3_0._tmpData.delay then
		pg = var_2

		local var_3_0 = var_2.TimeMgr.GetInstance()

		arg_3_0._delayStartTime = var_2.GetCombatTime(var_3_0)
		arg_3_0._state = var_0_3.STATE_DELAY
	else
		arg_3_0._state = var_0_3.STATE_READY
	end

	if arg_3_0._tmpData.life_time then
		pg = var_2

		local var_3_1 = var_2.TimeMgr.GetInstance()

		arg_3_0._liftStartTime = var_2.GetCombatTime(var_3_1)
	end

	local var_3_2

	if not arg_3_0._tmpData.diveFilter then
		var_3_2 = {}
	end

	arg_3_0._diveFilter = var_3_2

	return
end

function var_0_3.UpdateCollideUnitList(arg_4_0, arg_4_1)
	if #arg_4_0._diveFilter ~= 0 then
		local var_4_0 = #arg_4_1

		while var_4_0 > 0 do
			local var_4_1 = arg_4_1[var_4_0]
			local var_4_2 = var_3.GetCurrentOxyState(var_4_1)

			ipairs = var_4_1

			for iter_4_0, iter_4_1 in var_4_1(arg_4_0._diveFilter) do
				if var_4_2 == iter_4_1 then
					table = var_1_10009

					var_1_10009.remove(arg_4_1, var_4_0)

					break
				end
			end

			var_4_0 = var_4_0 - 1
		end
	end

	arg_4_0._cldUnitList = arg_4_1

	return
end

function var_0_3.OnUpdate(arg_5_0)
	arg_5_0:updateDelay()
	arg_5_0:updateReload()
	arg_5_0:updateLifeTime()

	if arg_5_0._state == var_0_3.STATE_READY then
		arg_5_0:doBehaviour()
	end

	return
end

function var_0_3.Dispose(arg_6_0)
	arg_6_0._cldUnitList = nil
	arg_6_0._tmpData = nil
	arg_6_0._CDstartTime = nil

	return
end

function var_0_3.OnCollide(arg_7_0, arg_7_1)
	return
end

function var_0_3.GetCurrentState(arg_8_0)
	return arg_8_0._state
end

function var_0_3.updateDelay(arg_9_0)
	if arg_9_0._delayStartTime then
		local var_9_0 = arg_9_0._tmpData.delay + arg_9_0._delayStartTime

		pg = var_2

		local var_9_1 = var_2.TimeMgr.GetInstance()

		if var_9_0 <= var_2.GetCombatTime(var_9_1) then
			arg_9_0._delayStartTime = nil

			arg_9_0:handleCoolDown()
		end
	end

	return
end

function var_0_3.updateReload(arg_10_0)
	if arg_10_0._CDstartTime then
		local var_10_0 = arg_10_0
		local var_10_1 = arg_10_0.getReloadFinishTimeStamp(var_10_0)

		pg = var_10_0

		local var_10_2 = var_10_0.TimeMgr.GetInstance()

		if var_10_1 <= var_2.GetCombatTime(var_10_2) then
			arg_10_0:handleCoolDown()
		else
			return
		end
	end

	return
end

function var_0_3.updateLifeTime(arg_11_0)
	if arg_11_0._liftStartTime then
		local var_11_0 = arg_11_0._liftStartTime + arg_11_0._tmpData.life_time

		pg = var_2

		local var_11_1 = var_2.TimeMgr.GetInstance()

		if var_11_0 <= var_2.GetCombatTime(var_11_1) then
			arg_11_0._state = var_0_3.STATE_EXPIRE

			arg_11_0:doExpire()
		end
	end

	return
end

function var_0_3.getReloadFinishTimeStamp(arg_12_0)
	return arg_12_0._tmpData.reload_time + arg_12_0._CDstartTime
end

function var_0_3.handleCoolDown(arg_13_0)
	arg_13_0._state = var_0_3.STATE_READY
	arg_13_0._CDstartTime = nil

	return
end

function var_0_3.doBehaviour(arg_14_0)
	if arg_14_0._tmpData.reload_time then
		pg = var_1

		local var_14_0 = var_1.TimeMgr.GetInstance()

		arg_14_0._CDstartTime = var_1.GetCombatTime(var_14_0)
		arg_14_0._state = var_0_3.STATE_OVERHEAT
	end

	return
end

function var_0_3.doExpire(arg_15_0)
	arg_15_0._state = var_0_3.STATE_EXPIRE

	return
end

var_0_3.BehaviourClassEnum = {
	[var_0_1.EnviroumentBehaviour.PLAY_FX] = "BattleEnvironmentBehaviourPlayFX",
	[var_0_1.EnviroumentBehaviour.DAMAGE] = "BattleEnvironmentBehaviourDamage",
	[var_0_1.EnviroumentBehaviour.BUFF] = "BattleEnvironmentBehaviourBuff",
	[var_0_1.EnviroumentBehaviour.MOVEMENT] = "BattleEnvironmentBehaviourMovement",
	[var_0_1.EnviroumentBehaviour.FORCE] = "BattleEnvironmentBehaviourForce",
	[var_0_1.EnviroumentBehaviour.SPAWN] = "BattleEnvironmentBehaviourSpawn",
	[var_0_1.EnviroumentBehaviour.PLAY_SFX] = "BattleEnvironmentBehaviourPlaySFX",
	[var_0_1.EnviroumentBehaviour.SHAKE_SCREEN] = "BattleEnvironmentBehaviourShakeScreen"
}

function var_0_3.CreateBehaviour(arg_16_0)
	return var_0.Battle[var_0_3.BehaviourClassEnum[arg_16_0.type]].New()
end

return
