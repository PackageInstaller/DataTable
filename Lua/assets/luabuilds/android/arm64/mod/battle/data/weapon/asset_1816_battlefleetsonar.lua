ys = ys or {}

local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig
local var_0_7 = ys.Battle.BattleTargetChoise
local BattleFleetSonar = class("BattleFleetSonar")

ys.Battle.BattleFleetSonar = BattleFleetSonar
BattleFleetSonar.__name = "BattleFleetSonar"
BattleFleetSonar.STATE_DISABLE = "DISABLE"
BattleFleetSonar.STATE_OVER_HEAT = "OVER_HEAT"
BattleFleetSonar.STATE_READY = "READY"
BattleFleetSonar.STATE_DETECTING = "DETECTING"

function BattleFleetSonar:Ctor(arg_1_1)
	self:init()

	self._fleetVO = arg_1_1

	return
end

function BattleFleetSonar:Dispose()
	self._detectedList = nil
	self._crewUnitList = nil
	self._host = nil

	return
end

function BattleFleetSonar:init()
	self._crewUnitList = {}
	self._detectedList = {}

	return
end

function BattleFleetSonar:AppendCrewUnit(arg_4_1)
	self._crewUnitList[arg_4_1:GetUniqueID()] = arg_4_1

	self:flush()

	self._currentState = BattleFleetSonar.STATE_READY

	return
end

function BattleFleetSonar:RemoveCrewUnit(arg_5_1)
	local var_5_0 = arg_5_1:GetUniqueID()

	if self._crewUnitList[var_5_0] then
		self._crewUnitList[var_5_0] = nil

		self:flush()
	end

	return
end

function BattleFleetSonar:SwitchHost(arg_6_1)
	self._host = arg_6_1

	return
end

function BattleFleetSonar:GetRange()
	return self._range
end

function BattleFleetSonar:flush()
	self._range, self._interval, self._duration = 0, 0, 0

	local var_8_0 = 0
	local var_8_1 = 0
	local var_8_2 = 0
	local var_8_3 = 0

	for iter_8_0, iter_8_1 in pairs(self._crewUnitList) do
		local var_8_4 = iter_8_1:GetAttrByName("sonarRange")

		if var_8_4 > 0 then
			var_8_0 = var_8_0 + 1
			var_8_1 = math.max(var_8_1, var_8_4)
			var_8_2 = iter_8_1:GetAttrByName("sonarInterval") + var_8_2
			var_8_3 = math.max(var_8_3, (iter_8_1:GetAttrByName("sonarDuration")))
		end
	end

	if var_8_0 > 0 then
		self._range = var_8_1
		self._interval = var_8_2 / var_8_0 * (1 - (var_8_0 - 1) * var_0_3.SONAR_INTERVAL_K)
		self._duration = var_8_3 * (1 + (var_8_0 - 1) * var_0_3.SONAR_DURATION_K)
	else
		self:Undetect()

		self._currentState = BattleFleetSonar.STATE_DISABLE
	end

	return
end

function BattleFleetSonar:Update(arg_9_1)
	if self._currentState == BattleFleetSonar.STATE_DISABLE then
		-- block empty
	elseif self._currentState == BattleFleetSonar.STATE_READY then
		self:Detect()
	elseif self._currentState == BattleFleetSonar.STATE_OVER_HEAT then
		if arg_9_1 > self._interval + self._overheatStartTime then
			self:Ready()
		end
	elseif self._currentState == BattleFleetSonar.STATE_DETECTING then
		if arg_9_1 > self._snoarStartTime + self._duration then
			self:Overheat()
		else
			self:updateDetectedList()
		end
	end

	return
end

function BattleFleetSonar:Detect()
	self._snoarStartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	self._currentState = BattleFleetSonar.STATE_DETECTING

	local var_10_0 = self:FilterTarget()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		iter_10_1:Detected(10)
	end

	self._detectedList = var_10_0

	self._fleetVO:DispatchSonarScan()

	return
end

function BattleFleetSonar:Undetect()
	self._snoarStartTime = nil
	self._currentState = BattleFleetSonar.STATE_OVER_HEAT

	for iter_11_0, iter_11_1 in ipairs(self._detectedList) do
		if iter_11_1:IsAlive() then
			iter_11_1:Undetected()
		end
	end

	self._detectedList = {}

	return
end

function BattleFleetSonar:updateDetectedList()
	local var_12_0 = self:FilterTarget()
	local var_12_1 = #self._detectedList

	while var_12_1 > 0 do
		if not self._detectedList[var_12_1]:IsAlive() then
			table.remove(self._detectedList, var_12_1)
		elseif not table.contains(var_12_0, self._detectedList[var_12_1]) then
			self._detectedList[var_12_1]:Undetected()
			table.remove(self._detectedList, var_12_1)
		end

		var_12_1 = var_12_1 - 1
	end

	return
end

function BattleFleetSonar:Overheat()
	self:Undetect()

	self._overheatStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function BattleFleetSonar:Ready()
	self._overheatStartTime = nil
	self._currentState = BattleFleetSonar.STATE_READY

	return
end

function BattleFleetSonar:FilterTarget()
	return (self:FilterRange((var_0_7.TargetDiveState(self._host, {
		diveState = var_0_2.OXY_STATE.DIVE
	}, (var_0_7.LegalTarget(self._host))))))
end

function BattleFleetSonar:FilterRange(arg_16_1)
	for iter_16_0 = #arg_16_1, 1, -1 do
		if self:isOutOfRange(arg_16_1[iter_16_0]) then
			table.remove(arg_16_1, iter_16_0)
		end
	end

	return arg_16_1
end

function BattleFleetSonar:isOutOfRange(arg_17_1)
	return self._host:GetDistance(arg_17_1) > self._range
end

return
