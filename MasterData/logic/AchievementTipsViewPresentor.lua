-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/achievement/view/AchievementTipsViewPresentor.lua

module("logic.extensions.achievement.view.AchievementTipsViewPresentor", package.seeall)

local AchievementTipsViewPresentor = class("AchievementTipsViewPresentor", ViewPresentor)

function AchievementTipsViewPresentor:ctor()
	AchievementTipsViewPresentor.super.ctor(self)
end

function AchievementTipsViewPresentor:attachToWhichRoot()
	return ViewRootType.Notify
end

function AchievementTipsViewPresentor:dependWhatResources()
	return {
		"ui/views/achievement/achievementtipsview.prefab"
	}
end

function AchievementTipsViewPresentor:buildViews()
	return {
		AchievementTipsView.New()
	}
end

return AchievementTipsViewPresentor
