ys = ys or {}

local var_0_0 = ys
local BattleFleetCardPuzzleAntiAirUnit = class("BattleFleetCardPuzzleAntiAirUnit")

ys.Battle.BattleFleetCardPuzzleAntiAirUnit = BattleFleetCardPuzzleAntiAirUnit
BattleFleetCardPuzzleAntiAirUnit.__name = "BattleFleetCardPuzzleAntiAirUnit"
BattleFleetCardPuzzleAntiAirUnit.STATE_DISABLE = "DISABLE"
BattleFleetCardPuzzleAntiAirUnit.STATE_READY = "READY"
BattleFleetCardPuzzleAntiAirUnit.STATE_PRECAST = "PRECAST"
BattleFleetCardPuzzleAntiAirUnit.STATE_PRECAST_FINISH = "STATE_PRECAST_FINISH"
BattleFleetCardPuzzleAntiAirUnit.STATE_ATTACK = "ATTACK"
BattleFleetCardPuzzleAntiAirUnit.STATE_OVER_HEAT = "OVER_HEAT"

function BattleFleetCardPuzzleAntiAirUnit:Ctor(arg_1_1)
	self._client = arg_1_1

	self:init()

	return
end

function BattleFleetCardPuzzleAntiAirUnit:init()
	self._crewUnitList = {}
	self._hitFXResIDList = {}
	self._currentState = BattleFleetCardPuzzleAntiAirUnit.STATE_DISABLE
	self._dataProxy = var_0_0.Battle.BattleDataProxy.GetInstance()
	self._range = 0

	return
end

function BattleFleetCardPuzzleAntiAirUnit:AppendCrewUnit(arg_3_1)
	self._crewUnitList[arg_3_1] = true
	self._currentState = BattleFleetCardPuzzleAntiAirUnit.STATE_READY

	self:flush()

	return
end

function BattleFleetCardPuzzleAntiAirUnit:RemoveCrewUnit(arg_4_1)
	self._crewUnitList[arg_4_1] = nil

	self:flush()

	return
end

function BattleFleetCardPuzzleAntiAirUnit:SwitchHost(arg_5_1)
	self._host = arg_5_1

	return
end

function BattleFleetCardPuzzleAntiAirUnit:GetCrewUnitList()
	return self._crewUnitList
end

function BattleFleetCardPuzzleAntiAirUnit:GetRange()
	return self._range
end

function BattleFleetCardPuzzleAntiAirUnit:flush()
	self._range = 0
	self._interval = 0

	local var_8_0 = 0

	for iter_8_0, iter_8_1 in pairs(self._crewUnitList) do
		self._range = self._range + iter_8_0:GetTemplate().AA_range
		self._interval = self._interval + iter_8_0:GetTemplate().AA_CD
		var_8_0 = var_8_0 + 1
	end

	self._range = self._range / var_8_0
	self._interval = self._interval / var_8_0

	return
end

function BattleFleetCardPuzzleAntiAirUnit:Update()
	if self._client:IsAAActive() and self._currentState == BattleFleetCardPuzzleAntiAirUnit.STATE_READY then
		local var_9_0 = self:CompareDistance((self:FilterRange((self:FilterTarget()))))

		if var_9_0 then
			self:Fire(var_9_0)
		end
	end

	return
end

function BattleFleetCardPuzzleAntiAirUnit:FilterTarget()
	local var_10_0 = {}
	local var_10_1 = self._host:GetIFF()

	for iter_10_0, iter_10_1 in pairs((self._dataProxy:GetAircraftList())) do
		if iter_10_1:GetIFF() ~= var_10_1 and iter_10_1:IsVisitable() then
			var_10_0[1] = iter_10_1
		end
	end

	return var_10_0
end

function BattleFleetCardPuzzleAntiAirUnit:FilterRange(arg_11_1)
	for iter_11_0 = #arg_11_1, 1, -1 do
		if self:IsOutOfRange(arg_11_1[iter_11_0]) then
			table.remove(arg_11_1, iter_11_0)
		end
	end

	return arg_11_1
end

function BattleFleetCardPuzzleAntiAirUnit:IsOutOfRange(arg_12_1)
	return self:getTrackingHost():GetDistance(arg_12_1) > self._range
end

function BattleFleetCardPuzzleAntiAirUnit:CompareDistance(arg_13_1)
	local var_13_0

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		if 999999 > iter_13_1:GetPosition().x then
			var_13_0 = iter_13_1

			local var_13_1 = iter_13_1:GetPosition().x
		end
	end

	return var_13_0
end

function BattleFleetCardPuzzleAntiAirUnit:getTrackingHost()
	return self._host
end

function BattleFleetCardPuzzleAntiAirUnit:Fire(arg_15_1)
	if self._currentState == self.DISABLE then
		return
	end

	self._dataProxy:KillAircraft((arg_15_1:GetUniqueID()))
	self:EnterCoolDown()
	self._client:ConsumeAACounter()

	return
end

function BattleFleetCardPuzzleAntiAirUnit:EnterCoolDown()
	self._currentState = self.STATE_OVER_HEAT

	self:AddCDTimer(self._interval)

	return
end

function BattleFleetCardPuzzleAntiAirUnit:GetCurrentState()
	return self._currentState
end

function BattleFleetCardPuzzleAntiAirUnit:AddCDTimer(arg_18_1)
	self:RemoveCDTimer()

	self._cdTimer = pg.TimeMgr.GetInstance():AddBattleTimer("weaponTimer", -1, arg_18_1, function()
		self._currentState = self.STATE_READY

		self:RemoveCDTimer()

		return
	end, true)

	return
end

function BattleFleetCardPuzzleAntiAirUnit:RemoveCDTimer()
	pg.TimeMgr.GetInstance():RemoveBattleTimer(self._cdTimer)

	self._cdTimer = nil

	return
end

function BattleFleetCardPuzzleAntiAirUnit:Dispose()
	self:RemoveCDTimer()

	self._crewUnitList = nil
	self._hitFXResIDList = nil
	self._dataProxy = nil
	self._SFXID = nil

	return
end

return
