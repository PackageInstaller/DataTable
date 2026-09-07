local ToLoveCollabBackHillMediator = class("ToLoveCollabBackHillMediator", import("..TemplateMV.BackHillMediatorTemplate"))

ToLoveCollabBackHillMediator.MINI_GAME = "MINI_GAME"
ToLoveCollabBackHillMediator.TASK = "TASK"
ToLoveCollabBackHillMediator.PUZZLE = "PUZZLE"
ToLoveCollabBackHillMediator.TROPHY = "TROPHY"
ToLoveCollabBackHillMediator.MINI_GAME_ID = 69

function ToLoveCollabBackHillMediator:register()
	self:BindEvent()

	return
end

function ToLoveCollabBackHillMediator:BindEvent()
	ToLoveCollabBackHillMediator.super.BindEvent(self)
	self:bind(ToLoveCollabBackHillMediator.MINI_GAME, function()
		self:sendNotification(GAME.GO_MINI_GAME, ToLoveCollabBackHillMediator.MINI_GAME_ID)

		return
	end)
	self:bind(ToLoveCollabBackHillMediator.PUZZLE, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.PUZZLE_CONNECT, {})

		return
	end)
	self:bind(ToLoveCollabBackHillMediator.TASK, function(arg_5_0, arg_5_1)
		self:addSubLayers(Context.New({
			mediator = ToLoveCollabTaskMediator,
			viewComponent = ToLoveCollabTaskScene
		}))

		return
	end)
	self:bind(ToLoveCollabBackHillMediator.TROPHY, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			mediator = MedalCollectionTemplateMediator,
			viewComponent = ToLoveCollabMedalView
		}))

		return
	end)

	return
end

function ToLoveCollabBackHillMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUBMIT_ACTIVITY_TASK_DONE
	}
end

function ToLoveCollabBackHillMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1:getBody()

	if var_8_0 == ActivityProxy.ACTIVITY_UPDATED then
		-- block empty
	elseif var_8_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:UpdateView()
	end

	return
end

return ToLoveCollabBackHillMediator
