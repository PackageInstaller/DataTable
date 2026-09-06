-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/aruisi/AruisiMainViewPresentor.lua

module("logic.extensions.timelimitedchallenge.view.aruisi.AruisiMainViewPresentor", package.seeall)

local AruisiMainViewPresentor = class("AruisiMainViewPresentor", ViewPresentor)

function AruisiMainViewPresentor:ctor()
	AruisiMainViewPresentor.super.ctor(self)
end

function AruisiMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AruisiMainViewPresentor:dependWhatResources()
	return {
		"ui/views/timelimitedchallenge/aruisimainview.prefab"
	}
end

function AruisiMainViewPresentor:buildViews()
	return {
		AruisiMainView.New()
	}
end

return AruisiMainViewPresentor
