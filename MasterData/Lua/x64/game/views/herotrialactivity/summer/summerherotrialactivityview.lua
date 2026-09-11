local SummerHeroTrialActivityView = class("SummerHeroTrialActivityView", HeroTrialActivityView)

function SummerHeroTrialActivityView:UIName()
	return "UI/VersionUI/SummerUI/SummerHeroTrialUI"
end

function SummerHeroTrialActivityView:RefreshTextName(arg_2_1)
	local var_2_0 = string.split(arg_2_1, "·")

	self.textName_.text = GetI18NText(arg_2_1)
end

return SummerHeroTrialActivityView
