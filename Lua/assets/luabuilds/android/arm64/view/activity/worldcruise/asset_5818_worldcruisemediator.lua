local WorldCruiseMediator = class("WorldCruiseMediator", import("view.base.ContextMediator"))

WorldCruiseMediator.EVENT_GET_AWARD = "WorldCruiseMediator.EVENT_GET_AWARD"
WorldCruiseMediator.EVENT_GET_AWARD_PAY = "WorldCruiseMediator.EVENT_GET_AWARD_PAY"
WorldCruiseMediator.EVENT_GET_AWARD_ALL = "WorldCruiseMediator.EVENT_GET_AWARD_ALL"
WorldCruiseMediator.EVENT_OPEN_BIRTHDAY = "WorldCruiseMediator.EVENT_OPEN_BIRTHDAY"
WorldCruiseMediator.ON_TASK_GO = "WorldCruiseMediator.ON_TASK_GO"
WorldCruiseMediator.ON_TASK_SUBMIT = "WorldCruiseMediator.ON_TASK_SUBMIT"
WorldCruiseMediator.ON_TASK_QUICK_SUBMIT = "WorldCruiseMediator.ON_TASK_QUICK_SUBMIT"
WorldCruiseMediator.ON_CRUISE_SHOPPING = "WorldCruiseMediator.ON_CRUISE_SHOPPING"

function WorldCruiseMediator:register()
	self:bind(WorldCruiseMediator.EVENT_GET_AWARD, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.CRUSING_CMD, {
			cmd = 2,
			activity_id = self.viewComponent.activity.id,
			arg1 = arg_2_1
		})

		return
	end)
	self:bind(WorldCruiseMediator.EVENT_GET_AWARD_PAY, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.CRUSING_CMD, {
			cmd = 3,
			activity_id = self.viewComponent.activity.id,
			arg1 = arg_3_1
		})

		return
	end)
	self:bind(WorldCruiseMediator.EVENT_GET_AWARD_ALL, function(arg_4_0)
		self:sendNotification(GAME.CRUSING_CMD, {
			cmd = 4,
			activity_id = self.viewComponent.activity.id
		})

		return
	end)
	self:bind(WorldCruiseMediator.EVENT_OPEN_BIRTHDAY, function(arg_5_0, arg_5_1)
		self:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)
	self:bind(WorldCruiseMediator.ON_TASK_GO, function(arg_6_0, arg_6_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_6_1
		})

		return
	end)
	self:bind(WorldCruiseMediator.ON_TASK_SUBMIT, function(arg_7_0, arg_7_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_7_1.id)

		return
	end)
	self:bind(WorldCruiseMediator.ON_TASK_QUICK_SUBMIT, function(arg_8_0, arg_8_1)
		self:sendNotification(GAME.QUICK_TASK, arg_8_1.id)

		return
	end)
	self:bind(WorldCruiseMediator.ON_CRUISE_SHOPPING, function(arg_9_0, arg_9_1, arg_9_2)
		self:sendNotification(GAME.SHOPPING, {
			id = arg_9_1,
			count = arg_9_2
		})

		return
	end)
	self.viewComponent:setActivity((getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)))
	self.viewComponent:setPlayer(getProxy(PlayerProxy):getData())

	return
end

function WorldCruiseMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.CRUSING_CMD_DONE,
		PlayerProxy.UPDATED,
		GAME.CHARGE_SUCCESS,
		BagProxy.ITEM_UPDATED,
		GAME.SUBMIT_TASK_DONE,
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		GAME.SHOPPING_DONE,
		ShopsProxy.CRUISE_SHOP_UPDATED
	}
end

function WorldCruiseMediator:handleNotification(arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	if var_11_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_11_1.id == self.viewComponent.activity.id then
			self.viewComponent:setActivity(var_11_1)
			self.viewComponent:UpdatePhase()
			self.viewComponent:UpdateAwardPage()
			self.viewComponent:UpdateTaskPage()
			self.viewComponent:UpdateView()
		end
	elseif var_11_0 == GAME.CRUSING_CMD_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards)
		self.viewComponent:UpdateAwardPage()
		self.viewComponent:UpdateView()
	elseif var_11_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(var_11_1)
		self.viewComponent:UpdateRes()
	elseif var_11_0 == GAME.CHARGE_SUCCESS then
		self.viewComponent:OnChargeSuccess((Goods.Create({
			shop_id = var_11_1.shopId
		}, Goods.TYPE_CHARGE)))
		self.viewComponent:UpdateRes()
	elseif var_11_0 == BagProxy.ITEM_UPDATED then
		if var_11_1.id == Item.QUICK_TASK_PASS_TICKET_ID then
			self.viewComponent:UpdateRes()
		end
	elseif var_11_0 == GAME.SUBMIT_TASK_DONE or var_11_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:UpdateTaskPage()
		self.viewComponent:UpdateView()
	elseif var_11_0 == GAME.SHOPPING_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards)
		self.viewComponent:UpdateShopPage()
	elseif var_11_0 == ShopsProxy.CRUISE_SHOP_UPDATED then
		self.viewComponent:setShop(var_11_1.shop)
		self.viewComponent:UpdateShopPage()
	end

	return
end

return WorldCruiseMediator
