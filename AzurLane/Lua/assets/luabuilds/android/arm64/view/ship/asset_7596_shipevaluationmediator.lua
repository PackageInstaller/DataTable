class = var_0_10000

local var_0_0 = "ShipEvaluationMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	CollectionProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)

	arg_1_0.showTrans = arg_1_0.contextData.showTrans
	arg_1_0.groupId = arg_1_0.contextData.groupId

	local var_1_1 = var_1_0:getShipGroup(arg_1_0.groupId)
	local var_1_2 = arg_1_0.viewComponent

	var_3.setShipGroup(var_1_2, var_1_1)

	local var_1_3 = arg_1_0.viewComponent

	var_3.setShowTrans(var_1_3, arg_1_0.showTrans)

	local var_1_4 = arg_1_0.viewComponent

	var_3.flushAll(var_1_4)

	local var_1_5 = arg_1_0
	local var_1_6 = arg_1_0.bind

	ShipEvaluationLayer = var_6

	var_1_6(var_1_5, var_6.EVENT_LIKE, function(arg_2_0)
		local var_2_0 = arg_1_0
		local var_2_1 = var_1.sendNotification

		GAME = var_2_10004

		var_2_1(var_2_0, var_2_10004.LIKE_SHIP, arg_1_0.groupId)

		return
	end)

	local var_1_7 = arg_1_0
	local var_1_8 = arg_1_0.bind

	ShipEvaluationLayer = var_6

	var_1_8(var_1_7, var_6.EVENT_EVA, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.EVALUATE_SHIP, {
			groupId = arg_1_0.groupId,
			content = arg_3_1
		})

		return
	end)

	local var_1_9 = arg_1_0
	local var_1_10 = arg_1_0.bind

	ShipEvaluationLayer = var_6

	var_1_10(var_1_9, var_6.EVENT_ZAN, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10006

		var_4_1(var_4_0, var_2_10006.ZAN_SHIP_EVALUATION, {
			groupId = arg_1_0.groupId,
			evaId = arg_4_1,
			operation = arg_4_2
		})

		return
	end)

	local var_1_11 = arg_1_0
	local var_1_12 = arg_1_0.bind

	ShipEvaluationLayer = var_6

	var_1_12(var_1_11, var_6.EVENT_IMPEACH, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10006

		var_5_1(var_5_0, var_2_10006.IMPEACH_SHIP_EVALUATION, {
			groupId = arg_1_0.groupId,
			evaId = arg_5_1,
			reason = arg_5_2
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_6_0)
	local var_6_0 = {}

	CollectionProxy = var_1_10002
	var_6_0[1] = var_1_10002.GROUP_INFO_UPDATE
	CollectionProxy = var_2
	var_6_0[2] = var_2.GROUP_EVALUATION_UPDATE

	return var_6_0
end

function var_0_1.handleNotification(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1
	local var_7_1 = arg_7_1.getName(var_7_0)
	local var_7_2 = arg_7_1:getBody()

	CollectionProxy = var_7_0

	local var_7_3

	if var_7_1 == var_7_0.GROUP_INFO_UPDATE then
		var_7_3 = var_7_2

		if arg_7_0.groupId == var_7_3 then
			getProxy = var_5
			CollectionProxy = var_1_10007

			local var_7_4 = var_5(var_1_10007)
			local var_7_5 = var_5.getShipGroup(var_7_4, var_7_3)
			local var_7_6 = arg_7_0.viewComponent

			var_1_10007.setShipGroup(var_7_6, var_7_5)

			local var_7_7 = arg_7_0.viewComponent

			var_1_10007.flushHeart(var_7_7)
		end
	else
		CollectionProxy = var_7_3

		if var_7_1 == var_7_3.GROUP_EVALUATION_UPDATE then
			local var_7_8 = var_7_2

			if arg_7_0.groupId == var_7_8 then
				getProxy = var_5
				CollectionProxy = var_1_10007

				local var_7_9 = var_5(var_1_10007)
				local var_7_10 = var_5.getShipGroup(var_7_9, var_7_8)
				local var_7_11 = arg_7_0.viewComponent

				var_7.setShipGroup(var_7_11, var_7_10)

				local var_7_12 = arg_7_0.viewComponent

				var_7.flushEva(var_7_12)
			end
		end
	end

	return
end

return var_0_1
