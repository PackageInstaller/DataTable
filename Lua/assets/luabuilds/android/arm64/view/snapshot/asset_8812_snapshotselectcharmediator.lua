local SnapshotSelectCharMediator = class("SnapshotSelectCharMediator", import("..base.ContextMediator"))

SnapshotSelectCharMediator.SELECT_CHAR = "SnapshotSelectCharMediator.SELECT_CHAR"

function SnapshotSelectCharMediator:register()
	self.viewComponent:setShipGroups(getProxy(CollectionProxy):getGroups())
	self.viewComponent:setProposeList(getProxy(BayProxy):getProposeGroupList())
	self:bind(SnapshotSelectCharLayer.ON_INDEX, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_2_1
		}))

		return
	end)
	self:bind(SnapshotSelectCharLayer.SELECT_CHAR, function(arg_3_0, arg_3_1)
		self:sendNotification(SnapshotSelectCharMediator.SELECT_CHAR, arg_3_1)

		return
	end)

	return
end

return SnapshotSelectCharMediator
