local LiquorFloorBookMediator = class("LiquorFloorBookMediator", import("view.base.ContextMediator"))

LiquorFloorBookMediator.ON_GET_TASK = "LiquorFloorBookMediator:ON_GET_TASK"
LiquorFloorBookMediator.ACT_ID = ActivityConst.LiquorFloor_ACT_ID

function LiquorFloorBookMediator:register()
	self:bind(LiquorFloorBookMediator.ON_GET_TASK, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_2_1)

		return
	end)

	return
end

function LiquorFloorBookMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_TASK_AWARD_DOWN
	}
end

function LiquorFloorBookMediator:handleNotification(arg_4_1)
	if arg_4_1:getName() == GAME.SUBMIT_TASK_AWARD_DOWN then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, arg_4_1:getBody().awards, function()
			self.viewComponent:updateAwardPanel()
			self.viewComponent:updateTag()

			return
		end)
	end

	return
end

return LiquorFloorBookMediator
