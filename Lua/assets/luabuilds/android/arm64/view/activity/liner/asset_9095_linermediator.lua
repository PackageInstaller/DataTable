local LinerMediator = class("LinerMediator", import("view.base.ContextMediator"))

LinerMediator.GO_SCENE = "LinerMediator.GO_SCENE"
LinerMediator.GO_SUBLAYER = "LinerMediator.GO_SUBLAYER"
LinerMediator.SET_NAME = "LinerMediator.SET_NAME"
LinerMediator.CLICK_ROOM = "LinerMediator.CLICK_ROOM"
LinerMediator.CLICK_EVENT = "LinerMediator.CLICK_EVENT"

function LinerMediator:register()
	self:bind(LinerMediator.GO_SCENE, function(arg_2_0, arg_2_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_2_1, ...)

		return
	end)
	self:bind(LinerMediator.GO_SUBLAYER, function(arg_3_0, arg_3_1, arg_3_2)
		self:addSubLayers(arg_3_1, nil, arg_3_2)

		return
	end)
	self:bind(LinerMediator.SET_NAME, function(arg_4_0, arg_4_1)
		local var_4_0 = {
			activity_id = arg_4_1.actId
		}

		var_4_0.intValue = arg_4_1.intValue or 0
		var_4_0.strValue = arg_4_1.strValue or ""
		var_4_0.callback = arg_4_1.callback

		self:sendNotification(GAME.ACTIVITY_STORE_DATE, var_4_0)

		return
	end)
	self:bind(LinerMediator.CLICK_ROOM, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.ACTIVITY_LINER_OP, {
			cmd = 1,
			activity_id = arg_5_1,
			arg1 = arg_5_2
		})

		return
	end)
	self:bind(LinerMediator.CLICK_EVENT, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.ACTIVITY_LINER_OP, {
			cmd = 1,
			activity_id = arg_6_1.actId,
			arg1 = arg_6_1.roomId,
			arg2 = arg_6_1.eventId,
			callback = arg_6_1.callback
		})

		return
	end)

	return
end

function LinerMediator:listNotificationInterests()
	return {
		GAME.ACTIVITY_LINER_OP_DONE
	}
end

function LinerMediator:handleNotification(arg_8_1)
	local var_8_0 = arg_8_1:getBody()

	if arg_8_1:getName() == GAME.ACTIVITY_LINER_OP_DONE then
		self.viewComponent:UpdateData()
		self.viewComponent:UpdateTips()
	end

	return
end

return LinerMediator
