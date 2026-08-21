local var_0_0 = class("ActivityBossActivity", import("model.vo.Activity"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.bossHP = 0
	arg_1_0.milestones = {}
	arg_1_0.bossConfig = ActivityBossConfig.New({
		configId = arg_1_0:getConfig("config_id")
	})

	return
end

function var_0_0.GetBossConfig(arg_2_0)
	return arg_2_0.bossConfig
end

function var_0_0.UpdatePublicData(arg_3_0, arg_3_1)
	arg_3_0.bossHP = arg_3_1.boss_hp or 0
	arg_3_0.milestones = arg_3_1.milestones or {}
	arg_3_0.data2 = 1

	return
end

function var_0_0.AddStage(arg_4_0, arg_4_1)
	if table.contains(arg_4_0.data1_list, arg_4_1) then
		return
	end

	table.insert(arg_4_0.data1_list, arg_4_1)

	return
end

function var_0_0.IsOilLimit(arg_5_0, arg_5_1)
	assert(arg_5_1)

	return table.contains(arg_5_0.data1_list, arg_5_1)
end

function var_0_0.GetBindPtActID(arg_6_0)
	return (getProxy(ActivityProxy):GetActBossLinkPTActID(arg_6_0.id))
end

function var_0_0.GetBossHP(arg_7_0)
	return arg_7_0.bossHP
end

function var_0_0.GetMileStones(arg_8_0)
	return arg_8_0.milestones
end

function var_0_0.readyToAchieve(arg_9_0)
	return arg_9_0.data2 ~= 1
end

function var_0_0.GetTickets(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0.data1KeyValueList) do
		for iter_10_2, iter_10_3 in pairs(iter_10_1) do
			local var_10_0 = ({})[iter_10_2]

			if not ({})[iter_10_2] then
				var_10_0 = 0
			end

			;({})[iter_10_2] = var_10_0 + iter_10_3
		end
	end

	return {}
end

function var_0_0.GetStageBonus(arg_11_0, arg_11_1)
	local var_11_0 = 0

	for iter_11_0, iter_11_1 in pairs(arg_11_0.data1KeyValueList) do
		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			if iter_11_2 == arg_11_1 then
				var_11_0 = var_11_0 + iter_11_3
			end
		end
	end

	return var_11_0
end

function var_0_0.checkBattleTimeInBossAct(arg_12_0)
	assert(arg_12_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2)

	if arg_12_0:isEnd() then
		return false
	end

	return pg.TimeMgr.GetInstance():inTime((arg_12_0.bossConfig:GetBattleTime()))
end

function var_0_0.GetHighestScore(arg_13_0)
	return arg_13_0.data1
end

function var_0_0.UpdateHighestScore(arg_14_0, arg_14_1)
	if arg_14_1 <= arg_14_0.data1 then
		return false
	end

	arg_14_0.data1 = arg_14_1

	return true
end

function var_0_0.GetHistoryBuffs(arg_15_0)
	return arg_15_0.data2_list
end

function var_0_0.UpdateHistoryBuffs(arg_16_0, arg_16_1)
	arg_16_0.data2_list = arg_16_1

	return
end

return var_0_0
