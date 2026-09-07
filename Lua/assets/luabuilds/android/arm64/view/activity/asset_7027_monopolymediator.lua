local MonopolyPtMediator = class("MonopolyPtMediator", import("view.base.ContextMediator"))

MonopolyPtMediator.ON_START = "MonopolyGame:ON_START"
MonopolyPtMediator.ON_MOVE = "MonopolyGame:ON_MOVE"
MonopolyPtMediator.ON_TRIGGER = "MonopolyGame:ON_TRIGGER"
MonopolyPtMediator.ON_AWARD = "MonopolyGame:ON_AWARD"
MonopolyPtMediator.MONOPOLY_OP_LAST = "MonopolyGame:MONOPOLY_OP_LAST"
MonopolyPtMediator.ON_STOP = "MonopolyGame:MONOPOLY_ON_STOP"
MonopolyPtMediator.AWARDS = {}

function MonopolyPtMediator:register()
	self:bind(MonopolyPtMediator.ON_STOP, function(arg_2_0, arg_2_1, arg_2_2)
		if not self.viewComponent.autoFlag and #MonopolyPtMediator.AWARDS > 0 then
			self:emit(BaseUI.ON_ACHIEVE, MonopolyPtMediator.AWARDS, arg_2_2)

			MonopolyPtMediator.AWARDS = {}
		end

		return
	end)
	self:bind(MonopolyPtMediator.MONOPOLY_OP_LAST, function(arg_3_0, arg_3_1, arg_3_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_3_1,
			cmd = ActivityConst.MONOPOLY_OP_LAST,
			callback = arg_3_2
		})

		return
	end)
	self:bind(MonopolyPtMediator.ON_START, function(arg_4_0, arg_4_1, arg_4_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_4_1,
			cmd = ActivityConst.MONOPOLY_OP_THROW,
			callback = arg_4_2
		})

		return
	end)
	self:bind(MonopolyPtMediator.ON_MOVE, function(arg_5_0, arg_5_1, arg_5_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_5_1,
			cmd = ActivityConst.MONOPOLY_OP_MOVE,
			callback = arg_5_2
		})

		return
	end)
	self:bind(MonopolyPtMediator.ON_TRIGGER, function(arg_6_0, arg_6_1, arg_6_2)
		pg.m02:sendNotification(GAME.MONOPOLY_OP, {
			activity_id = arg_6_1,
			cmd = ActivityConst.MONOPOLY_OP_TRIGGER,
			callback = arg_6_2
		})

		return
	end)
	self:bind(MonopolyPtMediator.ON_AWARD, function(arg_7_0)
		self:emit(ActivityMediator.EVENT_GO_SCENE, SCENE.REDPACKEY)

		return
	end)

	self._configId = self.contextData.configId
	self._activityId = self.contextData.activityId
	self._activity = getProxy(ActivityProxy):getActivityById(self._activityId)

	self.viewComponent:firstUpdata(self._activity)

	if not self.viewComponent.autoFlag and #MonopolyPtMediator.AWARDS > 0 then
		self:emit(BaseUI.ON_ACHIEVE, MonopolyPtMediator.AWARDS, function()
			return
		end)

		MonopolyPtMediator.AWARDS = {}
	end

	return
end

function MonopolyPtMediator.getLeftRpCount()
	local var_9_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_MONOPOLY)

	return var_9_0.data2_list[1] - var_9_0.data2_list[2]
end

function MonopolyPtMediator:onAward(arg_10_1, arg_10_2)
	for iter_10_0 = 1, #arg_10_1 do
		table.insert(MonopolyPtMediator.AWARDS, arg_10_1[iter_10_0])
	end

	if self.viewComponent.autoFlag then
		self.viewComponent:addAwards(arg_10_1)

		if arg_10_2 then
			arg_10_2()
		end
	else
		self:emit(BaseUI.ON_ACHIEVE, MonopolyPtMediator.AWARDS, arg_10_2)

		MonopolyPtMediator.AWARDS = {}
	end

	return
end

function MonopolyPtMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityProxy.ACTIVITY_ADDED,
		GAME.MONOPOLY_AWARD_DONE
	}
end

function MonopolyPtMediator:handleNotification(arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1:getBody()
	local var_12_2 = arg_12_1:getType()

	if var_12_0 == ActivityProxy.ACTIVITY_UPDATED or var_12_0 == ActivityProxy.ACTIVITY_ADDED then
		self:updateGameUI()
	elseif var_12_0 == GAME.MONOPOLY_AWARD_DONE then
		if self._activity:getConfig("type") == ActivityConst.ACTIVITY_TYPE_MONOPOLY and self.viewComponent.onAward then
			self.viewComponent:onAward(var_12_1.awards, var_12_1.callback)
		else
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_12_1.awards, var_12_1.callback)
		end
	end

	return
end

function MonopolyPtMediator:updateGameUI()
	if not self._activityId then
		return
	end

	self._activity = getProxy(ActivityProxy):getActivityById(self._activityId)

	self.viewComponent:updataActivity(self._activity)

	return
end

function MonopolyPtMediator:remove()
	if self.viewComponent then
		MonopolyPtMediator.AWARDS = {}
	end

	return
end

return MonopolyPtMediator
