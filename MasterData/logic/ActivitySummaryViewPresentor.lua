-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivitySummaryViewPresentor.lua

module("logic.extensions.operationsummary.view.ActivitySummaryViewPresentor", package.seeall)

local ActivitySummaryViewPresentor = class("ActivitySummaryViewPresentor", ViewPresentor)

function ActivitySummaryViewPresentor:ctor()
	ActivitySummaryViewPresentor.super.ctor(self)
end

function ActivitySummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivitySummaryViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/activitysummaryview.prefab"
	}
end

function ActivitySummaryViewPresentor:buildViews()
	return {
		ActivitySummaryView.New()
	}
end

return ActivitySummaryViewPresentor
