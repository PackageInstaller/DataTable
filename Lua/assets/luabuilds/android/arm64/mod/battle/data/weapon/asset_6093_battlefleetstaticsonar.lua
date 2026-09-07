ys = ys or {}

local var_0_0 = ys
local var_0_3 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleConfig
local var_0_8 = ys.Battle.BattleTargetChoise
local var_0_9 = ys.Battle.BattleConfig.VAN_SONAR_PROPERTY
local BattleFleetStaticSonar = class("BattleFleetStaticSonar")

ys.Battle.BattleFleetStaticSonar = BattleFleetStaticSonar
BattleFleetStaticSonar.__name = "BattleFleetStaticSonar"
BattleFleetStaticSonar.STATE_DISABLE = "DISABLE"
BattleFleetStaticSonar.STATE_READY = "READY"

function BattleFleetStaticSonar:Ctor(arg_1_1)
	self:init()

	self._fleetVO = arg_1_1
	self._currentState = BattleFleetStaticSonar.STATE_DISABLE

	return
end

function BattleFleetStaticSonar:GetCurrentState()
	return self._currentState
end

function BattleFleetStaticSonar:Dispose()
	self._detectedList = nil
	self._crewUnitList = nil
	self._host = nil

	return
end

function BattleFleetStaticSonar:init()
	self._crewUnitList = {}
	self._detectedList = {}
	self._skillDiameter = 0
	self._radius = 0
	self._diameter = 0

	return
end

function BattleFleetStaticSonar:AppendExtraSkillRange(arg_5_1)
	self._skillDiameter = self._skillDiameter + arg_5_1

	if self._radius ~= 0 then
		self._radius = self._radius + arg_5_1 * 0.5
	end

	return
end

function BattleFleetStaticSonar:AppendCrewUnit(arg_6_1)
	self._crewUnitList[arg_6_1:GetUniqueID()] = arg_6_1

	self:flush()

	return
end

function BattleFleetStaticSonar:RemoveCrewUnit(arg_7_1)
	local var_7_0 = arg_7_1:GetUniqueID()

	if self._crewUnitList[var_7_0] then
		self._crewUnitList[var_7_0] = nil

		self:updateSonarState()

		if self._currentState == BattleFleetStaticSonar.STATE_DISABLE then
			self:Undetect()
		end
	end

	return
end

function BattleFleetStaticSonar:SwitchHost(arg_8_1)
	self._host = arg_8_1

	return
end

function BattleFleetStaticSonar:GetRange()
	return self._diameter
end

function BattleFleetStaticSonar:flush()
	self._diameter = 0

	local var_10_0, var_10_1, var_10_2 = self:calcSonarRange()

	if var_10_0 ~= 0 then
		self._diameter = var_10_0 + var_10_2 + var_10_1
		self._radius = self._diameter * 0.5
	end

	self:updateSonarState()

	return
end

function BattleFleetStaticSonar:calcSonarRange()
	local var_11_0 = 0
	local var_11_1 = 0
	local var_11_2 = 0

	for iter_11_0, iter_11_1 in pairs(self._crewUnitList) do
		local var_11_3, var_11_4, var_11_5 = self.getSonarProperty(iter_11_1)

		if var_11_3 > 0 then
			var_11_0 = math.max(var_11_3, var_11_0)
		end

		var_11_1 = var_11_1 + var_11_4
		var_11_2 = var_11_2 + var_11_5
	end

	return var_11_0, Mathf.Clamp(var_11_2 / var_0_4.MAIN_SONAR_PROPERTY.a, var_0_4.MAIN_SONAR_PROPERTY.minRange, var_0_4.MAIN_SONAR_PROPERTY.maxRange), var_11_1
end

function BattleFleetStaticSonar:updateSonarState()
	local var_12_0 = 0

	for iter_12_0, iter_12_1 in pairs(self._crewUnitList) do
		if self.getSonarProperty(iter_12_1) > 0 then
			var_12_0 = var_12_0 + 1
		end
	end

	self._currentState = var_12_0 > 0 and BattleFleetStaticSonar.STATE_READY or BattleFleetStaticSonar.STATE_DISABLE

	self._fleetVO:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleEvent.SONAR_UPDATE)))

	return
end

function BattleFleetStaticSonar:getSonarProperty()
	local var_13_0 = self:GetTemplate().type

	return (var_0_9[var_13_0] or nil) and Mathf.Clamp(self:GetAttrByName("baseAntiSubPower") / var_0_9[var_13_0].a - var_0_9[var_13_0].b, var_0_9[var_13_0].minRange, var_0_9[var_13_0].maxRange), self:GetAttrByName("sonarRange"), (table.contains(ShipType.MainShipType, var_13_0) or nil) and self:GetAttrByName("baseAntiSubPower")
end

function BattleFleetStaticSonar:Update(arg_14_1)
	if self._currentState ~= BattleFleetStaticSonar.STATE_DISABLE then
		self._fleetVO:DispatchSonarScan()
		self:updateDetectedList()
	end

	return
end

function BattleFleetStaticSonar:Undetect()
	for iter_15_0, iter_15_1 in ipairs(self._detectedList) do
		if iter_15_1:IsAlive() then
			iter_15_1:Undetected()
		end
	end

	self._detectedList = {}

	return
end

function BattleFleetStaticSonar:updateDetectedList()
	local var_16_0 = var_0_8.TargetDiveState(self._host, {
		diveState = var_0_3.OXY_STATE.DIVE
	}, (var_0_8.LegalTarget(self._host)))
	local var_16_1 = self:FilterRange(var_16_0)

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_2 = table.contains(var_16_1, iter_16_1)
		local var_16_3 = table.contains(self._detectedList, iter_16_1)

		if var_16_3 then
			if not var_16_2 then
				iter_16_1:Undetected()
			end
		elseif not var_16_3 and var_16_2 then
			iter_16_1:Detected()
		end
	end

	self._detectedList = var_16_1

	return
end

function BattleFleetStaticSonar:FilterTarget()
	return (self:FilterRange((var_0_8.TargetDiveState(self._host, {
		diveState = var_0_3.OXY_STATE.DIVE
	}, (var_0_8.LegalTarget(self._host))))))
end

function BattleFleetStaticSonar:FilterRange(arg_18_1)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		if not self:isOutOfRange(iter_18_1) then
			table.insert(var_18_0, iter_18_1)
		end
	end

	return var_18_0
end

function BattleFleetStaticSonar:isOutOfRange(arg_19_1)
	return self._host:GetDistance(arg_19_1) > self._radius
end

function BattleFleetStaticSonar:GetTotalRangeDetail()
	local var_20_0, var_20_1, var_20_2 = self:calcSonarRange()

	return var_20_0, var_20_1, var_20_2, self._skillDiameter
end

return
