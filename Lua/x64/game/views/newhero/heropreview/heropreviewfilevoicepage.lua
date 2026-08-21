local var_0_0 = class("HeroPreviewFileVoicePage", HeroFileVoicePage)

function var_0_0.CameraEnter(arg_1_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	}, arg_1_0.displayGo_)
end

return var_0_0
