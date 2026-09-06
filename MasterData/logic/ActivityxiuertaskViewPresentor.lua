-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivityxiuertaskViewPresentor.lua

module("logic.extensions.operationsummary.view.ActivityxiuertaskViewPresentor", package.seeall)

local ActivityxiuertaskViewPresentor = class("ActivityxiuertaskViewPresentor", ViewPresentor)

function ActivityxiuertaskViewPresentor:ctor()
	ActivityxiuertaskViewPresentor.super.ctor(self)
end

function ActivityxiuertaskViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityxiuertaskViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/activityxiuertaskview.prefab"
	}
end

function ActivityxiuertaskViewPresentor:buildViews()
	return {
		ActivityDarkDragontaskView.New()
	}
end

return ActivityxiuertaskViewPresentor
