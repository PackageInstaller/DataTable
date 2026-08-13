class = var_0_10000

local var_0_0 = "NewBackYardShopMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.ON_SHOPPING = "NewBackYardShopMediator:ON_SHOPPING"
var_0_1.ON_CHARGE = "NewBackYardShopMediator:ON_CHARGE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_SHOPPING, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.BUY_FURNITURE, {
			furnitureIds = arg_2_1,
			type = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_CHARGE, function(arg_3_0, arg_3_1)
		local var_3_0

		if arg_1_0.contextData.onDeattch then
			var_3_0 = arg_1_0.contextData
			var_3_0.onDeattch = nil
		end

		getProxy = var_3_0
		ContextProxy = var_2_10003

		local var_3_1 = var_3_0(var_2_10003)
		local var_3_2 = var_2.getCurrentContext(var_3_1)
		local var_3_3 = var_2.getContextByMediator

		CourtYardMediator = var_2_10004

		if var_3_3(var_3_2, var_2_10004) then
			var_3_2 = var_2.data
			var_3_2.skipToCharge = true
		end

		PlayerConst = var_3_2

		local var_3_5

		if arg_3_1 == var_3_2.ResDiamond then
			local var_3_4 = arg_1_0

			var_3_5 = var_3_5.sendNotification
			GAME = var_2_10005
			var_2_10005 = var_2_10005.GO_SCENE
			SCENE = var_2_10006
			var_2_10006 = var_2_10006.CHARGE

			local var_3_6 = {}

			ChargeScene = var_2_10008
			var_3_6.wrap = var_2_10008.TYPE_DIAMOND

			var_3_5(var_3_4, var_2_10005, var_2_10006, var_3_6)
		else
			PlayerConst = var_3_5

			if arg_3_1 == var_3_5.ResDormMoney then
				local var_3_7 = arg_1_0
				local var_3_8 = var_3.sendNotification

				GAME = var_2_10005

				local var_3_9 = var_2_10005.GO_SCENE

				SCENE = var_2_10006

				var_3_8(var_3_7, var_3_9, var_2_10006.EVENT)
			end
		end

		return
	end)

	local var_1_0 = arg_1_0.viewComponent
	local var_1_1 = var_1.SetDorm

	getProxy = var_3
	DormProxy = var_4

	local var_1_2 = var_3(var_4)

	var_1_1(var_1_0, var_3.getRawData(var_1_2))

	local var_1_3 = arg_1_0.viewComponent
	local var_1_4 = var_1.SetPlayer

	getProxy = var_3
	PlayerProxy = var_1_2

	local var_1_5 = var_3(var_1_2)

	var_1_4(var_1_3, var_3.getRawData(var_1_5))

	return
end

function var_0_1.remove(arg_4_0)
	if arg_4_0.contextData.onRemove then
		arg_4_0.contextData.onRemove()
	end

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	PlayerProxy = var_1_10002
	var_5_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_5_0[2] = var_2.BUY_FURNITURE_DONE
	DormProxy = var_2
	var_5_0[3] = var_2.DORM_UPDATEED

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1:getBody()
	local var_6_2 = arg_6_1
	local var_6_3 = arg_6_1.getType(var_6_2)

	PlayerProxy = var_6_2

	if var_6_0 == var_6_2.UPDATED then
		local var_6_4 = arg_6_0.viewComponent

		var_5.PlayerUpdated(var_6_4, var_6_1)
	else
		GAME = var_5

		if var_6_0 == var_5.BUY_FURNITURE_DONE then
			local var_6_5 = arg_6_0.viewComponent

			var_5.FurnituresUpdated(var_6_5, var_6_3)
		else
			DormProxy = var_5

			if var_6_0 == var_5.DORM_UPDATEED then
				local var_6_6 = arg_6_0.viewComponent
				local var_6_7 = var_5.DormUpdated

				getProxy = var_1_10007
				DormProxy = var_1_10008

				local var_6_8 = var_1_10007(var_1_10008)

				var_6_7(var_6_6, var_7.getRawData(var_6_8))
			end
		end
	end

	return
end

return var_0_1
