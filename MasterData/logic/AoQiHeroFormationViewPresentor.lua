-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoQiHeroFormationViewPresentor.lua

module("logic.extensions.aoqihero.view.AoQiHeroFormationViewPresentor", package.seeall)

local AoQiHeroFormationViewPresentor = class("AoQiHeroFormationViewPresentor", ViewPresentor)

function AoQiHeroFormationViewPresentor:ctor()
	AoQiHeroFormationViewPresentor.super.ctor(self)
end

function AoQiHeroFormationViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoQiHeroFormationViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheroformationview.prefab"
	}
end

function AoQiHeroFormationViewPresentor:buildViews()
	return {
		AoQiHeroFormationView.New()
	}
end

return AoQiHeroFormationViewPresentor
