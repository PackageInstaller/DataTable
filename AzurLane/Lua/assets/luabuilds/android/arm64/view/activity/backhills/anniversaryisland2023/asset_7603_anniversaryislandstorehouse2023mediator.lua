class = var_0_10000

local var_0_0 = "AnniversaryIslandStoreHouse2023Mediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	WorkBenchItemDetailMediator = var_1_10004

	var_1_1(var_1_0, var_1_10004.SHOW_DETAIL, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_2_2 = var_2_10005.New
		local var_2_3 = {}

		WorkBenchItemDetailMediator = var_2_10008
		var_2_3.mediator = var_2_10008
		WorkBenchItemDetailLayer = var_2_10008
		var_2_3.viewComponent = var_2_10008
		var_2_3.data = {
			material = arg_2_1
		}

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	getProxy = var_1_1
	ActivityProxy = var_1_0

	local var_1_2 = var_1_1(var_1_0)
	local var_1_3 = var_1.getActivityByType

	ActivityConst = var_4

	local var_1_4 = var_1_3(var_1_2, var_4.ACTIVITY_TYPE_VIRTUAL_BAG)
	local var_1_5 = arg_1_0.viewComponent

	var_2.SetActivity(var_1_5, var_1_4)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	ActivityProxy = var_1_10002
	var_3_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_3_0[2] = var_2.WORKBENCH_ITEM_GO

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1
	local var_4_1 = arg_4_1.getName(var_4_0)
	local var_4_2 = arg_4_1
	local var_4_3 = arg_4_1.getBody(var_4_2)

	ActivityProxy = var_4_0

	local var_4_4

	if var_4_1 == var_4_0.ACTIVITY_UPDATED then
		var_4_4 = var_4_3:getConfig("type")
		ActivityConst = var_4_2

		if var_4_4 == var_4_2.ACTIVITY_TYPE_VIRTUAL_BAG then
			local var_4_5 = arg_4_0.viewComponent

			var_4_4.SetActivity(var_4_5, var_4_3)

			local var_4_6 = arg_4_0.viewComponent

			var_4_4.UpdateView(var_4_6)
		end
	else
		GAME = var_4_4

		if var_4_1 == var_4_4.WORKBENCH_ITEM_GO then
			local var_4_7 = arg_4_0.viewComponent

			var_4.closeView(var_4_7)
		end
	end

	return
end

function var_0_1.remove(arg_5_0)
	return
end

return var_0_1
