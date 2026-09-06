-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AqafTestGameViewPresentor.lua

module("logic.extensions.aoqiattackforce.view.AqafTestGameViewPresentor", package.seeall)

local AqafTestGameViewPresentor = class("AqafTestGameViewPresentor", ViewPresentor)

function AqafTestGameViewPresentor:ctor()
	AqafTestGameViewPresentor.super.ctor(self)
end

function AqafTestGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AqafTestGameViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqiattackforce/aqaftestgameview.prefab"
	}
end

function AqafTestGameViewPresentor:buildViews()
	return {
		AqafTestGameView.New()
	}
end

return AqafTestGameViewPresentor
