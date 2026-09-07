local NewEducateSelectMediator = class("NewEducateSelectMediator", import("view.base.ContextMediator"))

NewEducateSelectMediator.GO_SCENE = "NewEducateSelectMediator:GO_SCENE"
NewEducateSelectMediator.GO_SUBLAYER = "NewEducateSelectMediator.GO_SUBLAYER"
NewEducateSelectMediator.SWITCH_DIFFICULTY = "NewEducateSelectMediator.SWITCH_DIFFICULTY"

function NewEducateSelectMediator:register()
	self:bind(NewEducateSelectMediator.GO_SCENE, function(arg_2_0, arg_2_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_2_1, ...)

		return
	end)
	self:bind(NewEducateSelectMediator.GO_SUBLAYER, function(arg_3_0, arg_3_1, arg_3_2)
		self:addSubLayers(arg_3_1, nil, arg_3_2)

		return
	end)
	self:bind(NewEducateSelectMediator.SWITCH_DIFFICULTY, function(arg_4_0, arg_4_1)
		self:sendNotification(GAME.NEW_EDUCATE_REFRESH, {
			id = arg_4_1.id,
			difficulty = arg_4_1.difficulty,
			callback = arg_4_1.callback
		})

		return
	end)

	return
end

function NewEducateSelectMediator:listNotificationInterests()
	return {}
end

function NewEducateSelectMediator:handleNotification(arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()

	return
end

return NewEducateSelectMediator
