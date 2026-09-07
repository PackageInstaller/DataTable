ys = ys or {}

local var_0_2 = ys.Battle.BattleConst
local var_0_7 = ys.Battle.BattleTargetChoise
local BattleIndieSonar = class("BattleIndieSonar")

ys.Battle.BattleIndieSonar = BattleIndieSonar
BattleIndieSonar.__name = "BattleIndieSonar"

function BattleIndieSonar:Ctor(arg_1_1, arg_1_2, arg_1_3)
	self._fleetVO = arg_1_1
	self._range = 180
	self._duration = arg_1_3

	return
end

function BattleIndieSonar:SwitchHost(arg_2_1)
	self._host = arg_2_1

	return
end

function BattleIndieSonar:Detect()
	self._snoarStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

	local var_3_0 = self:FilterTarget()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		iter_3_1:Detected(self._duration)
	end

	self._detectedList = var_3_0

	self._fleetVO:DispatchSonarScan(true)

	return
end

function BattleIndieSonar:Update(arg_4_1)
	if arg_4_1 > self._snoarStartTime + self._duration then
		self._detectedList = nil

		self._fleetVO:RemoveIndieSonar(self)
	end

	return
end

function BattleIndieSonar:FilterTarget()
	return (var_0_7.TargetDiveState(self._host, {
		diveState = var_0_2.OXY_STATE.DIVE
	}, (var_0_7.LegalTarget(self._host))))
end

return
