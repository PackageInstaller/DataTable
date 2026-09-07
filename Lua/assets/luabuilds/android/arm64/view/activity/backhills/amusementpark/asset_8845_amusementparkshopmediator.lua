local AmusementParkShopMediator = class("AmusementParkShopMediator", import("view.base.ContextMediator"))

AmusementParkShopMediator.ON_ACT_SHOPPING = "AmusementParkShopMediator:ON_ACT_SHOPPING"
AmusementParkShopMediator.GO_SCENE = "GO_SCENE"

function AmusementParkShopMediator:register()
	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD)

	assert(var_1_0, "Activity Type ACTIVITY_TYPE_SHOP_PROGRESS_REWARD Not exist")
	self:TransActivity2ShopData(var_1_0)
	self:AddSpecialList(var_1_0)
	self:bind(AmusementParkShopMediator.ON_ACT_SHOPPING, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
		self:sendNotification(GAME.ACTIVITY_SHOP_PROGRESS_REWARD, {
			activity_id = arg_2_1,
			cmd = arg_2_2,
			arg1 = arg_2_3,
			arg2 = arg_2_4
		})

		return
	end)
	self:bind(AmusementParkShopMediator.GO_SCENE, function(arg_3_0, arg_3_1, ...)
		self:sendNotification(GAME.GO_SCENE, arg_3_1, ...)

		return
	end)
	self:HandleSpecialReach(var_1_0)

	return
end

function AmusementParkShopMediator:TransActivity2ShopData(arg_4_1)
	if arg_4_1 and not arg_4_1:isEnd() then
		self.viewComponent:SetShop((ActivityShop.New(arg_4_1)))
	end

	return
end

function AmusementParkShopMediator:AddSpecialList(arg_5_1)
	local var_5_0 = {}

	if pg.gameset.activity_lottery_rewards then
		for iter_5_0, iter_5_1 in ipairs(pg.gameset.activity_lottery_rewards.description or {}) do
			local var_5_2 = Drop.Create(iter_5_1[2])

			var_5_2.HasGot = table.contains(arg_5_1.data3_list, iter_5_1[1])

			table.insert(var_5_0, var_5_2)
		end
	end

	self.viewComponent:SetSpecial(var_5_0)

	return
end

function AmusementParkShopMediator:HandleSpecialReach(arg_6_1)
	if not pg.gameset.activity_lottery_rewards or not pg.gameset.activity_lottery_rewards.description then
		return
	end

	local var_6_0 = _.reduce(arg_6_1.data2_list, 0, function(arg_7_0, arg_7_1)
		return arg_7_0 + arg_7_1
	end)

	for iter_6_0, iter_6_1 in ipairs(pg.gameset.activity_lottery_rewards.description) do
		if var_6_0 >= iter_6_1[1] and not table.contains(arg_6_1.data3_list, iter_6_1[1]) then
			self:sendNotification(GAME.ACTIVITY_SHOP_PROGRESS_REWARD, {
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

function AmusementParkShopMediator:listNotificationInterests()
	return {
		ActivityProxy.ACTIVITY_UPDATED,
		ActivityShopWithProgressRewardCommand.SHOW_SHOP_REWARD
	}
end

function AmusementParkShopMediator:handleNotification(arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1:getBody()

	if var_9_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_9_1:getConfig("type") == ActivityConst.ACTIVITY_TYPE_SHOP_PROGRESS_REWARD then
			self:TransActivity2ShopData(var_9_1)
			self:AddSpecialList(var_9_1)
			self.viewComponent:UpdateView()
			self:HandleSpecialReach(var_9_1)
		end
	elseif var_9_0 == ActivityShopWithProgressRewardCommand.SHOW_SHOP_REWARD then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_9_1.awards, function()
			if var_9_1.shopType == 1 then
				self.viewComponent:ShowShipWord(i18n("amusementpark_shop_success"))
			elseif var_9_1.shopType == 2 then
				self.viewComponent:ShowShipWord(i18n("amusementpark_shop_special"))
			end

			existCall(var_9_1.callback)

			return
		end)
	end

	return
end

return AmusementParkShopMediator
