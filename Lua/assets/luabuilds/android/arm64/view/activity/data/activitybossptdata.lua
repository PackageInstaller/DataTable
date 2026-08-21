local var_0_0 = class("ActivityBossPtData", import(".ActivityPtData"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_1:getDataConfig("link_id")
	local var_1_1 = getProxy(ActivityProxy):getActivityById(var_1_0):getConfig("config_id")

	assert(pg.activity_event_worldboss[var_1_1], "miss activity_event_worldboss config, ID: " .. var_1_1)

	arg_1_0.linkID = var_1_0
	arg_1_0.progress_target = pg.activity_event_worldboss[var_1_1].reward_pt

	return
end

function var_0_0.GetBossProgress(arg_2_0)
	local var_2_0 = getProxy(ActivityProxy):getActivityById(arg_2_0.linkID)
	local var_2_1 = 0

	if var_2_0 and not var_2_0:isEnd() then
		var_2_1 = var_2_0:GetBossHP() or 0
	end

	return var_2_1, arg_2_0.progress_target[arg_2_0:getTargetLevel()]
end

function var_0_0.CanGetAward(arg_3_0)
	local var_3_0, var_3_1 = arg_3_0:GetBossProgress()

	return arg_3_0:CanGetNextAward() and (function()
		local var_4_0, var_4_1, var_4_2 = arg_3_0:GetResProgress()

		return var_4_2 >= 1
	end)() and var_3_0 <= var_3_1
end

return var_0_0
