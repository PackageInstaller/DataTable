-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoQiHeroEndlessBtlViewPresentor.lua

module("logic.extensions.aoqihero.view.AoQiHeroEndlessBtlViewPresentor", package.seeall)

local AoQiHeroEndlessBtlViewPresentor = class("AoQiHeroEndlessBtlViewPresentor", ViewPresentor)

function AoQiHeroEndlessBtlViewPresentor:ctor()
	AoQiHeroEndlessBtlViewPresentor.super.ctor(self)
end

function AoQiHeroEndlessBtlViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoQiHeroEndlessBtlViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheroendlessbtlview.prefab"
	}
end

function AoQiHeroEndlessBtlViewPresentor:buildViews()
	return {
		AoQiHeroEndlessBtlView.New()
	}
end

return AoQiHeroEndlessBtlViewPresentor
