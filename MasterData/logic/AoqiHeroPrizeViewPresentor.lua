-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroPrizeViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroPrizeViewPresentor", package.seeall)

local AoqiHeroPrizeViewPresentor = class("AoqiHeroPrizeViewPresentor", ViewPresentor)

function AoqiHeroPrizeViewPresentor:ctor()
	AoqiHeroPrizeViewPresentor.super.ctor(self)
end

function AoqiHeroPrizeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroPrizeViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheroprizeview.prefab"
	}
end

function AoqiHeroPrizeViewPresentor:buildViews()
	return {
		AoqiHeroPrizeView.New()
	}
end

return AoqiHeroPrizeViewPresentor
