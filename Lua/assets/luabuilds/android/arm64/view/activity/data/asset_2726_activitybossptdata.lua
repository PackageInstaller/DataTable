local ActivityBossPtData = class("ActivityBossPtData", import(".ActivityPtData"))

function ActivityBossPtData:Ctor(arg_1_1)
	ActivityBossPtData.super.Ctor(self, arg_1_1)

	local var_1_0 = arg_1_1:getDataConfig("link_id")
	local var_1_1 = getProxy(ActivityProxy):getActivityById(var_1_0):getConfig("config_id")

	assert(pg.activity_event_worldboss[var_1_1], "miss activity_event_worldboss config, ID: " .. var_1_1)

	self.linkID = var_1_0
	self.progress_target = pg.activity_event_worldboss[var_1_1].reward_pt

	return
end

function ActivityBossPtData:GetBossProgress()
	local var_2_0 = getProxy(ActivityProxy):getActivityById(self.linkID)

	return (var_2_0 and not var_2_0:isEnd() or nil) and (var_2_0:GetBossHP() or 0), self.progress_target[self:getTargetLevel()]
end

function ActivityBossPtData:CanGetAward()
	local var_3_0, var_3_1 = self:GetBossProgress()

	return self:CanGetNextAward() and (function()
		local var_4_0, var_4_1, var_4_2 = self:GetResProgress()

		return var_4_2 >= 1
	end)() and var_3_0 <= var_3_1
end

return ActivityBossPtData
