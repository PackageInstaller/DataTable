local MallMapMediator = class("MallMapMediator", import("view.base.ContextMediator"))

MallMapMediator.CHANGE_SCENE = "MallMapMediator.CHANGE_SCENE"
MallMapMediator.GO_SCENE = "MallMapMediator.GO_SCENE"
MallMapMediator.GO_SUBLAYER = "MallMapMediator.GO_SUBLAYER"
MallMapMediator.TRIGGER_POINT = "MallMapMediator.TRIGGER_POINT"

function MallMapMediator:register()
	self:bind(MallMapMediator.CHANGE_SCENE, function(arg_2_0, arg_2_1, ...)
		self:sendNotification(GAME.CHANGE_SCENE, arg_2_1, ...)

		return
	end)
	self:bind(MallMapMediator.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	self:bind(MallMapMediator.GO_SUBLAYER, function(arg_4_0, arg_4_1, arg_4_2)
		self:addSubLayers(arg_4_1, nil, arg_4_2)

		return
	end)
	self:bind(MallMapMediator.TRIGGER_POINT, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.ACTIVITY_MALL_OP, {
			activity_id = arg_5_1,
			cmd = ActivityMallOPCommand.CMD.TRIGGER_POINT,
			arg1 = arg_5_2
		})

		return
	end)

	return
end

function MallMapMediator:listNotificationInterests()
	return {
		GAME.ACTIVITY_MALL_OP_DONE
	}
end

function MallMapMediator:handleNotification(arg_7_1)
	if arg_7_1:getName() == GAME.ACTIVITY_MALL_OP_DONE and arg_7_1:getBody().cmd == ActivityMallOPCommand.CMD.TRIGGER_POINT then
		self.viewComponent:UpdateData()
		self.viewComponent:UpdateView()
	end

	return
end

return MallMapMediator
