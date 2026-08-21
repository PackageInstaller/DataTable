local var_0_0 = class("HeroPreviewFileArchivePage", HeroFileArchivePage)

function var_0_0.CameraEnter(arg_1_0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	}, arg_1_0.displayGo_)
end

function var_0_0.BindRedPoint(arg_2_0, arg_2_1)
	return
end

return var_0_0
