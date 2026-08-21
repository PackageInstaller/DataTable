ys = ys or {}

local var_0_7 = ys.Battle.BattleDataFunction
local var_0_9 = ys.Battle.BattleCardPuzzleConfig
local var_0_10 = class("BattleFleetCardPuzzleEnergy")

ys.Battle.BattleFleetCardPuzzleEnergy = var_0_10
var_0_10.__name = "BattleFleetCardPuzzleEnergy"

function var_0_10.Ctor(arg_1_0, arg_1_1)
	arg_1_0._client = arg_1_1
	arg_1_0._fleetAttr = arg_1_0._client:GetAttrManager()

	arg_1_0:init()

	return
end

function var_0_10.CustomConfig(arg_2_0, arg_2_1)
	local var_2_0 = var_0_7.GetPuzzleDungeonTemplate(arg_2_1)

	arg_2_0._currentEnergy = var_2_0.init_energy
	arg_2_0._generateRate = var_2_0.energy_recovery

	return
end

function var_0_10.Dispose(arg_3_0)
	return
end

function var_0_10.GetMaxEnergy(arg_4_0)
	return arg_4_0._maxEnergy
end

function var_0_10.GetCurrentEnergy(arg_5_0)
	return arg_5_0._currentEnergy
end

function var_0_10.GetGeneratingProcess(arg_6_0)
	if arg_6_0._currentEnergy == arg_6_0._maxEnergy then
		return 1
	else
		return arg_6_0._energyGenerating
	end

	return
end

function var_0_10.ConsumeEnergy(arg_7_0, arg_7_1)
	arg_7_0._currentEnergy = math.max(arg_7_0._currentEnergy - arg_7_1, 0)

	arg_7_0._client:EnergyUpdate()

	if arg_7_1 > 0 then
		arg_7_0._client:FlushHandOverheat()
	end

	return
end

function var_0_10.Update(arg_8_0, arg_8_1)
	arg_8_0:update(arg_8_1)

	return
end

function var_0_10.init(arg_9_0)
	arg_9_0._currentEnergy = var_0_9.baseEnergyInitial
	arg_9_0._maxEnergy = 10
	arg_9_0._generateRate = var_0_9.baseEnergyGenerateSpeedPerSecond
	arg_9_0._energyGenerating = 0

	return
end

function var_0_10.updateTimeStamp(arg_10_0)
	arg_10_0._lastUpdateTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function var_0_10.Start(arg_11_0)
	arg_11_0:updateTimeStamp()

	return
end

function var_0_10.update(arg_12_0, arg_12_1)
	if arg_12_0._currentEnergy < arg_12_0._maxEnergy then
		arg_12_0._energyGenerating = (arg_12_1 - arg_12_0._lastUpdateTimeStamp) * arg_12_0:getCurrentSpeed() + arg_12_0._energyGenerating

		if arg_12_0._energyGenerating >= 1 then
			arg_12_0._currentEnergy = arg_12_0._currentEnergy + 1

			arg_12_0._client:EnergyUpdate()

			arg_12_0._energyGenerating = 0
		end
	end

	arg_12_0:updateTimeStamp()

	return
end

function var_0_10.getCurrentSpeed(arg_13_0)
	return (math.max(arg_13_0._generateRate * (1 + arg_13_0._fleetAttr:GetCurrent("BaseEnergyBoostRate")) + arg_13_0._fleetAttr:GetCurrent("BaseEnergyBoostExtra"), 0))
end

function var_0_10.FillToCooldown(arg_14_0, arg_14_1)
	if arg_14_1 <= arg_14_0._currentEnergy then
		return 0
	else
		local var_14_0 = arg_14_0:getCurrentSpeed()
		local var_14_1 = (1 - arg_14_0._energyGenerating) / var_14_0

		if arg_14_1 - arg_14_0._currentEnergy >= 2 then
			var_14_1 = 1 / var_14_0 * (arg_14_1 - arg_14_0._currentEnergy - 1) + var_14_1
		end

		return var_14_1
	end

	return
end

return
