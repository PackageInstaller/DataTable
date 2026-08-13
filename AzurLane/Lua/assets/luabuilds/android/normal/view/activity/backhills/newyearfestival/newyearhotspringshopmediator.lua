class = var_0_10000

local var_0_0 = "NewYearHotSpringShopMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_ACT_SHOPPING = "NewYearHotSpringShopMediator:ON_ACT_SHOPPING"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = var_1.getActivityById

	ActivityConst = var_1_10004

	local var_1_2 = var_1_1(var_1_0, var_1_10004.HOTSPRING_SHOP)

	arg_1_0:TransActivity2ShopData(var_1_2)
	arg_1_0:bind(var_0_1.ON_ACT_SHOPPING, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		local var_2_0 = arg_1_0
		local var_2_1 = var_5.sendNotification

		GAME = var_2_10007

		var_2_1(var_2_0, var_2_10007.ACTIVITY_SHOP_PROGRESS_REWARD, {
			activity_id = arg_2_1,
			cmd = arg_2_2,
			arg1 = arg_2_3,
			arg2 = arg_2_4
		})

		return
	end)

	local var_1_3 = arg_1_0
	local var_1_4 = arg_1_0.bind

	GAME = var_5

	var_1_4(var_1_3, var_5.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.GO_SCENE, arg_3_1, ...)

		return
	end)

	return
end

function var_0_1.TransActivity2ShopData(arg_4_0, arg_4_1)
	if arg_4_1 and not arg_4_1:isEnd() then
		ActivityShop = var_2

		local var_4_0 = var_2.New(arg_4_1)
		local var_4_1 = arg_4_0.viewComponent

		var_3.SetShop(var_4_1, var_4_0)

		return var_4_0
	end

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	ActivityProxy = var_1_10002
	var_5_0[1] = var_1_10002.ACTIVITY_UPDATED
	ActivityShopWithProgressRewardCommand = var_2
	var_5_0[2] = var_2.SHOW_SHOP_REWARD

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1:getName()
	local var_6_1 = arg_6_1
	local var_6_2 = arg_6_1.getBody(var_6_1)

	ActivityProxy = var_6_1

	local var_6_3

	if var_6_0 == var_6_1.ACTIVITY_UPDATED then
		var_6_3 = var_6_2.id
		ActivityConst = var_1_10005

		if var_6_3 == var_1_10005.HOTSPRING_SHOP then
			var_6_3 = var_6_2
			var_1_10006 = arg_6_0

			arg_6_0.TransActivity2ShopData(var_1_10006, var_6_3)

			var_1_10006 = arg_6_0.viewComponent

			var_5.UpdateView(var_1_10006)
		end
	else
		ActivityShopWithProgressRewardCommand = var_6_3

		if var_6_0 == var_6_3.SHOW_SHOP_REWARD then
			local var_6_4 = arg_6_0.viewComponent
			local var_6_5 = var_4.emit

			BaseUI = var_1_10006

			var_6_5(var_6_4, var_1_10006.ON_ACHIEVE, var_6_2.awards, function()
				local var_7_0 = arg_6_0.viewComponent

				var_0.OnShoppingDone(var_7_0)

				existCall = var_0

				var_0(var_6_2.callback)

				return
			end)
		end
	end

	return
end

return var_0_1
