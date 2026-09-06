-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceSelectBuffViewPresentor.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceSelectBuffViewPresentor", package.seeall)

local AoQiAttackForceSelectBuffViewPresentor = class("AoQiAttackForceSelectBuffViewPresentor", ViewPresentor)

function AoQiAttackForceSelectBuffViewPresentor:ctor()
	AoQiAttackForceSelectBuffViewPresentor.super.ctor(self)
end

function AoQiAttackForceSelectBuffViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoQiAttackForceSelectBuffViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqiattackforce/aoqiattackforceselectbuffview.prefab"
	}
end

function AoQiAttackForceSelectBuffViewPresentor:buildViews()
	return {
		AoQiAttackForceSelectBuffView.New()
	}
end

return AoQiAttackForceSelectBuffViewPresentor
