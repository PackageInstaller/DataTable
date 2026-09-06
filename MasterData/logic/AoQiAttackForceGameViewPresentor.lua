-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceGameViewPresentor.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceGameViewPresentor", package.seeall)

local AoQiAttackForceGameViewPresentor = class("AoQiAttackForceGameViewPresentor", ViewPresentor)

function AoQiAttackForceGameViewPresentor:ctor()
	AoQiAttackForceGameViewPresentor.super.ctor(self)
end

function AoQiAttackForceGameViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoQiAttackForceGameViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqiattackforce/aoqiattackforcegameview.prefab"
	}
end

function AoQiAttackForceGameViewPresentor:buildViews()
	return {
		AoQiAttackForceGameView.New()
	}
end

return AoQiAttackForceGameViewPresentor
