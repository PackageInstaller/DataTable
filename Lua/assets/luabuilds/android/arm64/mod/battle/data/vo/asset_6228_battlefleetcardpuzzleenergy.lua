ys = ys or {}

local var_0_7 = ys.Battle.BattleDataFunction
local var_0_9 = ys.Battle.BattleCardPuzzleConfig
local BattleFleetCardPuzzleEnergy = class("BattleFleetCardPuzzleEnergy")

ys.Battle.BattleFleetCardPuzzleEnergy = BattleFleetCardPuzzleEnergy
BattleFleetCardPuzzleEnergy.__name = "BattleFleetCardPuzzleEnergy"

function BattleFleetCardPuzzleEnergy:Ctor(arg_1_1)
	self._client = arg_1_1
	self._fleetAttr = self._client:GetAttrManager()

	self:init()

	return
end

function BattleFleetCardPuzzleEnergy:CustomConfig(arg_2_1)
	local var_2_0 = var_0_7.GetPuzzleDungeonTemplate(arg_2_1)

	self._currentEnergy = var_2_0.init_energy
	self._generateRate = var_2_0.energy_recovery

	return
end

function BattleFleetCardPuzzleEnergy:Dispose()
	return
end

function BattleFleetCardPuzzleEnergy:GetMaxEnergy()
	return self._maxEnergy
end

function BattleFleetCardPuzzleEnergy:GetCurrentEnergy()
	return self._currentEnergy
end

function BattleFleetCardPuzzleEnergy:GetGeneratingProcess()
	if self._currentEnergy == self._maxEnergy then
		return 1
	else
		return self._energyGenerating
	end

	return
end

function BattleFleetCardPuzzleEnergy:ConsumeEnergy(arg_7_1)
	self._currentEnergy = math.max(self._currentEnergy - arg_7_1, 0)

	self._client:EnergyUpdate()

	if arg_7_1 > 0 then
		self._client:FlushHandOverheat()
	end

	return
end

function BattleFleetCardPuzzleEnergy:Update(arg_8_1)
	self:update(arg_8_1)

	return
end

function BattleFleetCardPuzzleEnergy:init()
	self._currentEnergy = var_0_9.baseEnergyInitial
	self._maxEnergy = 10
	self._generateRate = var_0_9.baseEnergyGenerateSpeedPerSecond
	self._energyGenerating = 0

	return
end

function BattleFleetCardPuzzleEnergy:updateTimeStamp()
	self._lastUpdateTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function BattleFleetCardPuzzleEnergy:Start()
	self:updateTimeStamp()

	return
end

function BattleFleetCardPuzzleEnergy:update(arg_12_1)
	if self._currentEnergy < self._maxEnergy then
		self._energyGenerating = (arg_12_1 - self._lastUpdateTimeStamp) * self:getCurrentSpeed() + self._energyGenerating

		if self._energyGenerating >= 1 then
			self._currentEnergy = self._currentEnergy + 1

			self._client:EnergyUpdate()

			self._energyGenerating = 0
		end
	end

	self:updateTimeStamp()

	return
end

function BattleFleetCardPuzzleEnergy:getCurrentSpeed()
	return (math.max(self._generateRate * (1 + self._fleetAttr:GetCurrent("BaseEnergyBoostRate")) + self._fleetAttr:GetCurrent("BaseEnergyBoostExtra"), 0))
end

function BattleFleetCardPuzzleEnergy:FillToCooldown(arg_14_1)
	if arg_14_1 <= self._currentEnergy then
		return 0
	else
		local var_14_0 = self:getCurrentSpeed()
		local var_14_1 = (1 - self._energyGenerating) / var_14_0

		if arg_14_1 - self._currentEnergy >= 2 then
			var_14_1 = 1 / var_14_0 * (arg_14_1 - self._currentEnergy - 1) + var_14_1
		end

		return var_14_1
	end

	return
end

return
