local FactoryHeroTrialView = class("FactoryHeroTrialView", (import("game.views.heroTrialActivity.HeroTrialActivityView")))

function FactoryHeroTrialView:UIName()
	return "UI/MardukUI/HeroTrial/MardukHeroTrialUI"
end

function FactoryHeroTrialView:RefreshTextName(arg_2_1)
	self.textName_.text = GetI18NText(string.format("<size=46>%s</size>", arg_2_1))
end

function FactoryHeroTrialView:GetRewardItem(arg_3_1)
	return RewardPoolFactoryItem.New(self.goRewardPanel_, arg_3_1, true)
end

function FactoryHeroTrialView:GetActiviteHeroIDList()
	local var_4_0 = {}
	local var_4_1 = {}

	if SDKTools.GetIsOverSea() then
		if ActivityData:GetActivityIsOpen(ActivityConst.FACTORY_HERO_TRIAL_1_OVERSEA) then
			var_4_1[#var_4_1 + 1] = ActivityConst.FACTORY_HERO_TRIAL_1_OVERSEA
		end

		if ActivityData:GetActivityIsOpen(ActivityConst.FACTORY_HERO_TRIAL_2_OVERSEA) then
			var_4_1[#var_4_1 + 1] = ActivityConst.FACTORY_HERO_TRIAL_2_OVERSEA
		end
	else
		var_4_1[#var_4_1 + 1] = self.activiteID_
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		for iter_4_2, iter_4_3 in pairs(ActivityHeroTrialCfg.get_id_list_by_activity_id[iter_4_1]) do
			table.insert(var_4_0, iter_4_3)
		end
	end

	return var_4_0
end

return FactoryHeroTrialView
