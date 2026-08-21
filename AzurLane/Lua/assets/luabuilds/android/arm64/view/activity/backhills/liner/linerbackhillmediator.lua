local var_0_0 = class("LinerBackHillMediator", import("..TemplateMV.BackHillMediatorTemplate"))

var_0_0.GO_MINIGAME = "GO_MINIGAME"

function var_0_0.register(arg_1_0)
	arg_1_0:BindEvent()
	arg_1_0:bind(var_0_0.GO_MINIGAME, function(arg_2_0, arg_2_1, ...)
		arg_1_0:sendNotification(GAME.GO_MINI_GAME, arg_2_1, ...)

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_3_0)
	arg_3_0.handleDic = {
		[GAME.ACTIVITY_LINER_OP_DONE] = function(arg_4_0, arg_4_1)
			arg_4_0.viewComponent:UpdateView()

			return
		end
	}

	return
end

return var_0_0
