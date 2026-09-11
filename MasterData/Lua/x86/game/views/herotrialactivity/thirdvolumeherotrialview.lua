local ThirdVolumeHeroTrialView = class("ThirdVolumeHeroTrialView", HeroTrialActivityView)

function ThirdVolumeHeroTrialView:UIName()
	if ActivityTools.GetActivityTheme(self.params_.activityID) == ActivityConst.THEME.VOLUME_DOWN then
		return "UI/VolumeIIIDownUI/HeroTrial/VolumeIIIDownHeroTrialUI"
	else
		return "UI/VolumeIIIUI/VolumeHeroTrialUI"
	end
end

function ThirdVolumeHeroTrialView:RefreshTextName(arg_2_1)
	local var_2_0 = string.split(arg_2_1, "·")

	self.textName_.text = GetI18NText(arg_2_1)
end

return ThirdVolumeHeroTrialView
