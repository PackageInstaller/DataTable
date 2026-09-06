-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroMainViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroMainViewPresentor", package.seeall)

local AoqiHeroMainViewPresentor = class("AoqiHeroMainViewPresentor", ViewPresentor)

function AoqiHeroMainViewPresentor:ctor()
	AoqiHeroMainViewPresentor.super.ctor(self)
end

function AoqiHeroMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroMainViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheromainview.prefab"
	}
end

function AoqiHeroMainViewPresentor:buildViews()
	return {
		AoqiHeroMainView.New()
	}
end

return AoqiHeroMainViewPresentor
