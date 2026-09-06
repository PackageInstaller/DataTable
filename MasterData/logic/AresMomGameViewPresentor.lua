-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aresmom/view/AresMomGameViewPresentor.lua

module("logic.extensions.aresmom.view.AresMomGameViewPresentor", package.seeall)

local AresMomGameViewPresentor = class("AresMomGameViewPresentor", ViewPresentor)

function AresMomGameViewPresentor:ctor()
	AresMomGameViewPresentor.super.ctor(self)
end

function AresMomGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AresMomGameViewPresentor:dependWhatResources()
	return {
		"ui/views/aresmom/aresmomgameview.prefab"
	}
end

function AresMomGameViewPresentor:buildViews()
	return {
		AresMomGameView.New()
	}
end

return AresMomGameViewPresentor
