class = var_0_10000

local var_0_0 = "IslandOtherCardPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandSelfCardPage"))

function var_0_1.OnShow(arg_1_0, arg_1_1)
	arg_1_0.userId = arg_1_1

	var_0_1.super.OnShow(arg_1_0)

	return
end

function var_0_1.GetContext(arg_2_0)
	Context = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = {}

	IslandOtherCardMediator = var_1_10004
	var_2_1.mediator = var_1_10004
	IslandOtherCardAttach = var_1_10004
	var_2_1.viewComponent = var_1_10004
	var_2_1.data = {
		isIslandPage = true,
		container = arg_2_0._tf,
		onClose = function()
			local var_3_0 = arg_2_0

			var_0.Hide(var_3_0)

			return
		end,
		userId = arg_2_0.userId
	}

	return var_2_0(var_2_1)
end

return var_0_1
