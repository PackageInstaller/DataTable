class = var_0_10000

local var_0_0 = "AmusementParkShopMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.ON_ACT_SHOPPING = "AmusementParkShopMediator:ON_ACT_SHOPPING"
var_0_1.GO_SCENE = "GO_SCENE"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_1_2 = var_1_1(var_1_0, var_1_10004.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD)

	assert = var_1_0

	var_1_0(var_1_2, "Activity Type ACTIVITY_TYPE_SHOP_PROGRESS_REWARD Not exist")
	arg_1_0:TransActivity2ShopData(var_1_2)
	arg_1_0:AddSpecialList(var_1_2)
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
	arg_1_0:bind(var_0_1.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		GAME = var_2_10004

		var_3_1(var_3_0, var_2_10004.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_1_0:HandleSpecialReach(var_1_2)

	return
end

function var_0_1.TransActivity2ShopData(arg_4_0, arg_4_1)
	if arg_4_1 and not arg_4_1:isEnd() then
		ActivityShop = var_2

		local var_4_0 = var_2.New(arg_4_1)
		local var_4_1 = arg_4_0.viewComponent

		var_3.SetShop(var_4_1, var_4_0)
	end

	return
end

function var_0_1.AddSpecialList(arg_5_0, arg_5_1)
	local var_5_0 = {}

	pg = var_1_10003

	if var_1_10003.gameset.activity_lottery_rewards then
		ipairs = var_3
		pg = var_1_10004

		local var_5_1

		if not var_1_10004.gameset.activity_lottery_rewards.description then
			var_5_1 = {}
		end

		for iter_5_0, iter_5_1 in var_3(var_5_1) do
			Drop = var_1_10008
			var_1_10008 = var_1_10008.Create(iter_5_1[2])
			table = var_9
			var_1_10008.HasGot = var_9.contains(arg_5_1.data3_list, iter_5_1[1])
			table = var_9

			var_9.insert(var_5_0, var_1_10008)
		end
	end

	local var_5_2 = arg_5_0.viewComponent

	var_3.SetSpecial(var_5_2, var_5_0)

	return
end

function var_0_1.HandleSpecialReach(arg_6_0, arg_6_1)
	pg = var_1_10002

	if var_1_10002.gameset.activity_lottery_rewards then
		pg = var_2

		if not var_2.gameset.activity_lottery_rewards.description then
			return
		end

		_ = var_2

		local var_6_0 = var_2.reduce(arg_6_1.data2_list, 0, function(arg_7_0, arg_7_1)
			return arg_7_0 + arg_7_1
		end)

		ipairs = var_3
		pg = var_4

		for iter_6_0, iter_6_1 in var_3(var_4.gameset.activity_lottery_rewards.description) do
			if iter_6_1[1] <= var_6_0 then
				table = var_8

				if not var_8.contains(arg_6_1.data3_list, iter_6_1[1]) then
					local var_6_1 = arg_6_0
					local var_6_2 = arg_6_0.sendNotification

					GAME = var_10

					var_6_2(var_6_1, var_10.ACTIVITY_SHOP_PROGRESS_REWARD, {
						cmd = 2,
						arg2 = 0,
						activity_id = arg_6_1.id,
						arg1 = iter_6_1[1]
					})

					return true
				end
			end
		end

		return false
	end
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	ActivityProxy = var_1_10002
	var_8_0[1] = var_1_10002.ACTIVITY_UPDATED
	ActivityShopWithProgressRewardCommand = var_2
	var_8_0[2] = var_2.SHOW_SHOP_REWARD

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_1.getBody(var_9_1)

	ActivityProxy = var_9_1

	local var_9_4

	if var_9_0 == var_9_1.ACTIVITY_UPDATED then
		local var_9_3 = var_9_2

		var_9_4 = var_9_2.getConfig(var_9_3, "type")
		ActivityConst = var_9_3

		if var_9_4 == var_9_3.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD then
			var_9_4 = var_9_2
			var_1_10006 = arg_9_0

			arg_9_0.TransActivity2ShopData(var_1_10006, var_9_4)

			var_1_10006 = arg_9_0

			arg_9_0.AddSpecialList(var_1_10006, var_9_4)

			var_1_10006 = arg_9_0.viewComponent

			var_5.UpdateView(var_1_10006)

			var_1_10006 = arg_9_0

			arg_9_0.HandleSpecialReach(var_1_10006, var_9_4)
		end
	else
		ActivityShopWithProgressRewardCommand = var_9_4

		if var_9_0 == var_9_4.SHOW_SHOP_REWARD then
			local var_9_5 = arg_9_0.viewComponent
			local var_9_6 = var_4.emit

			BaseUI = var_1_10006

			var_9_6(var_9_5, var_1_10006.ON_ACHIEVE, var_9_2.awards, function()
				local var_10_1

				if var_9_2.shopType == 1 then
					local var_10_0 = arg_9_0.viewComponent

					var_10_1 = var_10_1.ShowShipWord
					i18n = var_2_10002

					var_10_1(var_10_0, var_2_10002("amusementpark_shop_success"))
				elseif var_9_2.shopType == 2 then
					local var_10_2 = arg_9_0.viewComponent

					var_10_1 = var_10_1.ShowShipWord
					i18n = var_2_10002

					var_10_1(var_10_2, var_2_10002("amusementpark_shop_special"))
				end

				existCall = var_10_1

				var_10_1(var_9_2.callback)

				return
			end)
		end
	end

	return
end

return var_0_1
