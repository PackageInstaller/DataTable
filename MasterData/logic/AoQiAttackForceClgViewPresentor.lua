-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceClgViewPresentor.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceClgViewPresentor", package.seeall)

local AoQiAttackForceClgViewPresentor = class("AoQiAttackForceClgViewPresentor", ViewPresentor)

function AoQiAttackForceClgViewPresentor:ctor()
	AoQiAttackForceClgViewPresentor.super.ctor(self)
end

function AoQiAttackForceClgViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoQiAttackForceClgViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqiattackforce/aoqiattackforceclgview.prefab"
	}
end

function AoQiAttackForceClgViewPresentor:buildViews()
	return {
		AoQiAttackForceClgView.New()
	}
end

return AoQiAttackForceClgViewPresentor
