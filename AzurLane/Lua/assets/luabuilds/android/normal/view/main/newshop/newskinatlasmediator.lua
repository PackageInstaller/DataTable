class = var_0_10000

local var_0_0 = "NewSkinAtlasMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.OPEN_SHOW_LAYER = "NewSkinAtlasMediator.OPEN_SHOW_LAYER"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.OPEN_SHOW_LAYER, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_2_2 = var_2_10004.New
		local var_2_3 = {}

		NewSkinShowLayer = var_2_10006
		var_2_3.viewComponent = var_2_10006
		NewSkinShowMediator = var_2_10006
		var_2_3.mediator = var_2_10006
		var_2_3.data = {
			skin = arg_2_1
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	PlayerProxy = var_1_10002
	var_3_0[1] = var_1_10002.UPDATED

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	PlayerProxy = var_4_1

	if var_4_0 == var_4_1.UPDATED then
		local var_4_3 = arg_4_0.viewComponent

		var_4.SetResource(var_4_3)
	end

	return
end

return var_0_1
