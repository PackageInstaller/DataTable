local var_0_0 = class("ThirdVolumeHeroTrialView", HeroTrialActivityView)

function var_0_0.UIName(arg_1_0)
	if ActivityTools.GetActivityTheme(arg_1_0.params_.activityID) == ActivityConst.THEME.VOLUME_DOWN then
		return "UI/VolumeIIIDownUI/HeroTrial/VolumeIIIDownHeroTrialUI"
	else
		return "UI/VolumeIIIUI/VolumeHeroTrialUI"
	end
end

function var_0_0.RefreshTextName(arg_2_0, arg_2_1)
	local var_2_0 = string.split(arg_2_1, "·")

	arg_2_0.textName_.text = GetI18NText(arg_2_1)
end

return var_0_0
