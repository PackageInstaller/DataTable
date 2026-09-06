-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/grandsummary/ActivityGrandSummaryTaskViewPresentor.lua

module("logic.extensions.operationsummary.view.grandsummary.ActivityGrandSummaryTaskViewPresentor", package.seeall)

local ActivityGrandSummaryTaskViewPresentor = class("ActivityGrandSummaryTaskViewPresentor", ViewPresentor)

function ActivityGrandSummaryTaskViewPresentor:ctor()
	ActivityGrandSummaryTaskViewPresentor.super.ctor(self)
end

function ActivityGrandSummaryTaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityGrandSummaryTaskViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/activityxiuertaskview.prefab"
	}
end

function ActivityGrandSummaryTaskViewPresentor:buildViews()
	return {
		ActivityGrandSummaryTaskView.New()
	}
end

return ActivityGrandSummaryTaskViewPresentor
