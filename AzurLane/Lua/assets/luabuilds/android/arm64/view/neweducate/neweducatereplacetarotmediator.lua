local var_0_0 = class("NewEducateReplaceTarotMediator", import("view.newEducate.base.NewEducateContextMediator"))

var_0_0.ON_REPLACE_TAROT = "NewEducateReplaceTarotMediator.ON_REPLACE_TAROT"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_REPLACE_TAROT, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.NEW_EDUCATE_REPLACE_TAROT, {
			id = arg_1_0.contextData.char.id,
			tarotId = arg_2_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.NEW_EDUCATE_REPLACE_TAROT_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	if arg_4_1:getName() == GAME.NEW_EDUCATE_REPLACE_TAROT_DONE then
		arg_4_0.viewComponent:OnReplaceDone((arg_4_1:getBody()))
	end

	return
end

return var_0_0
