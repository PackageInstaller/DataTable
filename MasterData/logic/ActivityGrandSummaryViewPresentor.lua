-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/grandsummary/ActivityGrandSummaryViewPresentor.lua

module("logic.extensions.operationsummary.view.grandsummary.ActivityGrandSummaryViewPresentor", package.seeall)

local ActivityGrandSummaryViewPresentor = class("ActivityGrandSummaryViewPresentor", ViewPresentor)

function ActivityGrandSummaryViewPresentor:ctor()
	ActivityGrandSummaryViewPresentor.super.ctor(self)
end

function ActivityGrandSummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityGrandSummaryViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/activitysmalljumpsummaryview.prefab"
	}
end

function ActivityGrandSummaryViewPresentor:buildViews()
	return {
		ActivityGrandSummaryView.New()
	}
end

return ActivityGrandSummaryViewPresentor
