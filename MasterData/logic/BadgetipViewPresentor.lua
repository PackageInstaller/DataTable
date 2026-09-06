-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/badge/view/BadgetipViewPresentor.lua

module("logic.extensions.badge.view.BadgetipViewPresentor", package.seeall)

local BadgetipViewPresentor = class("BadgetipViewPresentor", ViewPresentor)

function BadgetipViewPresentor:ctor()
	BadgetipViewPresentor.super.ctor(self)
end

function BadgetipViewPresentor:attachToWhichRoot()
	return ViewRootType.TopMost
end

function BadgetipViewPresentor:dependWhatResources()
	return {
		"ui/views/badge/badgetipview.prefab"
	}
end

function BadgetipViewPresentor:buildViews()
	return {
		BadgeTipView.New()
	}
end

return BadgetipViewPresentor
