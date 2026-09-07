local HolidayVillaMapMediator = class("HolidayVillaMapMediator", import("view.base.ContextMediator"))

HolidayVillaMapMediator.EXCHANGE_RESOURCES = "HolidayVillaMapMediator.EXCHANGE_RESOURCES"
HolidayVillaMapMediator.SITE_CLICKED = "HolidayVillaMapMediator.SITE_CLICKED"
HolidayVillaMapMediator.ON_TASK_SUBMIT_ONESTEP = "HolidayVillaMapMediator.ON_TASK_SUBMIT_ONESTEP"
HolidayVillaMapMediator.OPEN_WHARF = "HolidayVillaMapMediator.OPEN_WHARF"
HolidayVillaMapMediator.OPEN_HolidayVilla_TASk = "HolidayVillaMapMediator.OPEN_HolidayVilla_TASk"
HolidayVillaMapMediator.ON_SHOP = "HolidayVillaMapMediator.ON_SHOP"
HolidayVillaMapMediator.ON_BOOK = "HolidayVillaMapMediator.ON_BOOK"
HolidayVillaMapMediator.GO_HOTSPRING = "HolidayVillaMapMediator.GO_HOTSPRING"
HolidayVillaMapMediator.OPEN_MINI_GAME = "HolidayVillaMapMediator.OPEN_MINI_GAME"

function HolidayVillaMapMediator:register()
	self:bind(HolidayVillaMapMediator.GO_HOTSPRING, function(arg_2_0)
		self:sendNotification(GAME.GO_SCENE, SCENE.HOLIDAY_VILLA_HOTSPRING)

		return
	end)
	self:bind(HolidayVillaMapMediator.EXCHANGE_RESOURCES, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_3_1
		})

		return
	end)
	self:bind(HolidayVillaMapMediator.SITE_CLICKED, function(arg_4_0, arg_4_1, arg_4_2)
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 2,
			activity_id = arg_4_1,
			arg1 = arg_4_2
		})

		return
	end)
	self:bind(HolidayVillaMapMediator.ON_SHOP, function(arg_5_0)
		self:addSubLayers(Context.New({
			mediator = HolidayVillaShopMediator,
			viewComponent = HolidayVillaShopLayer
		}))

		return
	end)
	self:bind(HolidayVillaMapMediator.ON_TASK_SUBMIT_ONESTEP, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		self:sendNotification(GAME.SUBMIT_ACTIVITY_TASK, {
			act_id = arg_6_1,
			task_ids = arg_6_2,
			callback = arg_6_3
		})

		return
	end)
	self:bind(HolidayVillaMapMediator.OPEN_WHARF, function(arg_7_0)
		self:addSubLayers(Context.New({
			viewComponent = HolidayVillaWharfLayer,
			mediator = HolidayVillaWharfMediator
		}))

		return
	end)
	self:bind(HolidayVillaMapMediator.OPEN_HolidayVilla_TASk, function(arg_8_0, arg_8_1)
		self:addSubLayers(Context.New({
			viewComponent = HolidayVillaTasksLayer,
			mediator = HolidayVillaTasksMediator,
			onRemoved = arg_8_1
		}))

		return
	end)
	self:bind(HolidayVillaMapMediator.ON_BOOK, function(arg_9_0, arg_9_1)
		self:addSubLayers(Context.New({
			viewComponent = CollectionBookLayer,
			mediator = CollectionBookMediator
		}))

		return
	end)
	self:bind(HolidayVillaMapMediator.OPEN_MINI_GAME, function(arg_10_0, arg_10_1)
		self:sendNotification(GAME.GO_MINI_GAME, arg_10_1)

		return
	end)

	return
end

function HolidayVillaMapMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_OPERATION_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		ActivityProxy.ACTIVITY_EXCHANGE_RESOURCES,
		GAME.STORY_UPDATE_DONE,
		GAME.ISLAND_SHOPPING_DONE
	}
end

function HolidayVillaMapMediator:handleNotification(arg_12_1)
	local var_12_0 = arg_12_1:getName()
	local var_12_1 = arg_12_1:getBody()

	if var_12_0 == ActivityProxy.ACTIVITY_OPERATION_DONE or var_12_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE or var_12_0 == GAME.ISLAND_SHOPPING_DONE then
		self.viewComponent:RefreshData()
		self.viewComponent:Show()
	elseif var_12_0 == ActivityProxy.ACTIVITY_EXCHANGE_RESOURCES then
		self.viewComponent:RefreshData()
		self.viewComponent:Show()
		self.viewComponent:ShowAllRepairPage()
	elseif var_12_0 == GAME.STORY_UPDATE_DONE then
		getProxy(TaskProxy):pushAutoSubmitTask()
	end

	return
end

return HolidayVillaMapMediator
