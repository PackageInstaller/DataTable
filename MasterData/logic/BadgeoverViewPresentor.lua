-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/badge/view/BadgeoverViewPresentor.lua

module("logic.extensions.badge.view.BadgeoverViewPresentor", package.seeall)

local BadgeoverViewPresentor = class("BadgeoverViewPresentor", ViewPresentor)

function BadgeoverViewPresentor:ctor()
	BadgeoverViewPresentor.super.ctor(self)
end

function BadgeoverViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BadgeoverViewPresentor:dependWhatResources()
	return {
		"ui/views/badge/badgeoverview.prefab"
	}
end

function BadgeoverViewPresentor:buildViews()
	return {
		BadgeoverView.New()
	}
end

return BadgeoverViewPresentor
