local var_0_0 = class("WorldCruiseMediator", import("view.base.ContextMediator"))

var_0_0.EVENT_GET_AWARD = "WorldCruiseMediator.EVENT_GET_AWARD"
var_0_0.EVENT_GET_AWARD_PAY = "WorldCruiseMediator.EVENT_GET_AWARD_PAY"
var_0_0.EVENT_GET_AWARD_ALL = "WorldCruiseMediator.EVENT_GET_AWARD_ALL"
var_0_0.EVENT_OPEN_BIRTHDAY = "WorldCruiseMediator.EVENT_OPEN_BIRTHDAY"
var_0_0.ON_TASK_GO = "WorldCruiseMediator.ON_TASK_GO"
var_0_0.ON_TASK_SUBMIT = "WorldCruiseMediator.ON_TASK_SUBMIT"
var_0_0.ON_TASK_QUICK_SUBMIT = "WorldCruiseMediator.ON_TASK_QUICK_SUBMIT"
var_0_0.ON_CRUISE_SHOPPING = "WorldCruiseMediator.ON_CRUISE_SHOPPING"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.EVENT_GET_AWARD, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.CRUSING_CMD, {
			cmd = 2,
			activity_id = arg_1_0.viewComponent.activity.id,
			arg1 = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_GET_AWARD_PAY, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.CRUSING_CMD, {
			cmd = 3,
			activity_id = arg_1_0.viewComponent.activity.id,
			arg1 = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_GET_AWARD_ALL, function(arg_4_0)
		arg_1_0:sendNotification(GAME.CRUSING_CMD, {
			cmd = 4,
			activity_id = arg_1_0.viewComponent.activity.id
		})

		return
	end)
	arg_1_0:bind(var_0_0.EVENT_OPEN_BIRTHDAY, function(arg_5_0, arg_5_1)
		arg_1_0:addSubLayers(Context.New({
			mediator = ChargeBirthdayMediator,
			viewComponent = ChargeBirthdayLayer,
			data = {}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_GO, function(arg_6_0, arg_6_1)
		arg_1_0:sendNotification(GAME.TASK_GO, {
			taskVO = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_SUBMIT, function(arg_7_0, arg_7_1)
		arg_1_0:sendNotification(GAME.SUBMIT_TASK, arg_7_1.id)

		return
	end)
	arg_1_0:bind(var_0_0.ON_TASK_QUICK_SUBMIT, function(arg_8_0, arg_8_1)
		arg_1_0:sendNotification(GAME.QUICK_TASK, arg_8_1.id)

		return
	end)
	arg_1_0:bind(var_0_0.ON_CRUISE_SHOPPING, function(arg_9_0, arg_9_1, arg_9_2)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_9_1,
			count = arg_9_2
		})

		return
	end)
	arg_1_0.viewComponent:setActivity((getProxy(ActivityProxy):getAliveActivityByType(ActivityConst.ACTIVITY_TYPE_PT_CRUSING)))
	arg_1_0.viewComponent:setPlayer(getProxy(PlayerProxy):getData())

	return
end

function var_0_0.listNotificationInterests(arg_10_0)
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

function var_0_0.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1:getBody()

	if var_11_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_11_1.id == arg_11_0.viewComponent.activity.id then
			arg_11_0.viewComponent:setActivity(var_11_1)
			arg_11_0.viewComponent:UpdatePhase()
			arg_11_0.viewComponent:UpdateAwardPage()
			arg_11_0.viewComponent:UpdateTaskPage()
			arg_11_0.viewComponent:UpdateView()
		end
	elseif var_11_0 == GAME.CRUSING_CMD_DONE then
		arg_11_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards)
		arg_11_0.viewComponent:UpdateAwardPage()
		arg_11_0.viewComponent:UpdateView()
	elseif var_11_0 == PlayerProxy.UPDATED then
		arg_11_0.viewComponent:setPlayer(var_11_1)
		arg_11_0.viewComponent:UpdateRes()
	elseif var_11_0 == GAME.CHARGE_SUCCESS then
		arg_11_0.viewComponent:OnChargeSuccess((Goods.Create({
			shop_id = var_11_1.shopId
		}, Goods.TYPE_CHARGE)))
		arg_11_0.viewComponent:UpdateRes()
	elseif var_11_0 == BagProxy.ITEM_UPDATED then
		if var_11_1.id == Item.QUICK_TASK_PASS_TICKET_ID then
			arg_11_0.viewComponent:UpdateRes()
		end
	elseif var_11_0 == GAME.SUBMIT_TASK_DONE or var_11_0 == GAME.SUBMIT_ACTIVITY_TASK_DONE then
		arg_11_0.viewComponent:UpdateTaskPage()
		arg_11_0.viewComponent:UpdateView()
	elseif var_11_0 == GAME.SHOPPING_DONE then
		arg_11_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_11_1.awards)
		arg_11_0.viewComponent:UpdateShopPage()
	elseif var_11_0 == ShopsProxy.CRUISE_SHOP_UPDATED then
		arg_11_0.viewComponent:setShop(var_11_1.shop)
		arg_11_0.viewComponent:UpdateShopPage()
	end

	return
end

return var_0_0
