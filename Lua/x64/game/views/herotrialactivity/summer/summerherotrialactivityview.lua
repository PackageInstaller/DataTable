local var_0_0 = class("SummerHeroTrialActivityView", HeroTrialActivityView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/SummerUI/SummerHeroTrialUI"
end

function var_0_0.RefreshTextName(arg_2_0, arg_2_1)
	local var_2_0 = string.split(arg_2_1, "·")

	arg_2_0.textName_.text = GetI18NText(arg_2_1)
end

return var_0_0
