-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivityTimeProgressViewPresentor.lua

module("logic.extensions.operationsummary.view.ActivityTimeProgressViewPresentor", package.seeall)

local ActivityTimeProgressViewPresentor = class("ActivityTimeProgressViewPresentor", ViewPresentor)

function ActivityTimeProgressViewPresentor:ctor()
	ActivityTimeProgressViewPresentor.super.ctor(self)
end

function ActivityTimeProgressViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityTimeProgressViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/activitytimeprogressview.prefab"
	}
end

function ActivityTimeProgressViewPresentor:buildViews()
	return {
		ActivityTimeProgressView.New()
	}
end

return ActivityTimeProgressViewPresentor
