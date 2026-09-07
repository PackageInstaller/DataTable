local ActivityMediator = class("ActivityMediator", import("..base.ContextMediator"))

function ActivityMediator:register()
	self.contextData.singleActivity = true

	self:bind(ActivityMediator.EVENT_OPERATION, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, arg_2_1)

		return
	end)
	self:bind(ActivityMediator.EVENT_GO_SCENE, function(arg_3_0, arg_3_1, arg_3_2)
		if arg_3_1 == SCENE.SUMMER_FEAST then
			pg.NewStoryMgr.GetInstance():Play("TIANHOUYUYI1", function()
				self:sendNotification(GAME.GO_SCENE, SCENE.SUMMER_FEAST)

				return
			end)
		else
			self:sendNotification(GAME.GO_SCENE, arg_3_1, arg_3_2)
		end

		return
	end)

	local var_1_0 = getProxy(PlayerProxy):getRawData()

	self.viewComponent:setPlayer(var_1_0)
	self.viewComponent:setFlagShip((getProxy(BayProxy):getShipById(var_1_0.character)))
	self.viewComponent:selectActivity((getProxy(ActivityProxy):getActivityById(self.contextData.id)))

	return
end

function ActivityMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_ADDED,
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityProxy.ACTIVITY_OPERATION_DONE,
		ActivityProxy.ACTIVITY_SHOW_AWARDS,
		GAME.ACT_NEW_PT_DONE,
		GAME.RETURN_AWARD_OP_DONE,
		GAME.MONOPOLY_AWARD_DONE,
		GAME.SUBMIT_TASK_DONE
	}
end

function ActivityMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == ActivityProxy.ACTIVITY_ADDED or var_6_0 == ActivityProxy.ACTIVITY_UPDATED then
		self.viewComponent:updateActivity(var_6_1)
	elseif var_6_0 == ActivityProxy.ACTIVITY_OPERATION_DONE then
		-- block empty
	elseif var_6_0 == ActivityProxy.ACTIVITY_SHOW_AWARDS or var_6_0 == GAME.ACT_NEW_PT_DONE or var_6_0 == GAME.RETURN_AWARD_OP_DONE or var_6_0 == GAME.MONOPOLY_AWARD_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awards, var_6_1.callback)
	elseif var_6_0 == GAME.SUBMIT_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1, function()
			self.viewComponent:updateTaskLayers()

			return
		end)
	elseif var_6_0 == GAME.SEND_MINI_GAME_OP_DONE then
		seriesAsync({
			function(arg_8_0)
				if #var_6_1.awards > 0 then
					if self.viewComponent then
						self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1.awards, arg_8_0)
					else
						self:emit(BaseUI.ON_ACHIEVE, var_6_1.awards, arg_8_0)
					end
				else
					arg_8_0()
				end

				return
			end
		})
	end

	return
end

return ActivityMediator
