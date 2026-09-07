local NewMeixiV4Mediator = class("NewMeixiV4Mediator", import("view.base.ContextMediator"))

NewMeixiV4Mediator.ON_TASK_GO = "ON_TASK_GO"
NewMeixiV4Mediator.ON_TASK_SUBMIT = "ON_TASK_SUBMIT"
NewMeixiV4Mediator.GO_STORY = "GO_STORY"

function NewMeixiV4Mediator:register()
	self:bind(NewMeixiV4Mediator.ON_TASK_GO, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	self:bind(NewMeixiV4Mediator.ON_TASK_SUBMIT, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_3_1.id)

		return
	end)
	self:bind(NewMeixiV4Mediator.GO_STORY, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.GO_SCENE, SCENE.WORLD_COLLECTION, {
			memoryGroup = arg_4_1
		})

		return
	end)
	self.viewComponent:setPlayer(getProxy(PlayerProxy):getData())

	return
end

function NewMeixiV4Mediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		PlayerProxy.UPDATED,
		GAME.SUBMIT_TASK_DONE
	}
end

function NewMeixiV4Mediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	if var_6_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_6_1.id == ActivityConst.NEWMEIXIV4_SKIRMISH_ID then
			self.viewComponent:onUpdateTask()
		end
	elseif var_6_0 == PlayerProxy.UPDATED then
		self.viewComponent:onUpdateRes(var_6_1)
	elseif var_6_0 == GAME.SUBMIT_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_6_1, function()
			self.viewComponent:onUpdateTask()

			return
		end)
	end

	return
end

return NewMeixiV4Mediator
