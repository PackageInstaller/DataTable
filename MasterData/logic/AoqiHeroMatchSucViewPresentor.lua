-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroMatchSucViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroMatchSucViewPresentor", package.seeall)

local AoqiHeroMatchSucViewPresentor = class("AoqiHeroMatchSucViewPresentor", ViewPresentor)

function AoqiHeroMatchSucViewPresentor:ctor()
	AoqiHeroMatchSucViewPresentor.super.ctor(self)
end

function AoqiHeroMatchSucViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroMatchSucViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheromatchsucview.prefab"
	}
end

function AoqiHeroMatchSucViewPresentor:buildViews()
	return {
		AoqiHeroMatchSucView.New()
	}
end

return AoqiHeroMatchSucViewPresentor
