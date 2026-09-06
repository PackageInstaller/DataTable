-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/aoqiattackforce/view/AiQiAttackForceHeroExitViewPresentor.lua

module("logic.extensions.aoqiattackforce.view.AiQiAttackForceHeroExitViewPresentor", package.seeall)

local AiQiAttackForceHeroExitViewPresentor = class("AiQiAttackForceHeroExitViewPresentor", ViewPresentor)

function AiQiAttackForceHeroExitViewPresentor:ctor()
	AiQiAttackForceHeroExitViewPresentor.super.ctor(self)
end

function AiQiAttackForceHeroExitViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AiQiAttackForceHeroExitViewPresentor:dependWhatResources()
	return {
		"ui/views/aoqiattackforce/aiqiattackforceheroexitview.prefab"
	}
end

function AiQiAttackForceHeroExitViewPresentor:buildViews()
	return {
		AiQiAttackForceHeroExitView.New()
	}
end

return AiQiAttackForceHeroExitViewPresentor
