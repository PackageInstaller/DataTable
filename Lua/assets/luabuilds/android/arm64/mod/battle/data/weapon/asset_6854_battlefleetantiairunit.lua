ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleFormulas
local var_0_3 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleConfig
local BattleFleetAntiAirUnit = class("BattleFleetAntiAirUnit")

ys.Battle.BattleFleetAntiAirUnit = BattleFleetAntiAirUnit
BattleFleetAntiAirUnit.__name = "BattleFleetAntiAirUnit"
BattleFleetAntiAirUnit.STATE_DISABLE = "DISABLE"
BattleFleetAntiAirUnit.STATE_READY = "READY"
BattleFleetAntiAirUnit.STATE_PRECAST = "PRECAST"
BattleFleetAntiAirUnit.STATE_PRECAST_FINISH = "STATE_PRECAST_FINISH"
BattleFleetAntiAirUnit.STATE_ATTACK = "ATTACK"
BattleFleetAntiAirUnit.STATE_OVER_HEAT = "OVER_HEAT"

function BattleFleetAntiAirUnit:Ctor()
	self:init()

	return
end

function BattleFleetAntiAirUnit:init()
	self._crewUnitList = {}
	self._hitFXResIDList = {}
	self._currentState = BattleFleetAntiAirUnit.STATE_DISABLE
	self._dataProxy = var_0_0.Battle.BattleDataProxy.GetInstance()
	self._range = 0

	return
end

function BattleFleetAntiAirUnit:AppendCrewUnit(arg_3_1)
	local var_3_0 = arg_3_1:GetFleetAntiAirList()

	if #var_3_0 > 0 then
		self._currentState = BattleFleetAntiAirUnit.STATE_READY
		self._crewUnitList[arg_3_1] = var_3_0

		self:flush()
	end

	return
end

function BattleFleetAntiAirUnit:RemoveCrewUnit(arg_4_1)
	if self._crewUnitList[arg_4_1] then
		self._crewUnitList[arg_4_1] = nil

		self:flush()
	end

	return
end

function BattleFleetAntiAirUnit:FlushCrewUnit(arg_5_1)
	local var_5_0 = arg_5_1:GetFleetAntiAirList()

	if #var_5_0 <= 0 then
		self:RemoveCrewUnit(arg_5_1)
	elseif self._crewUnitList[arg_5_1] == nil then
		self:AppendCrewUnit(arg_5_1)
	else
		self._crewUnitList[arg_5_1] = var_5_0

		self:flush()
	end

	return
end

function BattleFleetAntiAirUnit:SwitchHost(arg_6_1)
	self._host = arg_6_1

	return
end

function BattleFleetAntiAirUnit:GetCrewUnitList()
	return self._crewUnitList
end

function BattleFleetAntiAirUnit:GetRange()
	return self._range
end

function BattleFleetAntiAirUnit:flush()
	self._range = 0
	self._interval = 0
	self._hitFXResIDList = {}
	self._SFXID = nil

	local var_9_0 = {}
	local var_9_1 = 0
	local var_9_2 = 0

	for iter_9_0, iter_9_1 in pairs(self._crewUnitList) do
		var_9_2 = var_9_2 + iter_9_0:GetAttrByName("extraAntiAirRange")

		for iter_9_2, iter_9_3 in ipairs(iter_9_1) do
			var_9_1 = var_9_1 + 1
			self._interval = self._interval + iter_9_3:GetReloadTime()

			local var_9_3 = iter_9_3:GetTemplateData()

			self._range = self._range + var_9_3.range
			self._hitFXResIDList[iter_9_3] = var_0_0.Battle.BattleDataFunction.GetBulletTmpDataFromID(var_9_3.bullet_ID[1]).hit_fx
			self._SFXID = var_9_3.fire_sfx
		end

		var_9_0[#var_9_0 + 1] = {
			weight = var_0_2.AntiAirPowerWeight((iter_9_0:GetAttrByName("antiAirPower"))),
			rst = iter_9_0
		}
	end

	if var_9_1 == 0 then
		self._currentState = BattleFleetAntiAirUnit.STATE_DISABLE

		if self._precastTimer then
			self:RemovePrecastTimer()
		end
	else
		self._range = self._range / var_9_1 + var_9_2
		self._interval = self._interval / var_9_1 + 0.5
		self._weightList, self._totalWeight = var_0_2.GenerateWeightList(var_9_0)
	end

	return
end

function BattleFleetAntiAirUnit:Update()
	if self._currentState == BattleFleetAntiAirUnit.STATE_READY and #self:FilterRange((self:FilterTarget())) > 0 then
		self:AddPreCastTimer()
	end

	return
end

function BattleFleetAntiAirUnit:AddPreCastTimer()
	self._currentState = BattleFleetAntiAirUnit.STATE_PRECAST
	self._precastTimer = pg.TimeMgr.GetInstance():AddBattleTimer("", 0, var_0_4.AntiAirConfig.Precast_duration, function()
		self:RemovePrecastTimer()
		self:Fire()

		return
	end, true)

	return
end

function BattleFleetAntiAirUnit:RemovePrecastTimer()
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._precastTimer)

	self._precastTimer = nil

	return
end

function BattleFleetAntiAirUnit:FilterTarget()
	local var_14_0 = {}
	local var_14_1 = self._host:GetIFF()

	for iter_14_0, iter_14_1 in pairs((self._dataProxy:GetAircraftList())) do
		if iter_14_1:GetIFF() ~= var_14_1 and iter_14_1:IsVisitable() then
			var_14_0[1] = iter_14_1
		end
	end

	return var_14_0
end

function BattleFleetAntiAirUnit:FilterRange(arg_15_1)
	for iter_15_0 = #arg_15_1, 1, -1 do
		if self:IsOutOfRange(arg_15_1[iter_15_0]) then
			table.remove(arg_15_1, iter_15_0)
		end
	end

	return arg_15_1
end

function BattleFleetAntiAirUnit:IsOutOfRange(arg_16_1)
	return self:getTrackingHost():GetDistance(arg_16_1) > self._range
end

function BattleFleetAntiAirUnit:getTrackingHost()
	return self._host
end

function BattleFleetAntiAirUnit:Fire()
	if self._currentState == self.DISABLE then
		return
	end

	self._dataProxy:SpawnColumnArea(var_0_3.AOEField.AIR, self._host:GetIFF(), self._host:GetPosition(), self._range * 2, -1, function(arg_19_0)
		local var_19_0 = {}
		local var_19_1 = self._dataProxy:GetAircraftList()

		for iter_19_0, iter_19_1 in ipairs(arg_19_0) do
			if iter_19_1.Active then
				if var_19_1[iter_19_1.UID] and var_19_1[iter_19_1.UID]:IsVisitable() then
					var_19_0[#var_19_0 + 1] = var_19_1[iter_19_1.UID]
				end
			end
		end

		local var_19_2 = var_0_2.CalculateFleetAntiAirTotalDamage(self)
		local var_19_3 = var_0_2.GetMeteoDamageRatio(#var_19_0)

		for iter_19_2, iter_19_3 in ipairs(var_19_0) do
			self._dataProxy:HandleDirectDamage(iter_19_3, math.max(1, math.floor(var_19_2 * var_19_3[iter_19_2])), (var_0_2.WeightListRandom(self._weightList, self._totalWeight)))
		end

		return
	end)
	self:EnterCoolDown()

	for iter_18_0, iter_18_1 in pairs(self._crewUnitList) do
		iter_18_0:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_ANTIAIR_FIRE_NEAR, {})
		iter_18_0:PlayFX(iter_18_1[1]:GetTemplateData().fire_fx, true)
	end

	for iter_18_2, iter_18_3 in pairs(self._hitFXResIDList) do
		pg.EffectMgr.GetInstance():PlayBattleEffect(var_0_0.Battle.BattleFXPool.GetInstance():GetFX(iter_18_3), self._host:GetPosition() + Vector3((math.random() * 2 - 1) * self._range, 10, (math.random() * 2 - 1) * self._range), true)
	end

	var_0_0.Battle.PlayBattleSFX(self._SFXID)

	return
end

function BattleFleetAntiAirUnit:EnterCoolDown()
	self._currentState = self.STATE_OVER_HEAT

	self:AddCDTimer(self._interval)

	return
end

function BattleFleetAntiAirUnit:GetCurrentState()
	return self._currentState
end

function BattleFleetAntiAirUnit:AddCDTimer(arg_22_1)
	self:RemoveCDTimer()

	self._cdTimer = pg.TimeMgr.GetInstance():AddBattleTimer("weaponTimer", -1, arg_22_1, function()
		self._currentState = self.STATE_READY

		self:RemoveCDTimer()

		return
	end, true)

	return
end

function BattleFleetAntiAirUnit:RemoveCDTimer()
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._cdTimer)

	self._cdTimer = nil

	return
end

function BattleFleetAntiAirUnit:Dispose()
	self:RemoveCDTimer()
	self:RemovePrecastTimer()

	self._crewUnitList = nil
	self._weightList = nil
	self._hitFXResIDList = nil
	self._dataProxy = nil
	self._SFXID = nil

	return
end

return
