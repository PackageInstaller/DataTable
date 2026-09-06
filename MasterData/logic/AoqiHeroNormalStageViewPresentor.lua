-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroNormalStageViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroNormalStageViewPresentor", package.seeall)

local AoqiHeroNormalStageViewPresentor = class("AoqiHeroNormalStageViewPresentor", ViewPresentor)

function AoqiHeroNormalStageViewPresentor:ctor()
	AoqiHeroNormalStageViewPresentor.super.ctor(self)
end

function AoqiHeroNormalStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroNormalStageViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheronormalstageview.prefab"
	}
end

function AoqiHeroNormalStageViewPresentor:buildViews()
	return {
		AoqiHeroNormalStageView.New()
	}
end

return AoqiHeroNormalStageViewPresentor
