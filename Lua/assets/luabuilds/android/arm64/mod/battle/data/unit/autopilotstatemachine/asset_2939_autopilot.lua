ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst.AIStepType
local AutoPilot = class("AutoPilot")

ys.Battle.AutoPilot = AutoPilot
AutoPilot.__name = "AutoPilot"
AutoPilot.PILOT_VALVE = 0.5

function AutoPilot:Ctor(arg_1_1, arg_1_2)
	self._aiCfg = arg_1_2
	self._target = arg_1_1

	arg_1_1._move:SetAutoMoveAI(self, arg_1_1)
	self:generateList()

	self._currentStep = self._stepList[self._aiCfg.default]

	self._currentStep:Active(self._target)

	return
end

function AutoPilot:GetDirection()
	return (self._currentStep:GetDirection((self._target:GetPosition())))
end

function AutoPilot:GetTarget()
	return self._target
end

function AutoPilot:InputWeaponStateChange()
	return
end

function AutoPilot:SetHiveUnit(arg_5_1)
	self._hiveUnit = arg_5_1

	return
end

function AutoPilot:GetHiveUnit()
	return self._hiveUnit
end

function AutoPilot:OnHiveUnitDead()
	self._target:OnMotherDead()

	return
end

function AutoPilot:NextStep()
	local var_8_0 = self._currentStep:GetToIndex()

	if self._stepList[var_8_0] == nil then
		var_8_0 = self._aiCfg.default
	end

	self._currentStep = self._stepList[var_8_0]

	self._currentStep:Active(self._target)

	return
end

function AutoPilot:generateList()
	self._stepList = {}

	for iter_9_0, iter_9_1 in ipairs(self._aiCfg.list) do
		local var_9_0
		local var_9_1 = iter_9_1.to
		local var_9_2 = iter_9_1.param

		if iter_9_1.type == var_0_1.STAY then
			var_9_0 = var_0_0.Battle.AutoPilotStay.New(iter_9_1.index, self)
		elseif iter_9_1.type == var_0_1.MOVE_TO then
			var_9_0 = var_0_0.Battle.AutoPilotMoveTo.New(iter_9_1.index, self)
		elseif iter_9_1.type == var_0_1.MOVE then
			var_9_0 = var_0_0.Battle.AutoPilotMove.New(iter_9_1.index, self)
		elseif iter_9_1.type == var_0_1.MOVE_RELATIVE then
			var_9_0 = var_0_0.Battle.AutoPilotMoveRelative.New(iter_9_1.index, self)
		elseif iter_9_1.type == var_0_1.BROWNIAN then
			var_9_0 = var_0_0.Battle.AutoPilotBrownian.New(iter_9_1.index, self)
		elseif iter_9_1.type == var_0_1.CIRCLE then
			var_9_0 = var_0_0.Battle.AutoPilotCircle.New(iter_9_1.index, self)
		elseif iter_9_1.type == var_0_1.RELATIVE_BROWNIAN then
			var_9_0 = var_0_0.Battle.AutoPilotRelativeBrownian.New(iter_9_1.index, self)
		elseif iter_9_1.type == var_0_1.RELATIVE_FLEET_MOVE_TO then
			var_9_0 = var_0_0.Battle.AutoPilotRelativeFleetMoveTo.New(iter_9_1.index, self)
		elseif iter_9_1.type == var_0_1.HIVE_STAY then
			var_9_0 = var_0_0.Battle.AutoPilotHiveRelativeStay.New(iter_9_1.index, self)
		elseif iter_9_1.type == var_0_1.HIVE_CIRCLE then
			var_9_0 = var_0_0.Battle.AutoPilotHiveRelativeCircle.New(iter_9_1.index, self)
		elseif iter_9_1.type == var_0_1.MINION_STAY then
			var_9_0 = var_0_0.Battle.AutoPilotMinionRelativeStay.New(iter_9_1.index, self)
		elseif iter_9_1.type == var_0_1.MINION_CIRCLE then
			var_9_0 = var_0_0.Battle.AutoPilotMinionRelativeCircle.New(iter_9_1.index, self)
		end

		var_9_0:SetParameter(var_9_2, var_9_1)

		self._stepList[var_9_0:GetIndex()] = var_9_0
	end

	return
end

return
