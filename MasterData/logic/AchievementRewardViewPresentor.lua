-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/achievement/view/AchievementRewardViewPresentor.lua

module("logic.extensions.achievement.view.AchievementRewardViewPresentor", package.seeall)

local AchievementRewardViewPresentor = class("AchievementRewardViewPresentor", ViewPresentor)

function AchievementRewardViewPresentor:ctor()
	AchievementRewardViewPresentor.super.ctor(self)
end

function AchievementRewardViewPresentor:attachToWhichRoot()
	return ViewRootType.Popup
end

function AchievementRewardViewPresentor:dependWhatResources()
	return {
		"ui/views/achievement/achievementrewardview.prefab"
	}
end

function AchievementRewardViewPresentor:buildViews()
	return {
		AchievementRewardView.New()
	}
end

return AchievementRewardViewPresentor
