ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleUnitEvent
local var_0_2 = var_0.Battle.BattleEvent
local var_0_3 = var_0.Battle.BattleCardPuzzleEvent
local var_0_4 = var_0.Battle.BattleFormulas
local var_0_5 = var_0.Battle.BattleConst
local var_0_6 = var_0.Battle.BattleConfig
local var_0_7 = var_0.Battle.BattleAttr
local var_0_8 = var_0.Battle.BattleDataFunction
local var_0_9 = var_0.Battle.BattleAttr
local var_0_10 = var_0.Battle.BattleCardPuzzleConfig

class = var_0_10011

local var_0_11 = var_0_10011("BattleFleetCardPuzzleEnergy")

var_0.Battle.BattleFleetCardPuzzleEnergy = var_0_11
var_0_11.__name = "BattleFleetCardPuzzleEnergy"

function var_0_11.Ctor(arg_1_0, arg_1_1)
	arg_1_0._client = arg_1_1

	local var_1_0 = arg_1_0._client

	arg_1_0._fleetAttr = var_2.GetAttrManager(var_1_0)

	arg_1_0:init()

	return
end

function var_0_11.CustomConfig(arg_2_0, arg_2_1)
	arg_2_0._currentEnergy = var_0_8.GetPuzzleDungeonTemplate(arg_2_1).init_energy
	arg_2_0._generateRate = var_2.energy_recovery

	return
end

function var_0_11.Dispose(arg_3_0)
	return
end

function var_0_11.GetMaxEnergy(arg_4_0)
	return arg_4_0._maxEnergy
end

function var_0_11.GetCurrentEnergy(arg_5_0)
	return arg_5_0._currentEnergy
end

function var_0_11.GetGeneratingProcess(arg_6_0)
	if arg_6_0._currentEnergy == arg_6_0._maxEnergy then
		return 1
	else
		return arg_6_0._energyGenerating
	end

	return
end

function var_0_11.ConsumeEnergy(arg_7_0, arg_7_1)
	math = var_1_10002
	arg_7_0._currentEnergy = var_1_10002.max(arg_7_0._currentEnergy - arg_7_1, 0)

	local var_7_0 = arg_7_0._client

	var_2.EnergyUpdate(var_7_0)

	if arg_7_1 > 0 then
		local var_7_1 = arg_7_0._client

		var_2.FlushHandOverheat(var_7_1)
	end

	return
end

function var_0_11.Update(arg_8_0, arg_8_1)
	arg_8_0:update(arg_8_1)

	return
end

function var_0_11.init(arg_9_0)
	arg_9_0._currentEnergy = var_0_10.baseEnergyInitial
	arg_9_0._maxEnergy = 10
	arg_9_0._generateRate = var_0_10.baseEnergyGenerateSpeedPerSecond
	arg_9_0._energyGenerating = 0

	return
end

function var_0_11.updateTimeStamp(arg_10_0)
	pg = var_1_10001

	local var_10_0 = var_1_10001.TimeMgr.GetInstance()

	arg_10_0._lastUpdateTimeStamp = var_1.GetCombatTime(var_10_0)

	return
end

function var_0_11.Start(arg_11_0)
	arg_11_0:updateTimeStamp()

	return
end

function var_0_11.update(arg_12_0, arg_12_1)
	if arg_12_0._currentEnergy < arg_12_0._maxEnergy then
		arg_12_0._energyGenerating = (arg_12_1 - arg_12_0._lastUpdateTimeStamp) * arg_12_0:getCurrentSpeed() + arg_12_0._energyGenerating

		if arg_12_0._energyGenerating >= 1 then
			arg_12_0._currentEnergy = arg_12_0._currentEnergy + 1

			local var_12_0 = arg_12_0._client

			var_5.EnergyUpdate(var_12_0)

			arg_12_0._energyGenerating = 0
		end
	end

	arg_12_0:updateTimeStamp()

	return
end

function var_0_11.getCurrentSpeed(arg_13_0)
	local var_13_0 = arg_13_0._fleetAttr
	local var_13_1 = var_1.GetCurrent(var_13_0, "BaseEnergyBoostRate")
	local var_13_2 = arg_13_0._fleetAttr
	local var_13_3 = var_2.GetCurrent(var_13_2, "BaseEnergyBoostExtra")

	math = var_13_2

	return (var_13_2.max(arg_13_0._generateRate * (1 + var_13_1) + var_13_3, 0))
end

function var_0_11.FillToCooldown(arg_14_0, arg_14_1)
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
