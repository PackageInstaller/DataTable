class = var_0_10000

local var_0_0 = "HolidayVillaMapMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.EXCHANGE_RESOURCES = "HolidayVillaMapMediator.EXCHANGE_RESOURCES"
var_0_1.SITE_CLICKED = "HolidayVillaMapMediator.SITE_CLICKED"
var_0_1.ON_TASK_SUBMIT_ONESTEP = "HolidayVillaMapMediator.ON_TASK_SUBMIT_ONESTEP"
var_0_1.OPEN_WHARF = "HolidayVillaMapMediator.OPEN_WHARF"
var_0_1.OPEN_HolidayVilla_TASk = "HolidayVillaMapMediator.OPEN_HolidayVilla_TASk"
var_0_1.ON_SHOP = "HolidayVillaMapMediator.ON_SHOP"
var_0_1.ON_BOOK = "HolidayVillaMapMediator.ON_BOOK"
var_0_1.GO_HOTSPRING = "HolidayVillaMapMediator.GO_HOTSPRING"
var_0_1.OPEN_MINI_GAME = "HolidayVillaMapMediator.OPEN_MINI_GAME"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GO_HOTSPRING, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10003

		local var_2_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		var_2_1(var_2_0, var_2_2, var_2_10004.HOLIDAY_VILLA_HOTSPRING)

		return
	end)
	arg_1_0:bind(var_0_1.EXCHANGE_RESOURCES, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.SITE_CLICKED, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.ACTIVITY_OPERATION, {
			cmd = 2,
			activity_id = arg_4_1,
			arg1 = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHOP, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_5_2 = var_2_10003.New
		local var_5_3 = {}

		HolidayVillaShopMediator = var_2_10005
		var_5_3.mediator = var_2_10005
		HolidayVillaShopLayer = var_2_10005
		var_5_3.viewComponent = var_2_10005

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT_ONESTEP, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		local var_6_0 = arg_1_0
		local var_6_1 = var_4.sendNotification

		GAME = var_2_10006

		var_6_1(var_6_0, var_2_10006.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_6_1,
			task_ids = arg_6_2,
			callback = arg_6_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_WHARF, function(arg_7_0)
		local var_7_0 = arg_1_0
		local var_7_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_7_2 = var_2_10003.New
		local var_7_3 = {}

		HolidayVillaWharfLayer = var_2_10005
		var_7_3.viewComponent = var_2_10005
		HolidayVillaWharfMediator = var_2_10005
		var_7_3.mediator = var_2_10005

		var_7_1(var_7_0, var_7_2(var_7_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_HolidayVilla_TASk, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_8_2 = var_2_10004.New
		local var_8_3 = {}

		HolidayVillaTasksLayer = var_2_10006
		var_8_3.viewComponent = var_2_10006
		HolidayVillaTasksMediator = var_2_10006
		var_8_3.mediator = var_2_10006
		var_8_3.onRemoved = arg_8_1

		var_8_1(var_8_0, var_8_2(var_8_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_BOOK, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_9_2 = var_2_10004.New
		local var_9_3 = {}

		CollectionBookLayer = var_2_10006
		var_9_3.viewComponent = var_2_10006
		CollectionBookMediator = var_2_10006
		var_9_3.mediator = var_2_10006

		var_9_1(var_9_0, var_9_2(var_9_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_MINI_GAME, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0
		local var_10_1 = var_2.sendNotification

		GAME = var_2_10004

		var_10_1(var_10_0, var_2_10004.GO_MINI_GAME, arg_10_1)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_11_0)
	local var_11_0 = {}

	ActivityProxy = var_1_10002
	var_11_0[1] = var_1_10002.ACTIVITY_OPERATION_DONE
	GAME = var_2
	var_11_0[2] = var_2.SUBMIT_ACTIVITY_TASK_DONE
	ActivityProxy = var_2
	var_11_0[3] = var_2.ACTIVITY_EXCHANGE_RESOURCES
	GAME = var_2
	var_11_0[4] = var_2.STORY_UPDATE_DONE
	GAME = var_2
	var_11_0[5] = var_2.ISLAND_SHOPPING_DONE

	return var_11_0
end

function var_0_1.handleNotification(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1
	local var_12_2 = arg_12_1.getBody(var_12_1)

	ActivityProxy = var_12_1

	if var_12_0 ~= var_12_1.ACTIVITY_OPERATION_DONE then
		GAME = var_4

		if var_12_0 ~= var_4.SUBMIT_ACTIVITY_TASK_DONE then
			GAME = var_4

			if var_12_0 == var_4.ISLAND_SHOPPING_DONE then
				var_1_10005 = arg_12_0.viewComponent

				var_4.RefreshData(var_1_10005)

				var_1_10005 = arg_12_0.viewComponent

				var_4.Show(var_1_10005)
			else
				ActivityProxy = var_4

				if var_12_0 == var_4.ACTIVITY_EXCHANGE_RESOURCES then
					var_1_10005 = arg_12_0.viewComponent

					var_4.RefreshData(var_1_10005)

					var_1_10005 = arg_12_0.viewComponent

					var_4.Show(var_1_10005)

					var_1_10005 = arg_12_0.viewComponent

					var_4.ShowAllRepairPage(var_1_10005)
				else
					GAME = var_4

					if var_12_0 == var_4.STORY_UPDATE_DONE then
						getProxy = var_4
						TaskProxy = var_1_10005

						local var_12_3 = var_4(var_1_10005)

						var_4.pushAutoSubmitTask(var_12_3)
					end
				end
			end

			return
		end
	end
end

return var_0_1
