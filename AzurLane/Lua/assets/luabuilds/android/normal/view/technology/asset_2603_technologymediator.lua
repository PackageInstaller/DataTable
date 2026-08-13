class = var_0_10000

local var_0_0 = "TechnologyMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_START = "TechnologyMediator:ON_START"
var_0_1.ON_FINISHED = "TechnologyMediator:ON_FINISHED"
var_0_1.ON_REFRESH = "TechnologyMediator:ON_REFRESH"
var_0_1.ON_STOP = "TechnologyMediator:ON_STOP"
var_0_1.ON_JOIN_QUEUE = "TechnologyMediator:ON_JOIN_QUEUE"
var_0_1.ON_FINISH_QUEUE = "TechnologyMediator:ON_FINISH_QUEUE"
var_0_1.ON_CLICK_SETTINGS_BTN = "TechnologyMediator:ON_CLICK_SETTINGS_BTN"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_START, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.START_TECHNOLOGY, {
			id = arg_2_1.id,
			pool_id = arg_2_1.pool_id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_FINISHED, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.FINISH_TECHNOLOGY, {
			id = arg_3_1.id,
			pool_id = arg_3_1.pool_id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_REFRESH, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10003

		var_4_1(var_4_0, var_2_10003.REFRESH_TECHNOLOGYS)

		return
	end)
	arg_1_0:bind(var_0_1.ON_STOP, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		var_5_1(var_5_0, var_2_10004.STOP_TECHNOLOGY, {
			id = arg_5_1.id,
			pool_id = arg_5_1.pool_id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_JOIN_QUEUE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.JOIN_QUEUE_TECHNOLOGY, {
			id = arg_6_1.id,
			pool_id = arg_6_1.pool_id
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_FINISH_QUEUE, function(arg_7_0)
		local var_7_0 = arg_1_0
		local var_7_1 = var_1.sendNotification

		GAME = var_2_10003

		var_7_1(var_7_0, var_2_10003.FINISH_QUEUE_TECHNOLOGY)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_CLICK_SETTINGS_BTN, function(arg_8_0)
		local var_8_0 = arg_1_0
		local var_8_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_8_2 = var_2_10003.New
		local var_8_3 = {}

		TechnologySettingsLayer = var_2_10005
		var_8_3.viewComponent = var_2_10005
		TechnologySettingsMediator = var_2_10005
		var_8_3.mediator = var_2_10005

		var_8_1(var_8_0, var_8_2(var_8_3))

		return
	end)

	getProxy = var_1
	TechnologyProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_2.setTechnologys(var_1_2, var_1_1:getTechnologys(), var_1_1.queue)

	local var_1_3 = arg_1_0.viewComponent

	var_2.setRefreshFlag(var_1_3, var_1_1.refreshTechnologysFlag)

	getProxy = var_2
	PlayerProxy = var_1_3

	local var_1_4 = var_2(var_1_3)
	local var_1_5 = var_2.getData(var_1_4)
	local var_1_6 = arg_1_0.viewComponent

	var_3.setPlayer(var_1_6, var_1_5)

	return
end

function var_0_1.listNotificationInterests(arg_9_0)
	local var_9_0 = {}

	GAME = var_1_10002
	var_9_0[1] = var_1_10002.FINISH_TECHNOLOGY_DONE
	GAME = var_2
	var_9_0[2] = var_2.REFRESH_TECHNOLOGYS_DONE
	GAME = var_2
	var_9_0[3] = var_2.JOIN_QUEUE_TECHNOLOGY_DONE
	GAME = var_2
	var_9_0[4] = var_2.FINISH_QUEUE_TECHNOLOGY_DONE
	TechnologyProxy = var_2
	var_9_0[5] = var_2.TECHNOLOGY_UPDATED
	TechnologyProxy = var_2
	var_9_0[6] = var_2.REFRESH_UPDATED
	PlayerProxy = var_2
	var_9_0[7] = var_2.UPDATED
	TechnologySettingsMediator = var_2
	var_9_0[8] = var_2.EXIT_CALL

	return var_9_0
end

function var_0_1.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getBody()
	local var_10_1 = arg_10_1
	local var_10_2 = arg_10_1.getName(var_10_1)

	TechnologyProxy = var_10_1

	if var_10_2 == var_10_1.TECHNOLOGY_UPDATED then
		var_1_10005 = arg_10_0.viewComponent

		var_4.updateTechnology(var_1_10005, var_10_0)
	else
		GAME = var_4

		local var_10_3

		if var_10_2 == var_4.FINISH_TECHNOLOGY_DONE then
			var_10_3 = #var_10_0.items

			if 0 < var_10_3 then
				var_1_10005 = arg_10_0.viewComponent
				var_10_3 = var_10_3.emit
				BaseUI = var_1_10006

				var_10_3(var_1_10005, var_1_10006.ON_AWARD, {
					animation = true,
					items = var_10_0.items
				})
			end

			var_1_10005 = arg_10_0

			arg_10_0.onRefresh(var_1_10005)
		else
			GAME = var_10_3

			local var_10_4

			if var_10_2 == var_10_3.FINISH_QUEUE_TECHNOLOGY_DONE then
				var_10_4 = {}
				ipairs = var_1_10005

				for iter_10_0, iter_10_1 in var_1_10005(var_10_0.dropInfos) do
					if #iter_10_1 > 0 then
						table = var_10

						var_10.insert(var_10_4, function(arg_11_0)
							local var_11_0 = arg_10_0.viewComponent
							local var_11_1 = var_1.emit

							BaseUI = var_2_10003

							var_11_1(var_11_0, var_2_10003.ON_AWARD, {
								animation = true,
								items = iter_10_1,
								removeFunc = arg_11_0
							})

							return
						end)
					end
				end

				seriesAsync = var_5

				var_5(var_10_4, function()
					return
				end)
				arg_10_0:onRefresh()
			else
				GAME = var_10_4

				if var_10_2 == var_10_4.REFRESH_TECHNOLOGYS_DONE then
					arg_10_0:onRefresh()
				else
					GAME = var_4

					if var_10_2 == var_4.JOIN_QUEUE_TECHNOLOGY_DONE then
						arg_10_0:onRefresh()
					else
						TechnologyProxy = var_4

						if var_10_2 == var_4.REFRESH_UPDATED then
							local var_10_5 = arg_10_0.viewComponent

							var_4.setRefreshFlag(var_10_5, var_10_0)

							local var_10_6 = arg_10_0.viewComponent

							var_4.updateRefreshBtn(var_10_6, var_10_0)
						else
							PlayerProxy = var_4

							if var_10_2 == var_4.UPDATED then
								local var_10_7 = arg_10_0.viewComponent

								var_4.setPlayer(var_10_7, var_10_0)
							else
								TechnologySettingsMediator = var_4

								if var_10_2 == var_4.EXIT_CALL then
									local var_10_8 = arg_10_0.viewComponent

									var_4.updatePickUpVersionChange(var_10_8)
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.onRefresh(arg_13_0)
	local var_13_0 = arg_13_0.viewComponent

	var_1.clearTimer(var_13_0)

	local var_13_1 = arg_13_0.viewComponent

	var_1.cancelSelected(var_13_1)

	getProxy = var_1
	TechnologyProxy = var_13_1

	local var_13_2 = var_1(var_13_1)
	local var_13_3 = arg_13_0.viewComponent

	var_2.setTechnologys(var_13_3, var_13_2:getTechnologys(), var_13_2.queue)

	local var_13_4 = arg_13_0.viewComponent

	var_2.initTechnologys(var_13_4)

	local var_13_5 = arg_13_0.viewComponent

	var_2.initQueue(var_13_5)

	local var_13_6 = arg_13_0.viewComponent

	var_2.updateSettingsBtn(var_13_6)

	return
end

return var_0_1
