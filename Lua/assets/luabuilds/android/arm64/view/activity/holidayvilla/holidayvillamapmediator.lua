local var_0_0 = class("HolidayVillaMapMediator", import("view.base.ContextMediator"))

var_0_0.EXCHANGE_RESOURCES = "HolidayVillaMapMediator.EXCHANGE_RESOURCES"
var_0_0.SITE_CLICKED = "HolidayVillaMapMediator.SITE_CLICKED"
var_0_0.ON_TASK_SUBMIT_ONESTEP = "HolidayVillaMapMediator.ON_TASK_SUBMIT_ONESTEP"
var_0_0.OPEN_WHARF = "HolidayVillaMapMediator.OPEN_WHARF"
var_0_0.OPEN_HolidayVilla_TASk = "HolidayVillaMapMediator.OPEN_HolidayVilla_TASk"
var_0_0.ON_SHOP = "HolidayVillaMapMediator.ON_SHOP"
var_0_0.ON_BOOK = "HolidayVillaMapMediator.ON_BOOK"
var_0_0.GO_HOTSPRING = "HolidayVillaMapMediator.GO_HOTSPRING"
var_0_0.OPEN_MINI_GAME = "HolidayVillaMapMediator.OPEN_MINI_GAME"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GO_HOTSPRING, function(arg_2_0)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.HOLIDAY_VILLA_HOTSPRING)

		return
	end)
	arg_1_0:bind(var_0_0.EXCHANGE_RESOURCES, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.SITE_CLICKED, function(arg_4_0, arg_4_1, arg_4_2)
		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 2,
			activity_id = arg_4_1,
			arg1 = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_SHOP, function(arg_5_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = HolidayVillaShopMediator,
			viewComponent = HolidayVillaShopLayer
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT_ONESTEP, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		arg_1_0:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_6_1,
			task_ids = arg_6_2,
			callback = arg_6_3
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_WHARF, function(arg_7_0)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = HolidayVillaWharfLayer,
			mediator = HolidayVillaWharfMediator
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_HolidayVilla_TASk, function(arg_8_0, arg_8_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = HolidayVillaTasksLayer,
			mediator = HolidayVillaTasksMediator,
			onRemoved = arg_8_1
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_BOOK, function(arg_9_0, arg_9_1)
		arg_1_0:addSubLayers(Context.New({
			viewComponent = CollectionBookLayer,
			mediator = CollectionBookMediator
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_MINI_GAME, function(arg_10_0, arg_10_1)
		arg_1_0:sendNotification(GAME.GO_MINI_GAME, arg_10_1)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_11_0)
	return {
		ActivityProxy.ACTIVITY_OPERATION_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		ActivityProxy.ACTIVITY_EXCHANGE_RESOURCES,
		GAME.STORY_UPDATE_DONE,
		GAME.ISLAND_SHOPPING_DONE
	}
end

function var_0_0.handleNotification(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1:getBody()

	if var_12_0 == ActivityProxy.ACTIVITY_OPERATION_DONE or var_12_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE or var_12_0 == GAME.ISLAND_SHOPPING_DONE then
		arg_12_0.viewComponent:RefreshData()
		arg_12_0.viewComponent:Show()
	elseif var_12_0 == ActivityProxy.ACTIVITY_EXCHANGE_RESOURCES then
		arg_12_0.viewComponent:RefreshData()
		arg_12_0.viewComponent:Show()
		arg_12_0.viewComponent:ShowAllRepairPage()
	elseif var_12_0 == GAME.STORY_UPDATE_DONE then
		getProxy(TaskProxy):pushAutoSubmitTask()
	end

	return
end

return var_0_0
