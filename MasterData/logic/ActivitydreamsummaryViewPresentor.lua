-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivitydreamsummaryViewPresentor.lua

module("logic.extensions.operationsummary.view.ActivitydreamsummaryViewPresentor", package.seeall)

local ActivitydreamsummaryViewPresentor = class("ActivitydreamsummaryViewPresentor", ViewPresentor)

ActivitydreamsummaryViewPresentor.FlyNuo = "effect/prefabs/ui/20230630/xiaoaoqi_feiji/xiaoaoqifeiji_donghua/xiaoaoqifeiji_donghua-ui_p.prefab"

function ActivitydreamsummaryViewPresentor:ctor()
	ActivitydreamsummaryViewPresentor.super.ctor(self)
end

function ActivitydreamsummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivitydreamsummaryViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/activitydreamsummaryview.prefab",
		ActivitydreamsummaryViewPresentor.FlyNuo
	}
end

function ActivitydreamsummaryViewPresentor:buildViews()
	return {
		ActivitydreamsummaryView.New()
	}
end

return ActivitydreamsummaryViewPresentor
