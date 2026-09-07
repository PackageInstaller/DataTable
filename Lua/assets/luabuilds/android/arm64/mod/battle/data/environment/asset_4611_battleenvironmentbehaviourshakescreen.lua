ys = ys or {}

local var_0_0 = ys
local BattleEnvironmentBehaviourShakeScreen = class("BattleEnvironmentBehaviourShakeScreen", ys.Battle.BattleEnvironmentBehaviour)

ys.Battle.BattleEnvironmentBehaviourShakeScreen = BattleEnvironmentBehaviourShakeScreen
BattleEnvironmentBehaviourShakeScreen.__name = "BattleEnvironmentBehaviourShakeScreen"

function BattleEnvironmentBehaviourShakeScreen:Ctor()
	BattleEnvironmentBehaviourShakeScreen.super.Ctor(self)

	return
end

function BattleEnvironmentBehaviourShakeScreen:SetTemplate(arg_2_1)
	BattleEnvironmentBehaviourShakeScreen.super.SetTemplate(self, arg_2_1)

	self._shakeID = self._tmpData.shake_ID

	return
end

function BattleEnvironmentBehaviourShakeScreen:doBehaviour()
	var_0_0.Battle.BattleCameraUtil.GetInstance():StartShake(pg.shake_template[self._shakeID])

	self._state = BattleEnvironmentBehaviourShakeScreen.STATE_OVERHEAT

	if self._tmpData.reload_time then
		self._CDstartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	end

	return
end

return
