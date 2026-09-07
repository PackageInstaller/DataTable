local NewSkinMediator = class("NewSkinMediator", import("..base.ContextMediator"))

NewSkinMediator.SET_SKIN = "NewSkinMediator:SET_SKIN"
NewSkinMediator.ON_EXIT = "NewSkinMediator:ON_EXIT"

function NewSkinMediator:register()
	self.viewComponent:setSkin(self.contextData.skinId)
	self:bind(NewSkinMediator.SET_SKIN, function(arg_2_0, arg_2_1, arg_2_2)
		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			local var_2_0, var_2_1 = ShipPhantom.UnpackMark(iter_2_1)

			self:sendNotification(GAME.SET_SHIP_SKIN, {
				shipId = var_2_0,
				phantomId = var_2_1,
				skinId = self.contextData.skinId
			})
		end

		getProxy(SettingsProxy):SetFlagShip(arg_2_2)

		if arg_2_2 then
			local var_2_2 = getProxy(PlayerProxy):getRawData():GetShipPhantomMarks()

			var_2_2[1] = arg_2_1[1]

			self:sendNotification(GAME.CHANGE_PLAYER_ICON, {
				skinPage = true,
				after = var_2_2
			})
		end

		self.viewComponent:emit(BaseUI.ON_CLOSE)

		return
	end)

	return
end

function NewSkinMediator:listNotificationInterests()
	return {}
end

function NewSkinMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return NewSkinMediator
