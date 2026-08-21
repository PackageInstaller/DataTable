local var_0_0 = class("SnapshotSelectCharMediator", import("..base.ContextMediator"))

var_0_0.SELECT_CHAR = "SnapshotSelectCharMediator.SELECT_CHAR"

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:setShipGroups(getProxy(CollectionProxy):getGroups())
	arg_1_0.viewComponent:setProposeList(getProxy(BayProxy):getProposeGroupList())
	arg_1_0:bind(SnapshotSelectCharLayer.ON_INDEX, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_2_1
		}))

		return
	end)
	arg_1_0:bind(SnapshotSelectCharLayer.SELECT_CHAR, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(var_0_0.SELECT_CHAR, arg_3_1)

		return
	end)

	return
end

return var_0_0
