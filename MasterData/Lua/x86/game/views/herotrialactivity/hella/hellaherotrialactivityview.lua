local HellaHeroTrialActivityView = class("HellaHeroTrialActivityView", HeroTrialActivityView)

function HellaHeroTrialActivityView:UIName()
	return "UI/VersionUI/HellaUI/HellaHeroTrialUI"
end

function HellaHeroTrialActivityView:RefreshTextName(arg_2_1)
	local var_2_0 = string.split(arg_2_1, "·")

	self.textName_.text = string.format("<size=46>%s</size><size=32>·%s</size>", GetI18NText(var_2_0[1]), GetI18NText(var_2_0[2]))
end

return HellaHeroTrialActivityView
