-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroEndlessStageViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroEndlessStageViewPresentor", package.seeall)

local AoqiHeroEndlessStageViewPresentor = class("AoqiHeroEndlessStageViewPresentor", ViewPresentor)

function AoqiHeroEndlessStageViewPresentor:ctor()
	AoqiHeroEndlessStageViewPresentor.super.ctor(self)
end

function AoqiHeroEndlessStageViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroEndlessStageViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheroendlessstageview.prefab"
	}
end

function AoqiHeroEndlessStageViewPresentor:buildViews()
	return {
		AoqiHeroEndlessStageView.New()
	}
end

return AoqiHeroEndlessStageViewPresentor
