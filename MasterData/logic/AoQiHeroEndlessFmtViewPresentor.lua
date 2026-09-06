-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoQiHeroEndlessFmtViewPresentor.lua

module("logic.extensions.aoqihero.view.AoQiHeroEndlessFmtViewPresentor", package.seeall)

local AoQiHeroEndlessFmtViewPresentor = class("AoQiHeroEndlessFmtViewPresentor", ViewPresentor)

function AoQiHeroEndlessFmtViewPresentor:ctor()
	AoQiHeroEndlessFmtViewPresentor.super.ctor(self)
end

function AoQiHeroEndlessFmtViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoQiHeroEndlessFmtViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiheroformationview.prefab"
	}
end

function AoQiHeroEndlessFmtViewPresentor:buildViews()
	return {
		AoQiHeroEndlessFmtView.New()
	}
end

return AoQiHeroEndlessFmtViewPresentor
