local CrusingWindowMediator = class("CrusingWindowMediator", import("view.base.ContextMediator"))

CrusingWindowMediator.GO_CRUSING = "CrusingWindowMediator.GO_CRUSING"

function CrusingWindowMediator:register()
	self:bind(CrusingWindowMediator.GO_CRUSING, function(arg_2_0)
		self.contextData.onClose = nil

		self.viewComponent:closeView()
		self:sendNotification(GAME.GO_SCENE, SCENE.CRUSING)

		return
	end)

	return
end

function CrusingWindowMediator:listNotificationInterests()
	return {}
end

function CrusingWindowMediator:remove()
	if self.contextData.onClose then
		self.contextData.onClose()
	end

	return
end

function CrusingWindowMediator:handleNotification(arg_5_1)
	local var_5_0 = arg_5_1:getName()
	local var_5_1 = arg_5_1:getBody()

	return
end

return CrusingWindowMediator
