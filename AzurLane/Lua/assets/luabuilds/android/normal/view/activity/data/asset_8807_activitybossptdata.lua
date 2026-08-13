class = var_0_10000

local var_0_0 = "ActivityBossPtData"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".ActivityPtData"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_1
	local var_1_1 = arg_1_1.getDataConfig(var_1_0, "link_id")

	getProxy = var_1_0
	ActivityProxy = var_4

	local var_1_2 = var_1_0(var_4)
	local var_1_3 = var_3.getActivityById(var_1_2, var_1_1)
	local var_1_4 = var_3.getConfig(var_1_3, "config_id")

	pg = var_1_3

	local var_1_5 = var_1_3.activity_event_worldboss[var_1_4]

	assert = var_6

	var_6(var_1_5, "miss activity_event_worldboss config, ID: " .. var_1_4)

	arg_1_0.linkID = var_1_1
	arg_1_0.progress_target = var_1_5.reward_pt

	return
end

function var_0_1.GetBossProgress(arg_2_0)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_0.getTargetLevel(var_2_0)

	getProxy = var_2_0
	ActivityProxy = var_1_10003

	local var_2_2 = var_2_0(var_1_10003)
	local var_2_3 = var_2.getActivityById(var_2_2, arg_2_0.linkID)
	local var_2_4 = 0

	if var_2_3 and not var_2_3:isEnd() then
		var_2_4 = var_2_3:GetBossHP() or 0
	end

	return var_2_4, arg_2_0.progress_target[var_2_1]
end

function var_0_1.CanGetAward(arg_3_0)
	local function var_3_0()
		local var_4_0 = arg_3_0
		local var_4_1, var_4_2, var_4_3 = var_0.GetResProgress(var_4_0)

		return var_4_3 >= 1
	end

	local var_3_1, var_3_2 = arg_3_0:GetBossProgress()
	local var_3_3

	if arg_3_0:CanGetNextAward() and var_3_0() then
		var_3_3 = var_3_1 <= var_3_2
	end

	return var_3_3
end

return var_0_1
