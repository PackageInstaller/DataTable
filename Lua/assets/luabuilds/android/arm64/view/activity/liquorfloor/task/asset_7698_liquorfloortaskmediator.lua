local LiquorFloorTaskMediator = class("LiquorFloorTaskMediator", import("view.base.ContextMediator"))

LiquorFloorTaskMediator.ON_TASK_GO = "LiquorFloorTaskMediator::ON_TASK_GO"
LiquorFloorTaskMediator.ON_TASK_SUBMIT = "LiquorFloorTaskMediator::ON_TASK_SUBMIT"

function LiquorFloorTaskMediator:register()
	self:bind(LiquorFloorTaskMediator.ON_TASK_GO, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	self:bind(LiquorFloorTaskMediator.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_3_1.id)

		return
	end)

	return
end

function LiquorFloorTaskMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.SUBMIT_TASK_DONE] = function(arg_5_0, arg_5_1)
			arg_5_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_5_1:getBody().awards)
			arg_5_0.viewComponent:RefreshUI()

			return
		end,
		[GAME.SUBMIT_ACTIVITY_TASK_DONE] = function(arg_6_0, arg_6_1)
			arg_6_0.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_6_1:getBody().awards)
			arg_6_0.viewComponent:RefreshUI()

			return
		end
	}

	return
end

function LiquorFloorTaskMediator:remove()
	return
end

return LiquorFloorTaskMediator
