local var_0_0 = class("TechnologyMediator", import("..base.ContextMediator"))

var_0_0.ON_START = "TechnologyMediator:ON_START"
var_0_0.ON_FINISHED = "TechnologyMediator:ON_FINISHED"
var_0_0.ON_REFRESH = "TechnologyMediator:ON_REFRESH"
var_0_0.ON_STOP = "TechnologyMediator:ON_STOP"
var_0_0.ON_JOIN_QUEUE = "TechnologyMediator:ON_JOIN_QUEUE"
var_0_0.ON_FINISH_QUEUE = "TechnologyMediator:ON_FINISH_QUEUE"
var_0_0.ON_CLICK_SETTINGS_BTN = "TechnologyMediator:ON_CLICK_SETTINGS_BTN"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_START, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.START_TECHNOLOGY, {
			id = arg_2_1.id,
			pool_id = arg_2_1.pool_id
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_FINISHED, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.FINISH_TECHNOLOGY, {
			id = arg_3_1.id,
			pool_id = arg_3_1.pool_id
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_REFRESH, function(arg_4_0)
		arg_1_0:sendNotification(GAME.REFRESH_TECHNOLOGYS)

		return
	end)
	arg_1_0:bind(var_0_0.ON_STOP, function(arg_5_0, arg_5_1)
		arg_1_0:sendNotification(GAME.STOP_TECHNOLOGY, {
			id = arg_5_1.id,
			pool_id = arg_5_1.pool_id
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_JOIN_QUEUE, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.JOIN_QUEUE_TECHNOLOGY, {
			id = arg_6_1.id,
			pool_id = arg_6_1.pool_id
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_FINISH_QUEUE, function(arg_7_0)
		arg_1_0:sendNotification(GAME.FINISH_QUEUE_TECHNOLOGY)

		return
	end)
	arg_1_0:bind(var_0_0.ON_CLICK_SETTINGS_BTN, function(arg_8_0)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = TechnologySettingsLayer,
			mediator = TechnologySettingsMediator
		}))

		return
	end)

	local var_1_0 = getProxy(TechnologyProxy)

	arg_1_0.viewComponent:setTechnologys(var_1_0:getTechnologys(), var_1_0.queue)
	arg_1_0.viewComponent:setRefreshFlag(var_1_0.refreshTechnologysFlag)
	arg_1_0.viewComponent:setPlayer((getProxy(PlayerProxy):getData()))

	return
end

function var_0_0.listNotificationInterests(arg_9_0)
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

function var_0_0.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getBody()
	local var_10_1 = arg_10_1:getName()

	if var_10_1 == TechnologyProxy.TECHNOLOGY_UPDATED then
		arg_10_0.viewComponent:updateTechnology(var_10_0)
	elseif var_10_1 == GAME.FINISH_TECHNOLOGY_DONE then
		if #var_10_0.items > 0 then
			arg_10_0.viewComponent:emit(BaseUI.ON_AWARD, {
				animation = true,
				items = var_10_0.items
			})
		end

		arg_10_0:onRefresh()
	elseif var_10_1 == GAME.FINISH_QUEUE_TECHNOLOGY_DONE then
		for iter_10_0, iter_10_1 in ipairs(var_10_0.dropInfos) do
			if #iter_10_1 > 0 then
				table.insert({}, function(arg_11_0)
					arg_10_0.viewComponent:emit(BaseUI.ON_AWARD, {
						animation = true,
						items = iter_10_1,
						removeFunc = arg_11_0
					})

					return
				end)
			end
		end

		seriesAsync({}, function()
			return
		end)
		arg_10_0:onRefresh()
	elseif var_10_1 == GAME.REFRESH_TECHNOLOGYS_DONE then
		arg_10_0:onRefresh()
	elseif var_10_1 == GAME.JOIN_QUEUE_TECHNOLOGY_DONE then
		arg_10_0:onRefresh()
	elseif var_10_1 == TechnologyProxy.REFRESH_UPDATED then
		arg_10_0.viewComponent:setRefreshFlag(var_10_0)
		arg_10_0.viewComponent:updateRefreshBtn(var_10_0)
	elseif var_10_1 == PlayerProxy.UPDATED then
		arg_10_0.viewComponent:setPlayer(var_10_0)
	elseif var_10_1 == TechnologySettingsMediator.EXIT_CALL then
		arg_10_0.viewComponent:updatePickUpVersionChange()
	end

	return
end

function var_0_0.onRefresh(arg_13_0)
	arg_13_0.viewComponent:clearTimer()
	arg_13_0.viewComponent:cancelSelected()

	local var_13_0 = getProxy(TechnologyProxy)

	arg_13_0.viewComponent:setTechnologys(var_13_0:getTechnologys(), var_13_0.queue)
	arg_13_0.viewComponent:initTechnologys()
	arg_13_0.viewComponent:initQueue()
	arg_13_0.viewComponent:updateSettingsBtn()

	return
end

return var_0_0
