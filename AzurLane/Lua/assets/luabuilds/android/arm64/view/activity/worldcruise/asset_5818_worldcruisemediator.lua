class = var_0_10000

local var_0_0 = "WorldCruiseMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.EVENT_GET_AWARD = "WorldCruiseMediator.EVENT_GET_AWARD"
var_0_1.EVENT_GET_AWARD_PAY = "WorldCruiseMediator.EVENT_GET_AWARD_PAY"
var_0_1.EVENT_GET_AWARD_ALL = "WorldCruiseMediator.EVENT_GET_AWARD_ALL"
var_0_1.EVENT_OPEN_BIRTHDAY = "WorldCruiseMediator.EVENT_OPEN_BIRTHDAY"
var_0_1.ON_TASK_GO = "WorldCruiseMediator.ON_TASK_GO"
var_0_1.ON_TASK_SUBMIT = "WorldCruiseMediator.ON_TASK_SUBMIT"
var_0_1.ON_TASK_QUICK_SUBMIT = "WorldCruiseMediator.ON_TASK_QUICK_SUBMIT"
var_0_1.ON_CRUISE_SHOPPING = "WorldCruiseMediator.ON_CRUISE_SHOPPING"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.EVENT_GET_AWARD, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.CRUSING_CMD, {
			cmd = 2,
			activity_id = arg_1_0.viewComponent.activity.id,
			arg1 = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_GET_AWARD_PAY, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.CRUSING_CMD, {
			cmd = 3,
			activity_id = arg_1_0.viewComponent.activity.id,
			arg1 = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_GET_AWARD_ALL, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.CRUSING_CMD, {
			cmd = 4,
			activity_id = arg_1_0.viewComponent.activity.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_OPEN_BIRTHDAY, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_5_2 = var_2_10005.New
		local var_5_3 = {}

		ChargeBirthdayMediator = var_2_10008
		var_5_3.mediator = var_2_10008
		ChargeBirthdayLayer = var_2_10008
		var_5_3.viewComponent = var_2_10008
		var_5_3.data = {}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_GO, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.TASK_GO, {
			taskVO = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10005

		var_7_1(var_7_0, var_2_10005.SUBMIT_TASK, arg_7_1.id)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_QUICK_SUBMIT, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10005

		var_8_1(var_8_0, var_2_10005.QUICK_TASK, arg_8_1.id)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_CRUISE_SHOPPING, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_1_0
		local var_9_1 = var_3.sendNotification

		GAME = var_2_10006

		var_9_1(var_9_0, var_2_10006.SHOPPING, {
			id = arg_9_1,
			count = arg_9_2
		})

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getAliveActivityByType

	ActivityConst = var_4

	local var_1_3 = var_1_2(var_1_1, var_4.ACTIVITY_TYPE_PT_CRUSING)
	local var_1_4 = arg_1_0.viewComponent

	var_2.setActivity(var_1_4, var_1_3)

	local var_1_5 = arg_1_0.viewComponent
	local var_1_6 = var_2.setPlayer

	getProxy = var_5
	PlayerProxy = var_1_10007

	local var_1_7 = var_5(var_1_10007)

	var_1_6(var_1_5, var_5.getData(var_1_7))

	return
end

function var_0_1.listNotificationInterests(arg_10_0)
	local var_10_0 = {}

	ActivityProxy = var_1_10002
	var_10_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_10_0[2] = var_2.CRUSING_CMD_DONE
	PlayerProxy = var_2
	var_10_0[3] = var_2.UPDATED
	GAME = var_2
	var_10_0[4] = var_2.CHARGE_SUCCESS
	BagProxy = var_2
	var_10_0[5] = var_2.ITEM_UPDATED
	GAME = var_2
	var_10_0[6] = var_2.SUBMIT_TASK_DONE
	GAME = var_2
	var_10_0[7] = var_2.SUBMIT_ACTIVITY_TASK_DONE
	GAME = var_2
	var_10_0[8] = var_2.SHOPPING_DONE
	ShopsProxy = var_2
	var_10_0[9] = var_2.CRUISE_SHOP_UPDATED

	return var_10_0
end

function var_0_1.handleNotification(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1
	local var_11_1 = arg_11_1.getName(var_11_0)
	local var_11_2 = arg_11_1
	local var_11_3 = arg_11_1.getBody(var_11_2)

	ActivityProxy = var_11_0

	if var_11_1 == var_11_0.ACTIVITY_UPDATED then
		if var_11_3.id == arg_11_0.viewComponent.activity.id then
			local var_11_4 = arg_11_0.viewComponent

			var_4.setActivity(var_11_4, var_11_3)

			local var_11_5 = arg_11_0.viewComponent

			var_4.UpdatePhase(var_11_5)

			local var_11_6 = arg_11_0.viewComponent

			var_4.UpdateAwardPage(var_11_6)

			local var_11_7 = arg_11_0.viewComponent

			var_4.UpdateTaskPage(var_11_7)

			local var_11_8 = arg_11_0.viewComponent

			var_4.UpdateView(var_11_8)
		end

		goto label_11_0
	end

	GAME = var_4

	local var_11_10

	if var_11_1 == var_4.CRUSING_CMD_DONE then
		local var_11_9 = arg_11_0.viewComponent

		var_11_10 = var_11_10.emit
		BaseUI = var_1_10007

		var_11_10(var_11_9, var_1_10007.ON_ACHIEVE, var_11_3.awards)

		local var_11_11 = arg_11_0.viewComponent

		var_11_10.UpdateAwardPage(var_11_11)

		local var_11_12 = arg_11_0.viewComponent

		var_11_10.UpdateView(var_11_12)

		goto label_11_0
	end

	PlayerProxy = var_11_10

	if var_11_1 == var_11_10.UPDATED then
		local var_11_13 = arg_11_0.viewComponent

		var_4.setPlayer(var_11_13, var_11_3)

		local var_11_14 = arg_11_0.viewComponent

		var_4.UpdateRes(var_11_14)

		goto label_11_0
	end

	GAME = var_4

	local var_11_15

	if var_11_1 == var_4.CHARGE_SUCCESS then
		Goods = var_11_15
		var_11_15 = var_11_15.Create

		local var_11_16 = {
			shop_id = var_11_3.shopId
		}

		Goods = var_1_10007
		var_11_15 = var_11_15(var_11_16, var_1_10007.TYPE_CHARGE)
		var_1_10007 = arg_11_0.viewComponent

		var_11_2.OnChargeSuccess(var_1_10007, var_11_15)

		var_1_10007 = arg_11_0.viewComponent

		var_11_2.UpdateRes(var_1_10007)

		goto label_11_0
	end

	BagProxy = var_11_15

	local var_11_17

	if var_11_1 == var_11_15.ITEM_UPDATED then
		var_11_17 = var_11_3.id
		Item = var_11_2

		if var_11_17 == var_11_2.QUICK_TASK_PASS_TICKET_ID then
			local var_11_18 = arg_11_0.viewComponent

			var_11_17.UpdateRes(var_11_18)
		end

		goto label_11_0
	end

	GAME = var_11_17

	if var_11_1 ~= var_11_17.SUBMIT_TASK_DONE then
		GAME = var_4

		if var_11_1 == var_4.SUBMIT_ACTIVITY_TASK_DONE then
			local var_11_19 = arg_11_0.viewComponent

			var_4.UpdateTaskPage(var_11_19)

			local var_11_20 = arg_11_0.viewComponent

			var_4.UpdateView(var_11_20)
		else
			GAME = var_4

			local var_11_22

			if var_11_1 == var_4.SHOPPING_DONE then
				local var_11_21 = arg_11_0.viewComponent

				var_11_22 = var_11_22.emit
				BaseUI = var_1_10007

				var_11_22(var_11_21, var_1_10007.ON_ACHIEVE, var_11_3.awards)

				local var_11_23 = arg_11_0.viewComponent

				var_11_22.UpdateShopPage(var_11_23)
			else
				ShopsProxy = var_11_22

				if var_11_1 == var_11_22.CRUISE_SHOP_UPDATED then
					local var_11_24 = arg_11_0.viewComponent

					var_4.setShop(var_11_24, var_11_3.shop)

					local var_11_25 = arg_11_0.viewComponent

					var_4.UpdateShopPage(var_11_25)
				end
			end
		end

		::label_11_0::

		return
	end
end

return var_0_1
