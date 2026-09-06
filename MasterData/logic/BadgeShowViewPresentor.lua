-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/badge/view/BadgeShowViewPresentor.lua

module("logic.extensions.badge.view.BadgeShowViewPresentor", package.seeall)

local BadgeShowViewPresentor = class("BadgeShowViewPresentor", ViewPresentor)

function BadgeShowViewPresentor:ctor()
	BadgeShowViewPresentor.super.ctor(self)
end

function BadgeShowViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BadgeShowViewPresentor:dependWhatResources()
	return {
		"ui/views/badge/badgeshowview.prefab"
	}
end

function BadgeShowViewPresentor:buildViews()
	return {
		BadgeShowView.New()
	}
end

return BadgeShowViewPresentor
