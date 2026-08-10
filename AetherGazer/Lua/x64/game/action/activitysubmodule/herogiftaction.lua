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

function var_0_0.OnQueryReceiveHeroGiftCallBack(arg_3_0, arg_3_1)
	if isSuccess(arg_3_0.result) then
		local var_3_0 = arg_3_0.reward_list

		getReward2(var_3_0)
		HeroGiftData:SetReceiveHeroGift(arg_3_1.activity_id)
		manager.notify:CallUpdateFunc(HERO_GIFT_REWARD)
	end
end

return var_0_0
