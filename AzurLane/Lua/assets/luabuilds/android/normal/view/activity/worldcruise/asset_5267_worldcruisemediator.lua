class = var_0_10000

local var_0_0 = "WorldCruiseMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

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

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.CRUSING_CMD, {
			cmd = 2,
			activity_id = arg_1_0.viewComponent.activity.id,
			arg1 = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_GET_AWARD_PAY, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.CRUSING_CMD, {
			cmd = 3,
			activity_id = arg_1_0.viewComponent.activity.id,
			arg1 = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_GET_AWARD_ALL, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10003

		var_4_1(var_4_0, var_2_10003.CRUSING_CMD, {
			cmd = 4,
			activity_id = arg_1_0.viewComponent.activity.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_OPEN_BIRTHDAY, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		ChargeBirthdayMediator = var_2_10006
		var_5_3.mediator = var_2_10006
		ChargeBirthdayLayer = var_2_10006
		var_5_3.viewComponent = var_2_10006
		var_5_3.data = {}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_GO, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		var_6_1(var_6_0, var_2_10004.TASK_GO, {
			taskVO = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_SUBMIT, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10004

		var_7_1(var_7_0, var_2_10004.SUBMIT_TASK, arg_7_1.id)

		return
	end)
	arg_1_0:bind(var_0_1.ON_TASK_QUICK_SUBMIT, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10004

		var_8_1(var_8_0, var_2_10004.QUICK_TASK, arg_8_1.id)

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.ON_CRUISE_SHOPPING, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_1_0
		local var_9_1 = var_3.sendNotification

		GAME = var_2_10005

		var_9_1(var_9_0, var_2_10005.SHOPPING, {
			id = arg_9_1,
			count = arg_9_2
		})

		return
	end)

	getProxy = var_1
	ActivityProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getAliveActivityByType

	ActivityConst = var_3

	local var_1_3 = var_1_2(var_1_1, var_3.ACTIVITY_TYPE_PT_CRUSING)
	local var_1_4 = arg_1_0.viewComponent

	var_2.setActivity(var_1_4, var_1_3)

	local var_1_5 = arg_1_0.viewComponent
	local var_1_6 = var_2.setPlayer

	getProxy = var_4
	PlayerProxy = var_1_10005

	local var_1_7 = var_4(var_1_10005)

	var_1_6(var_1_5, var_4.getData(var_1_7))

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
	local var_11_0 = arg_11_1:getName()
	local var_11_1 = arg_11_1
	local var_11_2 = arg_11_1.getBody(var_11_1)

	ActivityProxy = var_11_1

	if var_11_0 == var_11_1.ACTIVITY_UPDATED then
		if var_11_2.id == arg_11_0.viewComponent.activity.id then
			var_1_10005 = arg_11_0.viewComponent

			var_4.setActivity(var_1_10005, var_11_2)

			var_1_10005 = arg_11_0.viewComponent

			var_4.UpdatePhase(var_1_10005)

			var_1_10005 = arg_11_0.viewComponent

			var_4.UpdateAwardPage(var_1_10005)

			var_1_10005 = arg_11_0.viewComponent

			var_4.UpdateTaskPage(var_1_10005)

			var_1_10005 = arg_11_0.viewComponent

			var_4.UpdateView(var_1_10005)
		end

		goto label_11_0
	end

	GAME = var_4

	local var_11_3

	if var_11_0 == var_4.CRUSING_CMD_DONE then
		var_1_10005 = arg_11_0.viewComponent
		var_11_3 = var_11_3.emit
		BaseUI = var_1_10006

		var_11_3(var_1_10005, var_1_10006.ON_ACHIEVE, var_11_2.awards)

		var_1_10005 = arg_11_0.viewComponent

		var_11_3.UpdateAwardPage(var_1_10005)

		var_1_10005 = arg_11_0.viewComponent

		var_11_3.UpdateView(var_1_10005)

		goto label_11_0
	end

	PlayerProxy = var_11_3

	if var_11_0 == var_11_3.UPDATED then
		var_1_10005 = arg_11_0.viewComponent

		var_4.setPlayer(var_1_10005, var_11_2)

		var_1_10005 = arg_11_0.viewComponent

		var_4.UpdateRes(var_1_10005)

		goto label_11_0
	end

	GAME = var_4

	local var_11_4

	if var_11_0 == var_4.CHARGE_SUCCESS then
		Goods = var_11_4
		var_11_4 = var_11_4.Create
		var_1_10005 = {
			shop_id = var_11_2.shopId
		}
		Goods = var_1_10006
		var_11_4 = var_11_4(var_1_10005, var_1_10006.TYPE_CHARGE)
		var_1_10006 = arg_11_0.viewComponent

		var_1_10005.OnChargeSuccess(var_1_10006, var_11_4)

		var_1_10006 = arg_11_0.viewComponent

		var_1_10005.UpdateRes(var_1_10006)

		goto label_11_0
	end

	BagProxy = var_11_4

	local var_11_5

	if var_11_0 == var_11_4.ITEM_UPDATED then
		var_11_5 = var_11_2.id
		Item = var_1_10005

		if var_11_5 == var_1_10005.QUICK_TASK_PASS_TICKET_ID then
			local var_11_6 = arg_11_0.viewComponent

			var_11_5.UpdateRes(var_11_6)
		end

		goto label_11_0
	end

	GAME = var_11_5

	if var_11_0 ~= var_11_5.SUBMIT_TASK_DONE then
		GAME = var_4

		if var_11_0 == var_4.SUBMIT_ACTIVITY_TASK_DONE then
			local var_11_7 = arg_11_0.viewComponent

			var_4.UpdateTaskPage(var_11_7)

			local var_11_8 = arg_11_0.viewComponent

			var_4.UpdateView(var_11_8)
		else
			GAME = var_4

			local var_11_10

			if var_11_0 == var_4.SHOPPING_DONE then
				local var_11_9 = arg_11_0.viewComponent

				var_11_10 = var_11_10.emit
				BaseUI = var_1_10006

				var_11_10(var_11_9, var_1_10006.ON_ACHIEVE, var_11_2.awards)

				local var_11_11 = arg_11_0.viewComponent

				var_11_10.UpdateShopPage(var_11_11)
			else
				ShopsProxy = var_11_10

				if var_11_0 == var_11_10.CRUISE_SHOP_UPDATED then
					local var_11_12 = arg_11_0.viewComponent

					var_4.setShop(var_11_12, var_11_2.shop)

					local var_11_13 = arg_11_0.viewComponent

					var_4.UpdateShopPage(var_11_13)
				end
			end
		end

		::label_11_0::

		return
	end
end

return var_0_1
