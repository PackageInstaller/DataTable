local IslandFlowerFieldMediator = class("IslandFlowerFieldMediator", import("..base.ContextMediator"))

IslandFlowerFieldMediator.GET_FLOWER_AWARD = "IslandFlowerFieldMediator.GET_FLOWER_AWARD"

function IslandFlowerFieldMediator:register()
	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_FLOWER_FIELD)

	self.viewComponent:setActivity(var_1_0)
	self:bind(IslandFlowerFieldMediator.GET_FLOWER_AWARD, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.ISLAND_FLOWER_GET, {
			act_id = var_1_0.id,
			isAuto = arg_2_1
		})

		return
	end)

	return
end

function IslandFlowerFieldMediator:listNotificationInterests()
	return {
		GAME.ISLAND_FLOWER_GET_DONE,
		ActivityProxy.ACTIVITY_UPDATED
	}
end

function IslandFlowerFieldMediator:handleNotification(arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == GAME.ISLAND_FLOWER_GET_DONE then
		if #var_4_1.awards > 0 then
			if var_4_1.isAuto then
				self:addSubLayers(Context.New({
					mediator = SixthAnniversaryIslandFlowerWindowMediator,
					viewComponent = SixthAnniversaryIslandFlowerWindowLayer,
					data = {
						awards = var_4_1.awards,
						name = pg.ship_data_statistics[self.contextData.shipConfigId].name
					}
				}))
			else
				self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_4_1.awards)
			end
		end
	elseif var_4_0 == ActivityProxy.ACTIVITY_UPDATED and var_4_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_FLOWER_FIELD then
		self.viewComponent:setActivity(var_4_1)
		self.viewComponent:refreshDisplay()
	end

	return
end

return IslandFlowerFieldMediator
