local AnniversaryIslandStoreHouse2023Mediator = class("AnniversaryIslandStoreHouse2023Mediator", import("view.base.ContextMediator"))

function AnniversaryIslandStoreHouse2023Mediator:register()
	self:bind(WorkBenchItemDetailMediator.SHOW_DETAIL, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			mediator = WorkBenchItemDetailMediator,
			viewComponent = WorkBenchItemDetailLayer,
			data = {
				material = arg_2_1
			}
		}))

		return
	end)
	self.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)))

	return
end

function AnniversaryIslandStoreHouse2023Mediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.WORKBENCH_ITEM_GO
	}
end

function AnniversaryIslandStoreHouse2023Mediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_4_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG then
			self.viewComponent:SetActivity(var_4_1)
			self.viewComponent:UpdateView()
		end
	elseif var_4_0 == GAME.WORKBENCH_ITEM_GO then
		self.viewComponent:closeView()
	end

	return
end

function AnniversaryIslandStoreHouse2023Mediator:remove()
	return
end

return AnniversaryIslandStoreHouse2023Mediator
