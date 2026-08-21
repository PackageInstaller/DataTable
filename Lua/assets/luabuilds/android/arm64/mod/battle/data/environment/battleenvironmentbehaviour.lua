ys = ys or {}

local var_0_1 = class("BattleEnvironmentBehaviour")

ys.Battle.BattleEnvironmentBehaviour = var_0_1
var_0_1.__name = "BattleEnvironmentBehaviour"
var_0_1.STATE_DELAY = "STATE_DELAY"
var_0_1.STATE_READY = "STATE_READY"
var_0_1.STATE_OVERHEAT = "STATE_OVERHEAT"
var_0_1.STATE_EXPIRE = "STATE_EXPIRE"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._cldUnitList = {}

	return
end

function var_0_1.SetUnitRef(arg_2_0, arg_2_1)
	assert(arg_2_1, "Shounld Bind A Unit")

	arg_2_0._unit = arg_2_1

	return
end

function var_0_1.SetTemplate(arg_3_0, arg_3_1)
	arg_3_0._tmpData = arg_3_1

	if arg_3_0._tmpData.delay then
		arg_3_0._delayStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
		arg_3_0._state = var_0_1.STATE_DELAY
	else
		arg_3_0._state = var_0_1.STATE_READY
	end

	if arg_3_0._tmpData.life_time then
		arg_3_0._liftStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	end

	arg_3_0._diveFilter = arg_3_0._tmpData.diveFilter or {}

	return
end

function var_0_1.UpdateCollideUnitList(arg_4_0, arg_4_1)
	if #arg_4_0._diveFilter ~= 0 then
		while #arg_4_1 > 0 do
			local var_4_0 = arg_4_1[#arg_4_1]:GetCurrentOxyState()

			for iter_4_0, iter_4_1 in ipairs(arg_4_0._diveFilter) do
				if var_4_0 == iter_4_1 then
					table.remove(arg_4_1, #arg_4_1)

					break
				end
			end
		end
	end

	arg_4_0._cldUnitList = arg_4_1

	return
end

function var_0_1.OnUpdate(arg_5_0)
	arg_5_0:updateDelay()
	arg_5_0:updateReload()
	arg_5_0:updateLifeTime()

	if arg_5_0._state == var_0_1.STATE_READY then
		arg_5_0:doBehaviour()
	end

	return
end

function var_0_1.Dispose(arg_6_0)
	arg_6_0._cldUnitList = nil
	arg_6_0._tmpData = nil
	arg_6_0._CDstartTime = nil

	return
end

function var_0_1.OnCollide(arg_7_0, arg_7_1)
	return
end

function var_0_1.GetCurrentState(arg_8_0)
	return arg_8_0._state
end

function var_0_1.updateDelay(arg_9_0)
	if arg_9_0._delayStartTime then
		if arg_9_0._tmpData.delay + arg_9_0._delayStartTime <= pg.TimeMgr.GetInstance():GetCombatTime() then
			arg_9_0._delayStartTime = nil

			arg_9_0:handleCoolDown()
		end
	end

	return
end

function var_0_1.updateReload(arg_10_0)
	if arg_10_0._CDstartTime then
		if arg_10_0:getReloadFinishTimeStamp() <= pg.TimeMgr.GetInstance():GetCombatTime() then
			arg_10_0:handleCoolDown()
		else
			return
		end
	end

	return
end

function var_0_1.updateLifeTime(arg_11_0)
	if arg_11_0._liftStartTime then
		if arg_11_0._liftStartTime + arg_11_0._tmpData.life_time <= pg.TimeMgr.GetInstance():GetCombatTime() then
			arg_11_0._state = var_0_1.STATE_EXPIRE

			arg_11_0:doExpire()
		end
	end

	return
end

function var_0_1.getReloadFinishTimeStamp(arg_12_0)
	return arg_12_0._tmpData.reload_time + arg_12_0._CDstartTime
end

function var_0_1.handleCoolDown(arg_13_0)
	arg_13_0._state = var_0_1.STATE_READY
	arg_13_0._CDstartTime = nil

	return
end

function var_0_1.doBehaviour(arg_14_0)
	if arg_14_0._tmpData.reload_time then
		arg_14_0._CDstartTime = pg.TimeMgr.GetInstance():GetCombatTime()
		arg_14_0._state = var_0_1.STATE_OVERHEAT
	end

	return
end

function var_0_1.doExpire(arg_15_0)
	arg_15_0._state = var_0_1.STATE_EXPIRE

	return
end

var_0_1.BehaviourClassEnum = {
	[ys.Battle.BattleConst.EnviroumentBehaviour.PLAY_FX] = "BattleEnvironmentBehaviourPlayFX",
	[ys.Battle.BattleConst.EnviroumentBehaviour.DAMAGE] = "BattleEnvironmentBehaviourDamage",
	[ys.Battle.BattleConst.EnviroumentBehaviour.BUFF] = "BattleEnvironmentBehaviourBuff",
	[ys.Battle.BattleConst.EnviroumentBehaviour.MOVEMENT] = "BattleEnvironmentBehaviourMovement",
	[ys.Battle.BattleConst.EnviroumentBehaviour.FORCE] = "BattleEnvironmentBehaviourForce",
	[ys.Battle.BattleConst.EnviroumentBehaviour.SPAWN] = "BattleEnvironmentBehaviourSpawn",
	[ys.Battle.BattleConst.EnviroumentBehaviour.PLAY_SFX] = "BattleEnvironmentBehaviourPlaySFX",
	[ys.Battle.BattleConst.EnviroumentBehaviour.SHAKE_SCREEN] = "BattleEnvironmentBehaviourShakeScreen"
}

function var_0_1.CreateBehaviour(arg_16_0)
	return var_0.Battle[var_0_1.BehaviourClassEnum[arg_16_0.type]].New()
end

return
