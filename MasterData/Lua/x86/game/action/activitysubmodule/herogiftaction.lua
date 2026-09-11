local var_0_0 = {}

manager.net:Bind(61001, function(arg_1_0)
	HeroGiftData:InitData(arg_1_0)
	manager.notify:CallUpdateFunc(HERO_GIFT_REWARD)
end)

function var_0_0.QueryReceiveHeroGift(arg_2_0)
	manager.net:SendWithLoadingNew(61002, {
		activity_id = arg_2_0
	}, 61003, var_0_0.OnQueryReceiveHeroGiftCallBack)
end

function var_0_0:OnQueryReceiveHeroGiftCallBack(arg_3_1)
	if isSuccess(self.result) then
		getReward2(self.reward_list)
		HeroGiftData:SetReceiveHeroGift(arg_3_1.activity_id)
		manager.notify:CallUpdateFunc(HERO_GIFT_REWARD)
	end
end

return var_0_0
