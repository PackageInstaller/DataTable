class = var_0_10000

local var_0_0 = "CityRebuildGameMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.INIT_TIME = "CityRebuildGameMediator.INIT_TIME"
var_0_1.RESULT = "CityRebuildGameMediator.RESULT"
var_0_1.CHOOSE_LEVEL = "CityRebuildGameMediator.CHOOSE_LEVEL"
var_0_1.OPEN_BOOK = "CityRebuildGameMediator.OPEN_BOOK"
var_0_1.OPEN_TASKS = "CityRebuildGameMediator.OPEN_TASKS"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.INIT_TIME, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_2_2 = var_2_10005.CITY_REBUILD
		local var_2_3 = {}

		CityRebuildProxy = var_2_10007
		var_2_3.operation = var_2_10007.INIT_TIME
		var_2_3.activityId = arg_2_1

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.RESULT, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_3_2 = var_2_10005.CITY_REBUILD
		local var_3_3 = {}

		CityRebuildProxy = var_2_10007
		var_3_3.operation = var_2_10007.RESULT
		var_3_3.activityId = arg_3_1

		var_3_1(var_3_0, var_3_2, var_3_3)

		return
	end)
	arg_1_0:bind(var_0_1.CHOOSE_LEVEL, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_4_2 = var_2_10006.CITY_REBUILD
		local var_4_3 = {}

		CityRebuildProxy = var_2_10008
		var_4_3.operation = var_2_10008.CHOOSE_LEVEL
		var_4_3.activityId = arg_4_1
		var_4_3.level = arg_4_2

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_BOOK, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		CityRebuildBookMediator = var_2_10007
		var_5_3.mediator = var_2_10007
		CityRebuildBookLayer = var_2_10007
		var_5_3.viewComponent = var_2_10007
		var_5_3.data = {
			page = "buff"
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_TASKS, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_6_2 = var_2_10004.New
		local var_6_3 = {}

		CityRebuildTasksMediator = var_2_10007
		var_6_3.mediator = var_2_10007
		CityRebuildTasksLayer = var_2_10007
		var_6_3.viewComponent = var_2_10007

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.CITY_REBUILD_DONE

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1
	local var_8_1 = arg_8_1.getName(var_8_0)
	local var_8_2 = arg_8_1
	local var_8_3 = arg_8_1.getBody(var_8_2)

	GAME = var_8_0

	if var_8_1 == var_8_0.CITY_REBUILD_DONE then
		local var_8_4 = var_8_3.operation

		CityRebuildProxy = var_8_2

		if var_8_4 ~= var_8_2.CHOOSE_LEVEL then
			local var_8_5 = var_8_3.operation

			CityRebuildProxy = var_5

			if var_8_5 == var_5.INIT_TIME then
				local var_8_6 = arg_8_0.viewComponent

				var_4.Refresh(var_8_6)

				goto label_8_0
			end

			local var_8_7 = var_8_3.operation

			CityRebuildProxy = var_5

			if var_8_7 ~= var_5.REBUILD_OR_START_RECRUIT then
				local var_8_8 = var_8_3.operation

				CityRebuildProxy = var_5

				if var_8_8 ~= var_5.END_RECRUIT then
					do
						local var_8_9 = var_8_3.operation

						CityRebuildProxy = var_5

						if var_8_9 == var_5.UPGRADE_BUFF then
							local var_8_10 = arg_8_0.viewComponent

							var_4.Refresh(var_8_10, true)
						else
							local var_8_11 = var_8_3.operation

							CityRebuildProxy = var_5

							if var_8_11 == var_5.RESULT then
								local var_8_12 = arg_8_0.viewComponent

								var_4.Refresh(var_8_12, true)

								local var_8_13 = var_8_3.awards
								local var_8_14 = var_8_3.pt.k + var_8_3.pt.m * 1000000 + var_8_3.pt.b * 0

								if #var_8_13 == 0 and var_8_14 == 0 then
									pg = var_6

									local var_8_15 = var_6.TipsMgr.GetInstance()
									local var_8_16 = var_6.ShowTips

									i18n = var_1_10009

									var_8_16(var_8_15, var_1_10009("ninja_game_cant_pickup"))

									return
								end

								local function var_8_17()
									if var_8_14 > 0 then
										table = var_0

										var_0.insert(var_8_13, {
											id = 65103,
											type = 2,
											count = var_8_14
										})
									end

									if #var_8_13 > 0 then
										local var_9_0 = arg_8_0.viewComponent
										local var_9_1 = var_0.emit

										BaseUI = var_2_10003

										var_9_1(var_9_0, var_2_10003.ON_ACHIEVE, var_8_13)
									end

									return
								end

								local var_8_18 = arg_8_0.viewComponent

								var_7.Summary(var_8_18, var_8_17, var_8_14)
							end
						end
					end

					::label_8_0::

					return
				end
			end
		end
	end
end

return var_0_1
