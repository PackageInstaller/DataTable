-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivityxiuerViewPresentor.lua

module("logic.extensions.operationsummary.view.ActivityxiuerViewPresentor", package.seeall)

local ActivityxiuerViewPresentor = class("ActivityxiuerViewPresentor", ViewPresentor)

function ActivityxiuerViewPresentor:ctor()
	ActivityxiuerViewPresentor.super.ctor(self)
end

function ActivityxiuerViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityxiuerViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/activityxiuerview.prefab"
	}
end

function ActivityxiuerViewPresentor:buildViews()
	return {
		ActivityxiuerView.New()
	}
end

return ActivityxiuerViewPresentor
