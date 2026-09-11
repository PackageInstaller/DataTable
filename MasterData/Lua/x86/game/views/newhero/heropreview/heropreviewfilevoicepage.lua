local HeroPreviewFileVoicePage = class("HeroPreviewFileVoicePage", HeroFileVoicePage)

function HeroPreviewFileVoicePage:CameraEnter()
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		3
	}, self.displayGo_)
end

return HeroPreviewFileVoicePage
