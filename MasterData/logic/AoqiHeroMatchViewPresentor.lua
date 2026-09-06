-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroMatchViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroMatchViewPresentor", package.seeall)

local AoqiHeroMatchViewPresentor = class("AoqiHeroMatchViewPresentor", ViewPresentor)

function AoqiHeroMatchViewPresentor:ctor()
	AoqiHeroMatchViewPresentor.super.ctor(self)
end

function AoqiHeroMatchViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AoqiHeroMatchViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheromatchview.prefab"
	}
end

function AoqiHeroMatchViewPresentor:buildViews()
	return {
		AoqiHeroMatchView.New()
	}
end

return AoqiHeroMatchViewPresentor
