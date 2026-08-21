local var_0_0 = class("BlackFridaySalesMediator", import("...base.ContextMediator"))

var_0_0.TASK_GO = "BlackFridaySalesMediator.TASK_GO"
var_0_0.TASK_SUBMIT = "BlackFridaySalesMediator.TASK_SUBMIT"
var_0_0.TASK_SUBMIT_ONESTEP = "BlackFridaySalesMediator.TASK_SUBMIT_ONESTEP"
var_0_0.GIFT_BUY_ITEM = "BlackFridaySalesMediator.GIFT_BUY_ITEM"
var_0_0.GIFT_OPEN_ITEM_PANEL = "BlackFridaySalesMediator.GIFT_OPEN_ITEM_PANEL"
var_0_0.UPDATE_SHOP_RED_DOT = "BlackFridaySalesMediator.UPDATE_SHOP_RED_DOT"
var_0_0.CHARGE = "BlackFridaySalesMediator:CHARGE"
var_0_0.OPEN_CHARGE_BIRTHDAY = "BlackFridaySalesMediator:OPEN_CHARGE_BIRTHDAY"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.TASK_GO, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.TASK_SUBMIT, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_3_1.id)

		return
	end)
	arg_1_0:bind(var_0_0.TASK_SUBMIT_ONESTEP, function(arg_4_0, arg_4_1)
		pg.m02:sendNotification(GAME.SUBMIT_TASK_ONESTEP, {
			resultList = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.GIFT_BUY_ITEM, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.GIFT_OPEN_ITEM_PANEL, function(arg_6_0, arg_6_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeItemPanelMediator,
			viewComponent = ChargeItemPanelLayer,
			data = {
				panelConfig = arg_6_1
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.UPDATE_SHOP_RED_DOT, function(arg_7_0)
		arg_1_0.viewComponent:updateShopDedDot()

		return
	end)
	arg_1_0:bind(var_0_0.CHARGE, function(arg_8_0, arg_8_1)
		arg_1_0:sendNotification(GAME.CHARGE_OPERATION, {
			shopId = arg_8_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_CHARGE_BIRTHDAY, function(arg_9_0, arg_9_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)
	arg_1_0.viewComponent:setData()

	return
end

function var_0_0.listNotificationInterests(arg_10_0)
	return {
		GAME.SUBMIT_ACTIVITY_TASK_DONE,
		PlayerProxy.UPDATED,
		GAME.SHOPPING_DONE,
		GAME.CHARGE_SUCCESS,
		GAME.NEW_SERVER_SHOP_SHOPPING_DONE
	}
end

function var_0_0.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	if var_11_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		arg_11_0.viewComponent:emit(BaseUI.ON_AWARD, {
			items = var_11_1.awards
		})
		arg_11_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1, function()
			arg_11_0.viewComponent:onUpdateTask()

			return
		end)
	elseif var_11_0 == PlayerProxy.UPDATED then
		arg_11_0.viewComponent:onUpdatePlayer(var_11_1)
	elseif var_11_0 == GAME.SHOPPING_DONE then
		if #var_11_1.awards > 0 then
			arg_11_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards)
		end

		arg_11_0.viewComponent:onUpdateGift()
	elseif var_11_0 == GAME.NEW_SERVER_SHOP_SHOPPING_DONE then
		if #var_11_1.awards > 0 then
			arg_11_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards)
		end

		if arg_11_0.viewComponent.blackFridaySalesShopPage and arg_11_0.viewComponent.blackFridaySalesShopPage:GetLoaded() then
			arg_11_0.viewComponent.blackFridaySalesShopPage:Refresh()
		end
	elseif var_11_0 == GAME.CHARGE_SUCCESS then
		arg_11_0.viewComponent:onUpdateGift()
		arg_11_0.viewComponent:OnChargeSuccess((Goods.Create({
			shop_id = var_11_1.shopId
		}, Goods.TYPE_CHARGE)))
	end

	return
end

return var_0_0
