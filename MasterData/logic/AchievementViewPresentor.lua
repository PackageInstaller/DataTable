-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/achievement/view/AchievementViewPresentor.lua

module("logic.extensions.achievement.view.AchievementViewPresentor", package.seeall)

local AchievementViewPresentor = class("AchievementViewPresentor", ViewPresentor)

function AchievementViewPresentor:ctor()
	AchievementViewPresentor.super.ctor(self)
end

function AchievementViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function AchievementViewPresentor:dependWhatResources()
	return {
		"ui/views/achievement/achievementview.prefab"
	}
end

function AchievementViewPresentor:buildViews()
	return {
		AchievementView.New()
	}
end

return AchievementViewPresentor
