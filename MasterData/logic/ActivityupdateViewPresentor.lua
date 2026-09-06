-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/ActivityupdateViewPresentor.lua

module("logic.extensions.bonus.view.xiaonuobirthday.ActivityupdateViewPresentor", package.seeall)

local ActivityupdateViewPresentor = class("ActivityupdateViewPresentor", ViewPresentor)

function ActivityupdateViewPresentor:ctor()
	ActivityupdateViewPresentor.super.ctor(self)
end

function ActivityupdateViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityupdateViewPresentor:dependWhatResources()
	return {
		"ui/views/bonus/xiaonuobirthday/activityupdateview.prefab"
	}
end

function ActivityupdateViewPresentor:buildViews()
	return {
		ActivityupdateView.New()
	}
end

return ActivityupdateViewPresentor
