-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/ActivityTiliViewPresentor.lua

module("logic.extensions.lottery.view.ActivityTiliViewPresentor", package.seeall)

local ActivityTiliViewPresentor = class("ActivityTiliViewPresentor", ViewPresentor)

function ActivityTiliViewPresentor:ctor()
	ActivityTiliViewPresentor.super.ctor(self)
end

function ActivityTiliViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityTiliViewPresentor:dependWhatResources()
	return {
		"ui/views/lottery/activitytiliview.prefab"
	}
end

function ActivityTiliViewPresentor:buildViews()
	return {
		ActivityTiliView.New()
	}
end

return ActivityTiliViewPresentor
