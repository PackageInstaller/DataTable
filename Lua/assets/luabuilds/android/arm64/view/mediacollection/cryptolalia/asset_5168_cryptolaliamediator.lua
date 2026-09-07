local CryptolaliaMediator = class("CryptolaliaMediator", import("view.base.ContextMediator"))

CryptolaliaMediator.UNLOCK = "CryptolaliaMediator:UNLOCK"

function CryptolaliaMediator:register()
	self:bind(CryptolaliaMediator.UNLOCK, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.UNLOCK_CRYPTOLALIA, {
			id = arg_2_1,
			costType = arg_2_2
		})

		return
	end)
	self.viewComponent:SetCryptolaliaList(getProxy(PlayerProxy):getRawData():GetCryptolaliaList())

	return
end

function CryptolaliaMediator:listNotificationInterests()
	return {
		GAME.UNLOCK_CRYPTOLALIA_DONE
	}
end

function CryptolaliaMediator:handleNotification(arg_4_1)
	if arg_4_1:getName() == GAME.UNLOCK_CRYPTOLALIA_DONE then
		self.viewComponent:emit(CryptolaliaScene.ON_UNLOCK, arg_4_1:getBody().id)
	end

	return
end

return CryptolaliaMediator
