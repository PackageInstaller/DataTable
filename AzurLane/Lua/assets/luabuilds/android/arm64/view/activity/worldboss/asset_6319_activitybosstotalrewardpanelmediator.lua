class = var_0_10000

local var_0_0 = "ActivityBossTotalRewardPanelMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.GET_NEW_SHIP = "ActivityBossTotalRewardPanelMediator:GET_NEW_SHIP"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.GET_NEW_SHIP, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_2_2 = var_2_10006.New
		local var_2_3 = {}

		NewShipMediator = var_2_10009
		var_2_3.mediator = var_2_10009
		NewShipLayer = var_2_10009
		var_2_3.viewComponent = var_2_10009
		var_2_3.data = {
			ship = arg_2_1
		}
		var_2_3.onRemoved = arg_2_2

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	getProxy = var_1
	SettingsProxy = var_1_0

	local var_1_1 = var_1(var_1_0)

	var_1.ResetContinuousOperationAutoSub(var_1_1)

	return
end

return var_0_1
