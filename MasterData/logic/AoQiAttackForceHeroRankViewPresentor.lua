-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceHeroRankViewPresentor.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceHeroRankViewPresentor", package.seeall)

local AoQiAttackForceHeroRankViewPresentor = class("AoQiAttackForceHeroRankViewPresentor", ViewPresentor)

function AoQiAttackForceHeroRankViewPresentor:ctor()
	AoQiAttackForceHeroRankViewPresentor.super.ctor(self)
end

function AoQiAttackForceHeroRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoQiAttackForceHeroRankViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqiattackforce/aoqiattackforceherorankview.prefab"
	}
end

function AoQiAttackForceHeroRankViewPresentor:buildViews()
	return {
		AoQiAttackForceHeroRankView.New()
	}
end

return AoQiAttackForceHeroRankViewPresentor
