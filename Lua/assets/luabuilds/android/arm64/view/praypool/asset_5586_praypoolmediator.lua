local PrayPoolMediator = class("PrayPoolMediator", import("..base.ContextMediator"))

function PrayPoolMediator:register()
	self:bind(PrayPoolConst.CLICK_INDEX_BTN, function(arg_2_0, arg_2_1)
		self:addSubLayers(Context.New({
			viewComponent = CustomIndexLayer,
			mediator = CustomIndexMediator,
			data = arg_2_1
		}))

		return
	end)
	self:bind(PrayPoolConst.CLICK_BUILD_BTN, function(arg_3_0, arg_3_1)
		self:sendNotification(PrayPoolConst.BUILD_PRAY_POOL_CMD, arg_3_1)

		return
	end)
	self:bind(PrayPoolConst.START_BUILD_SHIP_EVENT, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
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

function PrayPoolMediator:listNotificationInterests()
	return {
		PrayPoolConst.BUILD_PRAY_POOL_SUCCESS
	}
end

function PrayPoolMediator:handleNotification(arg_6_1)
	if arg_6_1:getName() == PrayPoolConst.BUILD_PRAY_POOL_SUCCESS then
		self.viewComponent:switchPage((arg_6_1:getBody()))
	end

	return
end

return PrayPoolMediator
