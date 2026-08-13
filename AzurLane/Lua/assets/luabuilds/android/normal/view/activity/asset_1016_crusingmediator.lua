class = var_0_10000

local var_0_0 = "CrusingMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.UNFROZEN_MAP_UPDATE = "CrusingMediator.UN_FROZEN_MAP_UPDATE"
var_0_1.EVENT_OPEN_TASK = "CrusingMediator.EVENT_OPEN_TASK"
var_0_1.EVENT_GET_AWARD = "CrusingMediator.EVENT_GET_AWARD"
var_0_1.EVENT_GET_AWARD_PAY = "CrusingMediator.EVENT_GET_AWARD_PAY"
var_0_1.EVENT_GET_AWARD_ALL = "CrusingMediator.EVENT_GET_AWARD_ALL"
var_0_1.EVENT_GO_CHARGE = "CrusingMediator.EVENT_GO_CHARGE"
var_0_1.EVENT_OPEN_BIRTHDAY = "CrusingMediator.EVENT_OPEN_BIRTHDAY"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.EVENT_OPEN_TASK, function(arg_2_0)
		arg_1_0.contextData.frozenMapUpdate = true

		local var_2_0 = arg_1_0
		local var_2_1 = var_1.addSubLayers

		Context = var_2_10003

		local var_2_2 = var_2_10003.New
		local var_2_3 = {}

		CrusingTaskMediator = var_2_10005
		var_2_3.mediator = var_2_10005
		CrusingTaskLayer = var_2_10005
		var_2_3.viewComponent = var_2_10005

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_GET_AWARD, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.CRUSING_CMD, {
			cmd = 2,
			activity_id = arg_1_0.viewComponent.activity.id,
			arg1 = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_GET_AWARD_PAY, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.CRUSING_CMD, {
			cmd = 3,
			activity_id = arg_1_0.viewComponent.activity.id,
			arg1 = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_GET_AWARD_ALL, function(arg_5_0)
		local var_5_0 = arg_1_0
		local var_5_1 = var_1.sendNotification

		GAME = var_2_10003

		var_5_1(var_5_0, var_2_10003.CRUSING_CMD, {
			cmd = 4,
			activity_id = arg_1_0.viewComponent.activity.id
		})

		return
	end)
	arg_1_0:bind(var_0_1.EVENT_GO_CHARGE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_6_2 = var_2_10004.New
		local var_6_3 = {}

		ChargeItemPanelMediator = var_2_10006
		var_6_3.mediator = var_2_10006
		ChargeItemPanelLayer = var_2_10006
		var_6_3.viewComponent = var_2_10006
		var_6_3.data = {
			panelConfig = arg_6_1
		}

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.EVENT_OPEN_BIRTHDAY, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_7_2 = var_2_10004.New
		local var_7_3 = {}

		ChargeBirthdayMediator = var_2_10006
		var_7_3.mediator = var_2_10006
		ChargeBirthdayLayer = var_2_10006
		var_7_3.viewComponent = var_2_10006
		var_7_3.data = {}

		var_7_1(var_7_0, var_7_2(var_7_3))

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

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	ActivityProxy = var_1_10002
	var_8_0[1] = var_1_10002.ACTIVITY_UPDATED
	GAME = var_2
	var_8_0[2] = var_2.CRUSING_CMD_DONE
	var_8_0[3] = var_0_1.UNFROZEN_MAP_UPDATE
	PlayerProxy = var_2
	var_8_0[4] = var_2.UPDATED
	GAME = var_2
	var_8_0[5] = var_2.CHARGE_SUCCESS

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_1.getBody(var_9_1)

	ActivityProxy = var_9_1

	if var_9_0 == var_9_1.ACTIVITY_UPDATED then
		if var_9_2.id == arg_9_0.viewComponent.activity.id then
			local var_9_3 = arg_9_0.viewComponent

			var_4.setActivity(var_9_3, var_9_2)

			local var_9_4 = arg_9_0.viewComponent

			var_4.updateAwardPanel(var_9_4)

			local var_9_5 = arg_9_0.viewComponent

			var_4.updateMapStatus(var_9_5)

			local var_9_6 = arg_9_0.viewComponent

			var_4.updateMapWay(var_9_6)
		end
	else
		GAME = var_4

		if var_9_0 == var_4.CRUSING_CMD_DONE then
			local var_9_7 = arg_9_0.viewComponent
			local var_9_8 = var_4.emit

			BaseUI = var_1_10006

			var_9_8(var_9_7, var_1_10006.ON_ACHIEVE, var_9_2.awards)
		else
			local var_9_9

			if var_9_0 == var_0_1.UNFROZEN_MAP_UPDATE then
				var_9_9 = arg_9_0.contextData
				var_9_9.frozenMapUpdate = false

				local var_9_10 = arg_9_0.viewComponent

				var_9_9.updateMapWay(var_9_10)
			else
				PlayerProxy = var_9_9

				if var_9_0 == var_9_9.UPDATED then
					local var_9_11 = arg_9_0.viewComponent

					var_4.setPlayer(var_9_11, var_9_2)
				else
					GAME = var_4

					if var_9_0 == var_4.CHARGE_SUCCESS then
						Goods = var_4

						local var_9_12 = var_4.Create
						local var_9_13 = {
							shop_id = var_9_2.shopId
						}

						Goods = var_6

						local var_9_14 = var_9_12(var_9_13, var_6.TYPE_CHARGE)
						local var_9_15 = arg_9_0.viewComponent

						var_5.OnChargeSuccess(var_9_15, var_9_14)
					end
				end
			end
		end
	end

	return
end

return var_0_1
