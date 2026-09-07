local BlackFridaySalesMediator = class("BlackFridaySalesMediator", import("...base.ContextMediator"))

BlackFridaySalesMediator.TASK_GO = "BlackFridaySalesMediator.TASK_GO"
BlackFridaySalesMediator.TASK_SUBMIT = "BlackFridaySalesMediator.TASK_SUBMIT"
BlackFridaySalesMediator.TASK_SUBMIT_ONESTEP = "BlackFridaySalesMediator.TASK_SUBMIT_ONESTEP"
BlackFridaySalesMediator.GIFT_BUY_ITEM = "BlackFridaySalesMediator.GIFT_BUY_ITEM"
BlackFridaySalesMediator.GIFT_OPEN_ITEM_PANEL = "BlackFridaySalesMediator.GIFT_OPEN_ITEM_PANEL"
BlackFridaySalesMediator.UPDATE_SHOP_RED_DOT = "BlackFridaySalesMediator.UPDATE_SHOP_RED_DOT"
BlackFridaySalesMediator.CHARGE = "BlackFridaySalesMediator:CHARGE"
BlackFridaySalesMediator.OPEN_CHARGE_BIRTHDAY = "BlackFridaySalesMediator:OPEN_CHARGE_BIRTHDAY"

function BlackFridaySalesMediator:register()
	self:bind(BlackFridaySalesMediator.TASK_GO, function(arg_2_0, arg_2_1)
		self:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	self:bind(BlackFridaySalesMediator.TASK_SUBMIT, function(arg_3_0, arg_3_1)
		self:sendNotification(GAME.SUBMIT_TASK, arg_3_1.id)

		return
	end)
	self:bind(BlackFridaySalesMediator.TASK_SUBMIT_ONESTEP, function(arg_4_0, arg_4_1)
		pg.m02:sendNotification(GAME.SUBMIT_TASK_ONESTEP, {
			resultList = arg_4_1
		})

		return
	end)
	self:bind(BlackFridaySalesMediator.GIFT_BUY_ITEM, function(arg_5_0, arg_5_1, arg_5_2)
		self:sendNotification(GAME.SHOPPING, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	self:bind(BlackFridaySalesMediator.GIFT_OPEN_ITEM_PANEL, function(arg_6_0, arg_6_1)
		self:addSubLayers(Context.New({
			mediator = ChargeItemPanelMediator,
			viewComponent = ChargeItemPanelLayer,
			data = {
				panelConfig = arg_6_1
			}
		}))

		return
	end)
	self:bind(BlackFridaySalesMediator.UPDATE_SHOP_RED_DOT, function(arg_7_0)
		self.viewComponent:updateShopDedDot()

		return
	end)
	self:bind(BlackFridaySalesMediator.CHARGE, function(arg_8_0, arg_8_1)
		self:sendNotification(GAME.CHARGE_OPERATION, {
			shopId = arg_8_1
		})

		return
	end)
	self:bind(BlackFridaySalesMediator.OPEN_CHARGE_BIRTHDAY, function(arg_9_0, arg_9_1)
		self:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)
	self.viewComponent:setData()

	return
end

function BlackFridaySalesMediator:listNotificationInterests()
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		PlayerProxy.UPDATED,
		GAME.SHOPPING_DONE,
		GAME.CHARGE_SUCCESS,
		GAME.NEW_SERVER_SHOP_SHOPPING_DONE
	}
end

function BlackFridaySalesMediator:handleNotification(arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	if var_11_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		self.viewComponent:emit(BaseUI.ON_AWARD, {
			items = var_11_1.awards
		})
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1, function()
			self.viewComponent:onUpdateTask()

			return
		end)
	elseif var_11_0 == PlayerProxy.UPDATED then
		self.viewComponent:onUpdatePlayer(var_11_1)
	elseif var_11_0 == GAME.SHOPPING_DONE then
		if #var_11_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards)
		end

		self.viewComponent:onUpdateGift()
	elseif var_11_0 == GAME.NEW_SERVER_SHOP_SHOPPING_DONE then
		if #var_11_1.awards > 0 then
			self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards)
		end

		if self.viewComponent.blackFridaySalesShopPage and self.viewComponent.blackFridaySalesShopPage:GetLoaded() then
			self.viewComponent.blackFridaySalesShopPage:Refresh()
		end
	elseif var_11_0 == GAME.CHARGE_SUCCESS then
		self.viewComponent:onUpdateGift()
		self.viewComponent:OnChargeSuccess((Goods.Create({
			shop_id = var_11_1.shopId
		}, Goods.TYPE_CHARGE)))
	end

	return
end

return BlackFridaySalesMediator
