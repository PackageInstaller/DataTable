-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoqiAttackForceRankViewPresentor.lua

module("logic.extensions.aoqiattackforce.view.AoqiAttackForceRankViewPresentor", package.seeall)

local AoqiAttackForceRankViewPresentor = class("AoqiAttackForceRankViewPresentor", ViewPresentor)

function AoqiAttackForceRankViewPresentor:ctor()
	AoqiAttackForceRankViewPresentor.super.ctor(self)
end

function AoqiAttackForceRankViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoqiAttackForceRankViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqiattackforce/aoqiattackforcerankview.prefab"
	}
end

function AoqiAttackForceRankViewPresentor:buildViews()
	return {
		AoqiAttackForceRankView.New()
	}
end

return AoqiAttackForceRankViewPresentor
