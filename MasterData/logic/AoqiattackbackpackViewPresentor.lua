-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoqiattackbackpackViewPresentor.lua

module("logic.extensions.aoqiattackforce.view.AoqiattackbackpackViewPresentor", package.seeall)

local AoqiattackbackpackViewPresentor = class("AoqiattackbackpackViewPresentor", ViewPresentor)

function AoqiattackbackpackViewPresentor:ctor()
	AoqiattackbackpackViewPresentor.super.ctor(self)
end

function AoqiattackbackpackViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiattackbackpackViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqiattackforce/aoqiattackbackpackview.prefab"
	}
end

function AoqiattackbackpackViewPresentor:buildViews()
	return {
		AoqiattackbackpackView.New()
	}
end

return AoqiattackbackpackViewPresentor
