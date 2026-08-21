local var_0_0 = import("game.views.heroTrialActivity.HeroTrialActivityView")
local var_0_1 = class("FactoryHeroTrialView", var_0_0)

function var_0_1.UIName(arg_1_0)
	return "UI/MardukUI/HeroTrial/MardukHeroTrialUI"
end

function var_0_1.RefreshTextName(arg_2_0, arg_2_1)
	arg_2_0.textName_.text = GetI18NText(string.format("<size=46>%s</size>", arg_2_1))
end

function var_0_1.GetRewardItem(arg_3_0, arg_3_1)
	return RewardPoolFactoryItem.New(arg_3_0.goRewardPanel_, arg_3_1, true)
end

function var_0_1.GetActiviteHeroIDList(arg_4_0)
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
		var_4_1[#var_4_1 + 1] = arg_4_0.activiteID_
	end

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		for iter_4_2, iter_4_3 in pairs(ActivityHeroTrialCfg.get_id_list_by_activity_id[iter_4_1]) do
			table.insert(var_4_0, iter_4_3)
		end
	end

	return var_4_0
end

return var_0_1
