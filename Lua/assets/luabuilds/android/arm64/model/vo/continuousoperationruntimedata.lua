local var_0_0 = class("ContinuousOperationRuntimeData")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in pairs(arg_1_1) do
		arg_1_0[iter_1_0] = iter_1_1
	end

	arg_1_0.system = arg_1_1.system
	arg_1_0.totalBattleTime = arg_1_1.battleTime
	arg_1_0.battleTime = arg_1_1.battleTime
	arg_1_0.drops = {}
	arg_1_0.settlementDrops = {}
	arg_1_0.events = {
		{},
		{},
		{}
	}
	arg_1_0.active = nil

	return
end

function var_0_0.GetSystem(arg_2_0)
	return arg_2_0.system
end

function var_0_0.GetTotalBattleTime(arg_3_0)
	return arg_3_0.totalBattleTime
end

function var_0_0.GetRestBattleTime(arg_4_0)
	return arg_4_0.battleTime
end

function var_0_0.ConsumeBattleTime(arg_5_0)
	arg_5_0.battleTime = arg_5_0.battleTime - 1

	return
end

function var_0_0.IsFirstBattle(arg_6_0)
	return arg_6_0:GetTotalBattleTime() == arg_6_0:GetRestBattleTime()
end

function var_0_0.GetDrops(arg_7_0)
	return arg_7_0.drops
end

function var_0_0.GetSettlementDrops(arg_8_0)
	return arg_8_0.settlementDrops
end

function var_0_0.MergeDrops(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.drops = table.mergeArray(arg_9_0.drops, arg_9_1)
	arg_9_0.settlementDrops = table.mergeArray(arg_9_0.settlementDrops, arg_9_2)

	return
end

function var_0_0.MergeEvents(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	arg_10_0.events[1] = table.merge(arg_10_0.events[1], arg_10_1 or {})
	arg_10_0.events[2] = table.merge(arg_10_0.events[2], arg_10_2 or {})
	arg_10_0.events[3] = table.merge(arg_10_0.events[3], arg_10_3 or {})

	return
end

function var_0_0.GetEvents(arg_11_0, arg_11_1)
	return arg_11_0.events[arg_11_1]
end

function var_0_0.TryActivate(arg_12_0)
	if arg_12_0.active ~= nil then
		return
	end

	arg_12_0.active = true

	return
end

function var_0_0.Stop(arg_13_0, arg_13_1)
	arg_13_0.active = false
	arg_13_0.stopReason = arg_13_1 or ChapterConst.AUTOFIGHT_STOP_REASON.UNKNOWN

	return
end

function var_0_0.IsActive(arg_14_0)
	return tobool(arg_14_0.active)
end

return var_0_0
