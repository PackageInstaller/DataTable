class = var_0_10000

local var_0_0 = "AtelierStoreBaseMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	AtelierMaterialDetailMediator = var_1_10003

	var_1_1(var_1_0, var_1_10003.SHOW_DETAIL, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_2_1:GetVersion()
		local var_2_1

		if var_2_0 == 1 then
			AtelierMaterialDetailLayer = var_2_1
		else
			AtelierMaterialDetailYumiaLayer = var_2_1
		end

		local var_2_2 = arg_1_0
		local var_2_3 = var_4.addSubLayers

		Context = var_2_10006

		local var_2_4 = var_2_10006.New
		local var_2_5 = {}

		AtelierMaterialDetailMediator = var_2_10008
		var_2_5.mediator = var_2_10008
		var_2_5.viewComponent = var_2_1
		var_2_5.data = {
			material = arg_2_1
		}

		var_2_3(var_2_2, var_2_4(var_2_5))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	AtelierCompositeMediator = var_1_10002
	var_3_0[1] = var_1_10002.OPEN_FORMULA

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	AtelierCompositeMediator = var_4_1

	if var_4_0 == var_4_1.OPEN_FORMULA then
		local var_4_3 = arg_4_0.viewComponent

		var_4.closeView(var_4_3)
	end

	return
end

return var_0_1
