class = var_0_10000

local var_0_0 = "CityRebuildMapMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.GET_DATA = "CityRebuildMapMediator.GET_DATA"
var_0_1.OPEN_BOOK = "CityRebuildMapMediator.OPEN_BOOK"
var_0_1.OPEN_BATTLE = "CityRebuildMapMediator.OPEN_BATTLE"
var_0_1.OPEN_STORY = "CityRebuildMapMediator.OPEN_STORY"
var_0_1.OPEN_TASKS = "CityRebuildMapMediator.OPEN_TASKS"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GET_DATA, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_2_2 = var_2_10004.CITY_REBUILD
		local var_2_3 = {}

		CityRebuildProxy = var_2_10006
		var_2_3.operation = var_2_10006.GET_DATA
		var_2_3.activityId = arg_2_1

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_BOOK, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.addSubLayers

		Context = var_2_10005

		local var_3_2 = var_2_10005.New
		local var_3_3 = {}

		CityRebuildBookMediator = var_2_10007
		var_3_3.mediator = var_2_10007
		CityRebuildBookLayer = var_2_10007
		var_3_3.viewComponent = var_2_10007
		var_3_3.data = {
			page = arg_3_1,
			showId = arg_3_2
		}

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_TASKS, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_4_2 = var_2_10003.New
		local var_4_3 = {}

		CityRebuildTasksMediator = var_2_10005
		var_4_3.mediator = var_2_10005
		CityRebuildTasksLayer = var_2_10005
		var_4_3.viewComponent = var_2_10005

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_BATTLE, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_5_2 = var_2_10003.New
		local var_5_3 = {}

		CityRebuildGameMediator = var_2_10005
		var_5_3.mediator = var_2_10005
		CityRebuildGameLayer = var_2_10005
		var_5_3.viewComponent = var_2_10005

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_STORY, function(arg_6_0)
		local var_6_0 = arg_1_0
		local var_6_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_6_2 = var_2_10003.New
		local var_6_3 = {}

		CityRebuildStoryMediator = var_2_10005
		var_6_3.mediator = var_2_10005
		CityRebuildStoryLayer = var_2_10005
		var_6_3.viewComponent = var_2_10005

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_7_0)
	local var_7_0 = {}

	GAME = var_1_10002
	var_7_0[1] = var_1_10002.CITY_REBUILD_DONE
	GAME = var_2
	var_7_0[2] = var_2.STORY_UPDATE_DONE
	GAME = var_2
	var_7_0[3] = var_2.SUBMIT_TASK_AWARD_DOWN

	return var_7_0
end

function var_0_1.handleNotification(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1:getName()
	local var_8_1 = arg_8_1
	local var_8_2 = arg_8_1.getBody(var_8_1)

	GAME = var_8_1

	if var_8_0 == var_8_1.CITY_REBUILD_DONE then
		local var_8_3 = var_8_2.operation

		CityRebuildProxy = var_1_10005

		if var_8_3 ~= var_1_10005.GET_DATA then
			var_8_3 = var_8_2.operation
			CityRebuildProxy = var_5

			if var_8_3 ~= var_5.REBUILD_OR_START_RECRUIT then
				var_8_3 = var_8_2.operation
				CityRebuildProxy = var_5

				if var_8_3 ~= var_5.END_RECRUIT then
					var_8_3 = var_8_2.operation
					CityRebuildProxy = var_5

					if var_8_3 ~= var_5.CHOOSE_LEVEL then
						var_8_3 = var_8_2.operation
						CityRebuildProxy = var_5

						if var_8_3 == var_5.INIT_TIME then
							local var_8_4 = arg_8_0.viewComponent

							var_8_3.Refresh(var_8_4)

							goto label_8_0

							GAME = var_8_3

							if var_8_0 ~= var_8_3.STORY_UPDATE_DONE then
								GAME = var_4

								if var_8_0 == var_4.SUBMIT_TASK_AWARD_DOWN then
									local var_8_5 = arg_8_0.viewComponent

									var_4.Refresh(var_8_5)
								end

								::label_8_0::

								return
							end
						end
					end
				end
			end
		end
	end
end

return var_0_1
