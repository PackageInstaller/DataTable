class = var_0_10000

local var_0_0 = "SnapshotSelectCharMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.SELECT_CHAR = "SnapshotSelectCharMediator.SELECT_CHAR"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	CollectionProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = arg_1_0.viewComponent

	var_2.setShipGroups(var_1_1, var_1_0:getGroups())

	getProxy = var_2
	BayProxy = var_1_1

	local var_1_2 = var_2(var_1_1)
	local var_1_3 = arg_1_0.viewComponent

	var_3.setProposeList(var_1_3, var_1_2:getProposeGroupList())

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.bind

	SnapshotSelectCharLayer = var_6

	var_1_5(var_1_4, var_6.ON_INDEX, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_2_2 = var_2_10005.New
		local var_2_3 = {}

		CustomIndexLayer = var_2_10008
		var_2_3.viewComponent = var_2_10008
		CustomIndexMediator = var_2_10008
		var_2_3.mediator = var_2_10008
		var_2_3.data = arg_2_1

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	local var_1_6 = arg_1_0
	local var_1_7 = arg_1_0.bind

	SnapshotSelectCharLayer = var_6

	var_1_7(var_1_6, var_6.SELECT_CHAR, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0

		var_2.sendNotification(var_3_0, var_0_1.SELECT_CHAR, arg_3_1)

		return
	end)

	return
end

return var_0_1
