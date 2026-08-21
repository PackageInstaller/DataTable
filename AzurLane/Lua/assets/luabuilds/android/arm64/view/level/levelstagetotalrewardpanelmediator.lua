local var_0_0 = class("LevelStageTotalRewardPanelMediator", import("view.base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:bind(LevelMediator2.ON_RETRACKING, function(arg_2_0, ...)
		arg_1_0:sendNotification(LevelMediator2.ON_RETRACKING, (packEx(...)))

		return
	end)

	return
end

return var_0_0
