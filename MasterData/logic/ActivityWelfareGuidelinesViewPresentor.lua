-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/welfareguidelines/ActivityWelfareGuidelinesViewPresentor.lua

module("logic.extensions.operationsummary.view.welfareguidelines.ActivityWelfareGuidelinesViewPresentor", package.seeall)

local ActivityWelfareGuidelinesViewPresentor = class("ActivityWelfareGuidelinesViewPresentor", ViewPresentor)

function ActivityWelfareGuidelinesViewPresentor:ctor()
	ActivityWelfareGuidelinesViewPresentor.super.ctor(self)
end

function ActivityWelfareGuidelinesViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityWelfareGuidelinesViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/activitywelfareguidelinesview.prefab"
	}
end

function ActivityWelfareGuidelinesViewPresentor:buildViews()
	return {
		ActivityWelfareGuidelinesView.New()
	}
end

return ActivityWelfareGuidelinesViewPresentor
