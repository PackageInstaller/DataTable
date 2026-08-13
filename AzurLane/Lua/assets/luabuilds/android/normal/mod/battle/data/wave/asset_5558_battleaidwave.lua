ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleAidWave = var_0_10003("BattleAidWave", var_0.Battle.BattleWaveInfo)
var_0.Battle.BattleAidWave.__name = "BattleAidWave"

local var_0_3 = var_0.Battle.BattleAidWave

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.SetWaveData(arg_2_0, arg_2_1)
	var_0_3.super.SetWaveData(arg_2_0, arg_2_1)

	arg_2_0._vanguardUnitList = arg_2_0._param.vanguard_unitList
	arg_2_0._mainUnitList = arg_2_0._param.main_unitList
	arg_2_0._subUnitList = arg_2_0._param.sub_unitList
	arg_2_0._killList = arg_2_0._param.kill_list

	return
end

function var_0_3.DoWave(arg_3_0)
	var_0_3.super.DoWave(arg_3_0)

	local var_3_0 = var_0.Battle.BattleDataProxy.GetInstance()

	if arg_3_0._killList ~= nil then
		local var_3_1 = var_3_0
		local var_3_2 = var_3_0.GetFriendlyShipList(var_3_1)

		ipairs = var_3_1

		for iter_3_0, iter_3_1 in var_3_1(arg_3_0._killList) do
			pairs = var_1_10008

			for iter_3_2, iter_3_3 in var_1_10008(var_3_2) do
				if iter_3_3:GetTemplateID() == iter_3_1 then
					iter_3_3:Retreat()
				end
			end
		end
	end

	if arg_3_0._vanguardUnitList ~= nil then
		ipairs = var_2

		for iter_3_4, iter_3_5 in var_2(arg_3_0._vanguardUnitList) do
			local var_3_3 = {}

			ipairs = var_1_10008

			for iter_3_6, iter_3_7 in var_1_10008(iter_3_5.equipment) do
				var_3_3[#var_3_3 + 1] = {
					skin = 0,
					id = iter_3_7
				}
			end

			Clone = var_1_10008
			var_1_10008 = var_1_10008(iter_3_5)
			var_1_10008.equipment = var_3_3
			var_1_10008.baseProperties = iter_3_5.properties

			local var_3_4 = var_3_0:SpawnVanguard(var_1_10008, var_0_1.FRIENDLY_CODE)

			var_3_0.InitUnitWeaponCD(var_3_4)
			var_3_0:InitAidUnitStatistics(var_3_4)
		end
	end

	if arg_3_0._mainUnitList ~= nil then
		ipairs = var_2

		for iter_3_8, iter_3_9 in var_2(arg_3_0._mainUnitList) do
			local var_3_5 = {}

			ipairs = var_1_10008

			for iter_3_10, iter_3_11 in var_1_10008(iter_3_9.equipment) do
				var_3_5[#var_3_5 + 1] = {
					skin = 0,
					id = iter_3_11
				}
			end

			Clone = var_1_10008
			var_1_10008 = var_1_10008(iter_3_9)
			var_1_10008.equipment = var_3_5
			var_1_10008.baseProperties = iter_3_9.properties

			local var_3_6 = var_3_0:SpawnMain(var_1_10008, var_0_1.FRIENDLY_CODE)

			var_3_0.InitUnitWeaponCD(var_3_6)
			var_3_0:InitAidUnitStatistics(var_3_6)
		end
	end

	if arg_3_0._subUnitList ~= nil then
		ipairs = var_2

		for iter_3_12, iter_3_13 in var_2(arg_3_0._subUnitList) do
			local var_3_7 = {}

			ipairs = var_1_10008

			for iter_3_14, iter_3_15 in var_1_10008(iter_3_13.equipment) do
				var_3_7[#var_3_7 + 1] = {
					skin = 0,
					id = iter_3_15
				}
			end

			Clone = var_1_10008
			var_1_10008 = var_1_10008(iter_3_13)
			var_1_10008.equipment = var_3_7
			var_1_10008.baseProperties = iter_3_13.properties

			local var_3_8 = var_3_0:SpawnSub(var_1_10008, var_0_1.FRIENDLY_CODE)

			var_3_0:InitAidUnitStatistics(var_3_8)
		end
	end

	arg_3_0:doPass()

	return
end

return
