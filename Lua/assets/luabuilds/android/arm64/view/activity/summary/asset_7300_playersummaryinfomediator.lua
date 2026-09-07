local PlayerSummaryInfoMediator = class("PlayerSummaryInfoMediator", import("...base.ContextMediator"))

PlayerSummaryInfoMediator.GET_PLAYER_SUMMARY_INFO = "PlayerSummaryInfoMediator:GET_PLAYER_SUMMARY_INFO"

function PlayerSummaryInfoMediator:register()
	local var_1_0 = getProxy(ActivityProxy)

	self:bind(PlayerSummaryInfoMediator.GET_PLAYER_SUMMARY_INFO, function(arg_2_0)
		local var_2_0 = var_1_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_SUMMARY)

		if var_2_0 and not var_2_0:isEnd() then
			self:sendNotification(GAME.GET_PLAYER_SUMMARY_INFO, {
				activityId = var_2_0.id
			})
		end

		return
	end)
	self.viewComponent:setActivity((var_1_0:getActivityByType(ActivityConst.ACTIVITY_TYPE_SUMMARY)))

	local var_1_1 = getProxy(PlayerProxy)

	self.viewComponent:setPlayer(var_1_1:getData())
	self.viewComponent:setSummaryInfo((var_1_1:getSummaryInfo()))

	return
end

function PlayerSummaryInfoMediator:listNotificationInterests()
	return {
		GAME.GET_PLAYER_SUMMARY_INFO_DONE
	}
end

function PlayerSummaryInfoMediator:handleNotification(arg_4_1)
	if arg_4_1:getName() == GAME.GET_PLAYER_SUMMARY_INFO_DONE then
		self.viewComponent:setSummaryInfo((arg_4_1:getBody()))
		self.viewComponent:initSummaryInfo()
	end

	return
end

return PlayerSummaryInfoMediator
