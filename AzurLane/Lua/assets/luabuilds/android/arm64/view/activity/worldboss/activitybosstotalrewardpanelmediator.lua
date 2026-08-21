local var_0_0 = class("ActivityBossTotalRewardPanelMediator", import("view.base.ContextMediator"))

var_0_0.GET_NEW_SHIP = "ActivityBossTotalRewardPanelMediator:GET_NEW_SHIP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GET_NEW_SHIP, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = NewShipMediator,
			viewComponent = NewShipLayer,
			data = {
				ship = arg_2_1
			},
			onRemoved = arg_2_2
		}))

		return
	end)
	getProxy(SettingsProxy):ResetContinuousOperationAutoSub()

	return
end

return var_0_0
