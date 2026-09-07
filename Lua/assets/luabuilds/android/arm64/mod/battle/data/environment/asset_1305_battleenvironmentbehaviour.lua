ys = ys or {}

local var_0_0 = ys
local BattleEnvironmentBehaviour = class("BattleEnvironmentBehaviour")

ys.Battle.BattleEnvironmentBehaviour = BattleEnvironmentBehaviour
BattleEnvironmentBehaviour.__name = "BattleEnvironmentBehaviour"
BattleEnvironmentBehaviour.STATE_DELAY = "STATE_DELAY"
BattleEnvironmentBehaviour.STATE_READY = "STATE_READY"
BattleEnvironmentBehaviour.STATE_OVERHEAT = "STATE_OVERHEAT"
BattleEnvironmentBehaviour.STATE_EXPIRE = "STATE_EXPIRE"

function BattleEnvironmentBehaviour:Ctor(arg_1_1, arg_1_2)
	self._cldUnitList = {}

	return
end

function BattleEnvironmentBehaviour:SetUnitRef(arg_2_1)
	assert(arg_2_1, "Shounld Bind A Unit")

	self._unit = arg_2_1

	return
end

function BattleEnvironmentBehaviour:SetTemplate(arg_3_1)
	self._tmpData = arg_3_1

	if self._tmpData.delay then
		self._delayStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
		self._state = BattleEnvironmentBehaviour.STATE_DELAY
	else
		self._state = BattleEnvironmentBehaviour.STATE_READY
	end

	if self._tmpData.life_time then
		self._liftStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	end

	self._diveFilter = self._tmpData.diveFilter or {}

	return
end

function BattleEnvironmentBehaviour:UpdateCollideUnitList(arg_4_1)
	if #self._diveFilter ~= 0 then
		while #arg_4_1 > 0 do
			local var_4_0 = arg_4_1[#arg_4_1]:GetCurrentOxyState()

			for iter_4_0, iter_4_1 in ipairs(self._diveFilter) do
				if var_4_0 == iter_4_1 then
					table.remove(arg_4_1, #arg_4_1)

					break
				end
			end
		end
	end

	self._cldUnitList = arg_4_1

	return
end

function BattleEnvironmentBehaviour:OnUpdate()
	self:updateDelay()
	self:updateReload()
	self:updateLifeTime()

	if self._state == BattleEnvironmentBehaviour.STATE_READY then
		self:doBehaviour()
	end

	return
end

function BattleEnvironmentBehaviour:Dispose()
	self._cldUnitList = nil
	self._tmpData = nil
	self._CDstartTime = nil

	return
end

function BattleEnvironmentBehaviour:OnCollide(arg_7_1)
	return
end

function BattleEnvironmentBehaviour:GetCurrentState()
	return self._state
end

function BattleEnvironmentBehaviour:updateDelay()
	if self._delayStartTime then
		if self._tmpData.delay + self._delayStartTime <= pg.TimeMgr.GetInstance():GetCombatTime() then
			self._delayStartTime = nil

			self:handleCoolDown()
		end
	end

	return
end

function BattleEnvironmentBehaviour:updateReload()
	if self._CDstartTime then
		if self:getReloadFinishTimeStamp() <= pg.TimeMgr.GetInstance():GetCombatTime() then
			self:handleCoolDown()
		else
			return
		end
	end

	return
end

function BattleEnvironmentBehaviour:updateLifeTime()
	if self._liftStartTime then
		if self._liftStartTime + self._tmpData.life_time <= pg.TimeMgr.GetInstance():GetCombatTime() then
			self._state = BattleEnvironmentBehaviour.STATE_EXPIRE

			self:doExpire()
		end
	end

	return
end

function BattleEnvironmentBehaviour:getReloadFinishTimeStamp()
	return self._tmpData.reload_time + self._CDstartTime
end

function BattleEnvironmentBehaviour:handleCoolDown()
	self._state = BattleEnvironmentBehaviour.STATE_READY
	self._CDstartTime = nil

	return
end

function BattleEnvironmentBehaviour:doBehaviour()
	if self._tmpData.reload_time then
		self._CDstartTime = pg.TimeMgr.GetInstance():GetCombatTime()
		self._state = BattleEnvironmentBehaviour.STATE_OVERHEAT
	end

	return
end

function BattleEnvironmentBehaviour:doExpire()
	self._state = BattleEnvironmentBehaviour.STATE_EXPIRE

	return
end

BattleEnvironmentBehaviour.BehaviourClassEnum = {
	[ys.Battle.BattleConst.EnviroumentBehaviour.PLAY_FX] = "BattleEnvironmentBehaviourPlayFX",
	[ys.Battle.BattleConst.EnviroumentBehaviour.DAMAGE] = "BattleEnvironmentBehaviourDamage",
	[ys.Battle.BattleConst.EnviroumentBehaviour.BUFF] = "BattleEnvironmentBehaviourBuff",
	[ys.Battle.BattleConst.EnviroumentBehaviour.MOVEMENT] = "BattleEnvironmentBehaviourMovement",
	[ys.Battle.BattleConst.EnviroumentBehaviour.FORCE] = "BattleEnvironmentBehaviourForce",
	[ys.Battle.BattleConst.EnviroumentBehaviour.SPAWN] = "BattleEnvironmentBehaviourSpawn",
	[ys.Battle.BattleConst.EnviroumentBehaviour.PLAY_SFX] = "BattleEnvironmentBehaviourPlaySFX",
	[ys.Battle.BattleConst.EnviroumentBehaviour.SHAKE_SCREEN] = "BattleEnvironmentBehaviourShakeScreen"
}

function BattleEnvironmentBehaviour:CreateBehaviour()
	return var_0_0.Battle[BattleEnvironmentBehaviour.BehaviourClassEnum[self.type]].New()
end

return
