local ActivityBeUpdatedCommand = class("ActivityBeUpdatedCommand", pm.SimpleCommand)

function ActivityBeUpdatedCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody().activity

	if var_1_0:getConfig("type") == ActivityConst.ACTIVITY_TYPE_PT_BUFF and self:IsLinkVoteAct(var_1_0) then
		local var_1_1 = ActivityPtData.New(var_1_0)

		if var_1_1:CanGetAward() then
			self:sendNotification(GAME.ACT_NEW_PT, {
				cmd = 4,
				activity_id = var_1_1:GetId(),
				arg1 = var_1_1:GetCurrTarget()
			})
		end
	end

	return
end

function ActivityBeUpdatedCommand:IsLinkVoteAct(arg_2_1)
	local var_2_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.VOTE_ENTRANCE_ACT_ID)

	if var_2_0 and not var_2_0:isEnd() then
		return arg_2_1.id == var_2_0:getConfig("config_client")[1]
	end

	return false
end

return ActivityBeUpdatedCommand
