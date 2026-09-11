local HeroPreviewFileArchivePage = class("HeroPreviewFileArchivePage", HeroFileArchivePage)

function HeroPreviewFileArchivePage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	}, self.displayGo_)
end

function HeroPreviewFileArchivePage:BindRedPoint(arg_2_1)
	return
end

return HeroPreviewFileArchivePage
