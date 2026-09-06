-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/achievement/view/AchievementrightViewPresentor.lua

module("logic.extensions.achievement.view.AchievementrightViewPresentor", package.seeall)

local AchievementrightViewPresentor = class("AchievementrightViewPresentor", ViewPresentor)

function AchievementrightViewPresentor:ctor()
	AchievementrightViewPresentor.super.ctor(self)
end

function AchievementrightViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AchievementrightViewPresentor:dependWhatResources()
	return {
		"ui/views/achievement/achievementrightview.prefab"
	}
end

function AchievementrightViewPresentor:buildViews()
	return {
		AchievementrightView.New()
	}
end

function AchievementrightViewPresentor:playEnterAnimation()
	self:_onEnterAnimationDone()
end

return AchievementrightViewPresentor
