-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AoQiAttackForceHeroFailViewPresentor.lua

module("logic.extensions.aoqiattackforce.view.AoQiAttackForceHeroFailViewPresentor", package.seeall)

local AoQiAttackForceHeroFailViewPresentor = class("AoQiAttackForceHeroFailViewPresentor", ViewPresentor)

function AoQiAttackForceHeroFailViewPresentor:ctor()
	AoQiAttackForceHeroFailViewPresentor.super.ctor(self)
end

function AoQiAttackForceHeroFailViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AoQiAttackForceHeroFailViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqiattackforce/aoqiattackforceherofailview.prefab"
	}
end

function AoQiAttackForceHeroFailViewPresentor:buildViews()
	return {
		AoQiAttackForceHeroFailView.New()
	}
end

return AoQiAttackForceHeroFailViewPresentor
