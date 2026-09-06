-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/badge/view/BadgeshowselectViewPresentor.lua

module("logic.extensions.badge.view.BadgeshowselectViewPresentor", package.seeall)

local BadgeshowselectViewPresentor = class("BadgeshowselectViewPresentor", ViewPresentor)

function BadgeshowselectViewPresentor:ctor()
	BadgeshowselectViewPresentor.super.ctor(self)
end

function BadgeshowselectViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function BadgeshowselectViewPresentor:dependWhatResources()
	return {
		"ui/views/badge/badgeshowselectview.prefab"
	}
end

function BadgeshowselectViewPresentor:buildViews()
	return {
		BadgeshowselectView.New()
	}
end

return BadgeshowselectViewPresentor
