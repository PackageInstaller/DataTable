local var_0_0 = class("AmusementParkShopMediator", import("view.base.ContextMediator"))

var_0_0.ON_ACT_SHOPPING = "AmusementParkShopMediator:ON_ACT_SHOPPING"
var_0_0.GO_SCENE = "GO_SCENE"

function var_0_0.register(arg_1_0)
	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD)

	assert(var_1_0, "Activity Type ACTIVITY_TYPE_SHOP_PROGRESS_REWARD Not exist")
	arg_1_0:TransActivity2ShopData(var_1_0)
	arg_1_0:AddSpecialList(var_1_0)
	arg_1_0:bind(var_0_0.ON_ACT_SHOPPING, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		arg_1_0:sendNotification(GAME.ACTIVITY_SHOP_PROGRESS_REWARD, {
			activity_id = arg_2_1,
			cmd = arg_2_2,
			arg1 = arg_2_3,
			arg2 = arg_2_4
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		arg_1_0:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	arg_1_0:HandleSpecialReach(var_1_0)

	return
end

function var_0_0.TransActivity2ShopData(arg_4_0, arg_4_1)
	if arg_4_1 and not arg_4_1:isEnd() then
		arg_4_0.viewComponent:SetShop((ActivityShop.New(arg_4_1)))
	end

	return
end

function var_0_0.AddSpecialList(arg_5_0, arg_5_1)
	if pg.gameset.activity_lottery_rewards then
		local var_5_0 = pg.gameset.activity_lottery_rewards.description or {}

		for iter_5_0, iter_5_1 in ipairs(var_5_0) do
			local var_5_1 = Drop.Create(iter_5_1[2])

			var_5_1.HasGot = table.contains(arg_5_1.data3_list, iter_5_1[1])

			table.insert({}, var_5_1)
		end
	end

	arg_5_0.viewComponent:SetSpecial({})

	return
end

function var_0_0.HandleSpecialReach(arg_6_0, arg_6_1)
	if not pg.gameset.activity_lottery_rewards or not pg.gameset.activity_lottery_rewards.description then
		return
	end

	local var_6_0 = _.reduce(arg_6_1.data2_list, 0, function(arg_7_0, arg_7_1)
		return arg_7_0 + arg_7_1
	end)

	for iter_6_0, iter_6_1 in ipairs(pg.gameset.activity_lottery_rewards.description) do
		if var_6_0 >= iter_6_1[1] and not table.contains(arg_6_1.data3_list, iter_6_1[1]) then
			arg_6_0:sendNotification(GAME.ACTIVITY_SHOP_PROGRESS_REWARD, {
				cmd = 2,
				arg2 = 0,
				activity_id = arg_6_1.id,
				arg1 = iter_6_1[1]
			})

			return true
		end
	end

	return false
end

function var_0_0.listNotificationInterests(arg_8_0)
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityShopWithProgressRewardCommand.SHOW_SHOP_REWARD
	}
end

function var_0_0.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_9_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD then
			arg_9_0:TransActivity2ShopData(var_9_1)
			arg_9_0:AddSpecialList(var_9_1)
			arg_9_0.viewComponent:UpdateView()
			arg_9_0:HandleSpecialReach(var_9_1)
		end
	elseif var_9_0 == ActivityShopWithProgressRewardCommand.SHOW_SHOP_REWARD then
		arg_9_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1.awards, function()
			if var_9_1.shopType == 1 then
				arg_9_0.viewComponent:ShowShipWord(i18n("amusementpark_shop_success"))
			elseif var_9_1.shopType == 2 then
				arg_9_0.viewComponent:ShowShipWord(i18n("amusementpark_shop_special"))
			end

			existCall(var_9_1.callback)

			return
		end)
	end

	return
end

return var_0_0
