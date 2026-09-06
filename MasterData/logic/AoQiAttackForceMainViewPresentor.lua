-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceMainViewPresentor.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceMainViewPresentor", package.seeall)

local AoQiAttackForceMainViewPresentor = class("AoQiAttackForceMainViewPresentor", ViewPresentor)

function AoQiAttackForceMainViewPresentor:ctor()
	AoQiAttackForceMainViewPresentor.super.ctor(self)
end

function AoQiAttackForceMainViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoQiAttackForceMainViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqiattackforce/aoqiattackforcemainview.prefab"
	}
end

function AoQiAttackForceMainViewPresentor:buildViews()
	return {
		AoQiAttackForceMainView.New()
	}
end

return AoQiAttackForceMainViewPresentor
