local Dorm3dGameMediatorTemplate = class("Dorm3dGameMediatorTemplate", import("view.base.ContextMediator"))

Dorm3dGameMediatorTemplate.TRIGGER_FAVOR = "Dorm3dGameMediatorTemplate.TRIGGER_FAVOR"

function Dorm3dGameMediatorTemplate:register()
	self:bind(Dorm3dGameMediatorTemplate.TRIGGER_FAVOR, function(arg_2_0, arg_2_1)
		local var_2_0 = getDorm3dGameset("drom3d_favir_trigger_game")[1]

		if getProxy(ApartmentProxy).stamina < pg.dorm3d_favor_trigger[var_2_0].is_daily_max then
			self.viewComponent:ShowResultUI()

			return
		end

		self:sendNotification(GAME.APARTMENT_TRIGGER_FAVOR, {
			groupId = arg_2_1,
			triggerId = var_2_0
		})

		return
	end)

	return
end

function Dorm3dGameMediatorTemplate:listNotificationInterests()
	return {
		GAME.APARTMENT_TRIGGER_FAVOR_DONE
	}
end

function Dorm3dGameMediatorTemplate:handleNotification(arg_4_1)
	if arg_4_1:getName() == GAME.APARTMENT_TRIGGER_FAVOR_DONE then
		self.viewComponent:ShowResultUI((arg_4_1:getBody()))
	end

	return
end

function Dorm3dGameMediatorTemplate:remove()
	return
end

return Dorm3dGameMediatorTemplate
