-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/view/ActivitysignViewPresentor.lua

module("logic.extensions.operationsignin.view.ActivitysignViewPresentor", package.seeall)

local ActivitysignViewPresentor = class("ActivitysignViewPresentor", ViewPresentor)

function ActivitysignViewPresentor:ctor()
	ActivitysignViewPresentor.super.ctor(self)
end

function ActivitysignViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivitysignViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsignin/activitysignview.prefab"
	}
end

function ActivitysignViewPresentor:buildViews()
	return {
		ActivitysignView.New()
	}
end

return ActivitysignViewPresentor
