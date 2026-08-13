class = var_0_10000

local var_0_0 = "ActivityBossActivity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.Activity"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.bossHP = 0
	arg_1_0.milestones = {}
	ActivityBossConfig = var_2
	arg_1_0.bossConfig = var_2.New({
		configId = arg_1_0:getConfig("config_id")
	})

	return
end

function var_0_1.GetBossConfig(arg_2_0)
	return arg_2_0.bossConfig
end

function var_0_1.UpdatePublicData(arg_3_0, arg_3_1)
	local var_3_0

	if not arg_3_1.boss_hp then
		var_3_0 = 0
	end

	arg_3_0.bossHP = var_3_0

	local var_3_1

	if not arg_3_1.milestones then
		var_3_1 = {}
	end

	arg_3_0.milestones = var_3_1
	arg_3_0.data2 = 1

	return
end

function var_0_1.AddStage(arg_4_0, arg_4_1)
	table = var_1_10002

	if var_1_10002.contains(arg_4_0.data1_list, arg_4_1) then
		return
	end

	table = var_2

	var_2.insert(arg_4_0.data1_list, arg_4_1)

	return
end

function var_0_1.IsOilLimit(arg_5_0, arg_5_1)
	assert = var_1_10002

	var_1_10002(arg_5_1)

	table = var_1_10002

	return var_1_10002.contains(arg_5_0.data1_list, arg_5_1)
end

function var_0_1.GetBindPtActID(arg_6_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_6_0 = var_1_10001(var_1_10002)

	return (var_1.GetActBossLinkPTActID(var_6_0, arg_6_0.id))
end

function var_0_1.GetBossHP(arg_7_0)
	return arg_7_0.bossHP
end

function var_0_1.GetMileStones(arg_8_0)
	return arg_8_0.milestones
end

function var_0_1.readyToAchieve(arg_9_0)
	return arg_9_0.data2 ~= 1
end

function var_0_1.GetTickets(arg_10_0)
	local var_10_0 = {}

	pairs = var_1_10002

	for iter_10_0, iter_10_1 in var_1_10002(arg_10_0.data1KeyValueList) do
		pairs = var_1_10007

		for iter_10_2, iter_10_3 in var_1_10007(iter_10_1) do
			local var_10_1

			if not var_10_0[iter_10_2] then
				var_10_1 = 0
			end

			var_10_0[iter_10_2] = var_10_1 + iter_10_3
		end
	end

	return var_10_0
end

function var_0_1.GetStageBonus(arg_11_0, arg_11_1)
	local var_11_0 = 0

	pairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_0.data1KeyValueList) do
		pairs = var_1_10008

		for iter_11_2, iter_11_3 in var_1_10008(iter_11_1) do
			if iter_11_2 == arg_11_1 then
				var_11_0 = var_11_0 + iter_11_3
			end
		end
	end

	return var_11_0
end

function var_0_1.checkBattleTimeInBossAct(arg_12_0)
	assert = var_1_10001

	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.getConfig(var_12_0, "type")

	ActivityConst = var_12_0

	var_1_10001(var_12_1 == var_12_0.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	if arg_12_0:isEnd() then
		return false
	end

	local var_12_2 = arg_12_0.bossConfig
	local var_12_3 = var_1.GetBattleTime(var_12_2)

	pg = var_12_2

	local var_12_4 = var_12_2.TimeMgr.GetInstance()

	return var_2.inTime(var_12_4, var_12_3)
end

function var_0_1.GetHighestScore(arg_13_0)
	return arg_13_0.data1
end

function var_0_1.UpdateHighestScore(arg_14_0, arg_14_1)
	if arg_14_1 <= arg_14_0.data1 then
		return false
	end

	arg_14_0.data1 = arg_14_1

	return true
end

function var_0_1.GetHistoryBuffs(arg_15_0)
	return arg_15_0.data2_list
end

function var_0_1.UpdateHistoryBuffs(arg_16_0, arg_16_1)
	arg_16_0.data2_list = arg_16_1

	return
end

return var_0_1
