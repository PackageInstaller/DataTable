-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqihero/view/AoqiHeroUnlockViewPresentor.lua

module("logic.extensions.aoqihero.view.AoqiHeroUnlockViewPresentor", package.seeall)

local AoqiHeroUnlockViewPresentor = class("AoqiHeroUnlockViewPresentor", ViewPresentor)

function AoqiHeroUnlockViewPresentor:ctor()
	AoqiHeroUnlockViewPresentor.super.ctor(self)
end

function AoqiHeroUnlockViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiHeroUnlockViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqihero/aoqiherounlockview.prefab"
	}
end

function AoqiHeroUnlockViewPresentor:buildViews()
	return {
		AoqiHeroUnlockView.New(),
		PopupCostMatView.New()
	}
end

return AoqiHeroUnlockViewPresentor
