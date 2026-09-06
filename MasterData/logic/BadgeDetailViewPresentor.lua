-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/badge/view/BadgeDetailViewPresentor.lua

module("logic.extensions.badge.view.BadgeDetailViewPresentor", package.seeall)

local BadgeDetailViewPresentor = class("BadgeDetailViewPresentor", ViewPresentor)

function BadgeDetailViewPresentor:ctor()
	BadgeDetailViewPresentor.super.ctor(self)
end

function BadgeDetailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BadgeDetailViewPresentor:dependWhatResources()
	return {
		"ui/views/badge/badgedetailview.prefab"
	}
end

function BadgeDetailViewPresentor:buildViews()
	return {
		BadgeDetailView.New()
	}
end

return BadgeDetailViewPresentor
