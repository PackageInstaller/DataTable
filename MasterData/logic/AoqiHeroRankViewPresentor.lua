-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroRankViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroRankViewPresentor", package.seeall)

local AoqiHeroRankViewPresentor = class("AoqiHeroRankViewPresentor", ViewPresentor)

function AoqiHeroRankViewPresentor:ctor()
	AoqiHeroRankViewPresentor.super.ctor(self)
end

function AoqiHeroRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroRankViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiherorankview.prefab"
	}
end

function AoqiHeroRankViewPresentor:buildViews()
	return {
		AoqiHeroRankView.New()
	}
end

return AoqiHeroRankViewPresentor
