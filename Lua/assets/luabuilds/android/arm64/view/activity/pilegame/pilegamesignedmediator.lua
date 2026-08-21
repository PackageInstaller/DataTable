local var_0_0 = class("PileGameSignedMediator", import("...base.ContextMediator"))

var_0_0.ON_GET_AWARD = "PileGameSignedMediator:ON_GET_AWARD"
var_0_0.MINIGAME_ID = 5

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_GET_AWARD, function(arg_2_0)
		arg_1_0:sendNotification(GAME.SEND_MINI_GAME_OP, {
			hubid = var_0_0.MINIGAME_ID,
			cmd = MiniGameOPCommand.CMD_ULTIMATE,
			args1 = {}
		})

		return
	end)
	arg_1_0.viewComponent:SetData((getProxy(MiniGameProxy):GetHubByHubId(var_0_0.MINIGAME_ID)))

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		MiniGameProxy.ON_HUB_DATA_UPDATE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	if arg_4_1:getName() == MiniGameProxy.ON_HUB_DATA_UPDATE then
		arg_4_0.viewComponent:SetData((arg_4_1:getBody()))
		arg_4_0.viewComponent:UpdateSigned()
	end

	return
end

return var_0_0
