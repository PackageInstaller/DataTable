local TechnologyMediator = class("TechnologyMediator", import("..base.ContextMediator"))

TechnologyMediator.ON_START = "TechnologyMediator:ON_START"
TechnologyMediator.ON_FINISHED = "TechnologyMediator:ON_FINISHED"
TechnologyMediator.ON_REFRESH = "TechnologyMediator:ON_REFRESH"
TechnologyMediator.ON_STOP = "TechnologyMediator:ON_STOP"
TechnologyMediator.ON_JOIN_QUEUE = "TechnologyMediator:ON_JOIN_QUEUE"
TechnologyMediator.ON_FINISH_QUEUE = "TechnologyMediator:ON_FINISH_QUEUE"
TechnologyMediator.ON_CLICK_SETTINGS_BTN = "TechnologyMediator:ON_CLICK_SETTINGS_BTN"

function TechnologyMediator:register()
	self:bind(TechnologyMediator.ON_START, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.START_TECHNOLOGY, {
			id = arg_2_1.id,
			pool_id = arg_2_1.pool_id
		})

		return
	end)
	self:bind(TechnologyMediator.ON_FINISHED, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.FINISH_TECHNOLOGY, {
			id = arg_3_1.id,
			pool_id = arg_3_1.pool_id
		})

		return
	end)
	self:bind(TechnologyMediator.ON_REFRESH, function(arg_4_0)
		self:sendNotification(GAME.REFRESH_TECHNOLOGYS)

		return
	end)
	self:bind(TechnologyMediator.ON_STOP, function(arg_5_0, arg_5_1)
		self:sendNotification(GAME.STOP_TECHNOLOGY, {
			id = arg_5_1.id,
			pool_id = arg_5_1.pool_id
		})

		return
	end)
	self:bind(TechnologyMediator.ON_JOIN_QUEUE, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.JOIN_QUEUE_TECHNOLOGY, {
			id = arg_6_1.id,
			pool_id = arg_6_1.pool_id
		})

		return
	end)
	self:bind(TechnologyMediator.ON_FINISH_QUEUE, function(arg_7_0)
		self:sendNotification(GAME.FINISH_QUEUE_TECHNOLOGY)

		return
	end)
	self:bind(TechnologyMediator.ON_CLICK_SETTINGS_BTN, function(arg_8_0)
		self:addSubLayers(Context.New({
			viewComponent = TechnologySettingsLayer,
			mediator = TechnologySettingsMediator
		}))

		return
	end)

	local var_1_0 = getProxy(TechnologyProxy)

	self.viewComponent:setTechnologys(var_1_0:getTechnologys(), var_1_0.queue)
	self.viewComponent:setRefreshFlag(var_1_0.refreshTechnologysFlag)
	self.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	return
end

function TechnologyMediator:listNotificationInterests()
	return {
		GAME.FINISH_TECHNOLOGY_DONE,
		GAME.REFRESH_TECHNOLOGYS_DONE,
		GAME.JOIN_QUEUE_TECHNOLOGY_DONE,
		GAME.FINISH_QUEUE_TECHNOLOGY_DONE,
		TechnologyProxy.TECHNOLOGY_UPDATED,
		TechnologyProxy.REFRESH_UPDATED,
		PlayerProxy.UPDATED,
		TechnologySettingsMediator.EXIT_CALL
	}
end

function TechnologyMediator:handleNotification(arg_10_1)
	local var_10_0 = arg_10_1:getBody()
	local var_10_1 = arg_10_1:getName()

	if var_10_1 == TechnologyProxy.TECHNOLOGY_UPDATED then
		self.viewComponent:updateTechnology(var_10_0)
	elseif var_10_1 == GAME.FINISH_TECHNOLOGY_DONE then
		if #var_10_0.items > 0 then
			self.viewComponent:emit(BaseUI.ON_AWARD, {
				animation = true,
				items = var_10_0.items
			})
		end

		self:onRefresh()
	elseif var_10_1 == GAME.FINISH_QUEUE_TECHNOLOGY_DONE then
		local var_10_2 = {}

		for iter_10_0, iter_10_1 in ipairs(var_10_0.dropInfos) do
			if #iter_10_1 > 0 then
				table.insert(var_10_2, function(arg_11_0)
					self.viewComponent:emit(BaseUI.ON_AWARD, {
						animation = true,
						items = iter_10_1,
						removeFunc = arg_11_0
					})

					return
				end)
			end
		end

		seriesAsync(var_10_2, function()
			return
		end)
		self:onRefresh()
	elseif var_10_1 == GAME.REFRESH_TECHNOLOGYS_DONE then
		self:onRefresh()
	elseif var_10_1 == GAME.JOIN_QUEUE_TECHNOLOGY_DONE then
		self:onRefresh()
	elseif var_10_1 == TechnologyProxy.REFRESH_UPDATED then
		self.viewComponent:setRefreshFlag(var_10_0)
		self.viewComponent:updateRefreshBtn(var_10_0)
	elseif var_10_1 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(var_10_0)
	elseif var_10_1 == TechnologySettingsMediator.EXIT_CALL then
		self.viewComponent:updatePickUpVersionChange()
	end

	return
end

function TechnologyMediator:onRefresh()
	self.viewComponent:clearTimer()
	self.viewComponent:cancelSelected()

	local var_13_0 = getProxy(TechnologyProxy)

	self.viewComponent:setTechnologys(var_13_0:getTechnologys(), var_13_0.queue)
	self.viewComponent:initTechnologys()
	self.viewComponent:initQueue()
	self.viewComponent:updateSettingsBtn()

	return
end

return TechnologyMediator
