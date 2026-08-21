local var_0_0 = class("AnniversaryIslandStoreHouse2023Mediator", import("view.base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:bind(WorkBenchItemDetailMediator.SHOW_DETAIL, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = WorkBenchItemDetailMediator,
			viewComponent = WorkBenchItemDetailLayer,
			data = {
				material = arg_2_1
			}
		}))

		return
	end)
	arg_1_0.viewComponent:SetActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG)))

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.WORKBENCH_ITEM_GO
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_4_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_VIRTUAL_BAG then
			arg_4_0.viewComponent:SetActivity(var_4_1)
			arg_4_0.viewComponent:UpdateView()
		end
	elseif var_4_0 == GAME.WORKBENCH_ITEM_GO then
		arg_4_0.viewComponent:closeView()
	end

	return
end

function var_0_0.remove(arg_5_0)
	return
end

return var_0_0
