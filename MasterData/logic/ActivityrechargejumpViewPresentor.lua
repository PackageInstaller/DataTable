-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivityrechargejumpViewPresentor.lua

module("logic.extensions.operationsummary.view.ActivityrechargejumpViewPresentor", package.seeall)

local ActivityrechargejumpViewPresentor = class("ActivityrechargejumpViewPresentor", ViewPresentor)

function ActivityrechargejumpViewPresentor:ctor()
	ActivityrechargejumpViewPresentor.super.ctor(self)
end

function ActivityrechargejumpViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityrechargejumpViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/activityrechargejumpview.prefab"
	}
end

function ActivityrechargejumpViewPresentor:buildViews()
	return {
		ActivityrechargejumpView.New()
	}
end

return ActivityrechargejumpViewPresentor
