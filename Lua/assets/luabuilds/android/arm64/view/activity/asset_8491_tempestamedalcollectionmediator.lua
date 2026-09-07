local TempestaMedalCollectionMediator = class("TempestaMedalCollectionMediator", import("..base.ContextMediator"))

TempestaMedalCollectionMediator.ON_TASK_SUBMIT = "TempestaMedalCollectionMediator.ON_TASK_SUBMIT"
TempestaMedalCollectionMediator.ON_TASK_GO = "TempestaMedalCollectionMediator.ON_TASK_GO"

function TempestaMedalCollectionMediator:register()
	self:bind(TempestaMedalCollectionMediator.ON_TASK_SUBMIT, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_2_1.id)

		return
	end)
	self:bind(TempestaMedalCollectionMediator.ON_TASK_GO, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_3_1
		})

		return
	end)
	self.viewComponent:setActivity((getProxy(ActivityProxy):getActivityById(ActivityConst.PIRATE_MEDAL_ACT_ID)))

	return
end

function TempestaMedalCollectionMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.SUBMIT_TASK_DONE] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_5_1:getBody(), function()
				arg_5_0.viewComponent:updateTaskLayers()

				return
			end)

			return
		end,
		[GAME.SUBMIT_ACTIVITY_TASK_DONE] = function(arg_7_0, arg_7_1)
			arg_7_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_7_1:getBody().awards, function()
				arg_7_0.viewComponent:updateTaskLayers()

				return
			end)

			return
		end
	}

	return
end

return TempestaMedalCollectionMediator
