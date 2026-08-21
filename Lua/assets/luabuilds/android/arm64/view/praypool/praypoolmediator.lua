local var_0_0 = class("PrayPoolMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0:bind(PrayPoolConst.CLICK_INDEX_BTN, function(arg_2_0, arg_2_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_2_1
		}))

		return
	end)
	arg_1_0:bind(PrayPoolConst.CLICK_BUILD_BTN, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(PrayPoolConst.BUILD_PRAY_POOL_CMD, arg_3_1)

		return
	end)
	arg_1_0:bind(PrayPoolConst.START_BUILD_SHIP_EVENT, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 2,
			buildId = arg_4_1,
			activity_id = ActivityConst.ACTIVITY_PRAY_POOL,
			arg1 = arg_4_2,
			arg2 = arg_4_3
		})

		return
	end)

	local var_1_0 = getProxy(PrayProxy)

	if var_1_0:getPageState() ~= PrayProxy.STAGE_BUILD_SUCCESS then
		local var_1_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_PRAY_POOL)

		if var_1_1 then
			local var_1_2 = var_1_1:getData1()

			if var_1_2 and table.indexof(pg.activity_ship_create.all, var_1_2, 1) then
				var_1_0:setSelectedPoolNum(var_1_2)
				var_1_0:setSelectedShipList((var_1_1:getData1List()))
				var_1_0:updatePageState(PrayProxy.STAGE_BUILD_SUCCESS)
			end
		end
	end

	return
end

function var_0_0.listNotificationInterests(arg_5_0)
	return {
		PrayPoolConst.BUILD_PRAY_POOL_SUCCESS
	}
end

function var_0_0.handleNotification(arg_6_0, arg_6_1)
	if arg_6_1:getName() == PrayPoolConst.BUILD_PRAY_POOL_SUCCESS then
		arg_6_0.viewComponent:switchPage((arg_6_1:getBody()))
	end

	return
end

return var_0_0
