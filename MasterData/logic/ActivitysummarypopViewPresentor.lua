-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivitysummarypopViewPresentor.lua

module("logic.extensions.operationsummary.view.ActivitysummarypopViewPresentor", package.seeall)

local ActivitysummarypopViewPresentor = class("ActivitysummarypopViewPresentor", ViewPresentor)

function ActivitysummarypopViewPresentor:ctor()
	ActivitysummarypopViewPresentor.super.ctor(self)
end

function ActivitysummarypopViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivitysummarypopViewPresentor:dependWhatResources()
	return {
		"ui/views/operationsummary/activitysummarypopview.prefab"
	}
end

function ActivitysummarypopViewPresentor:buildViews()
	return {
		ActivitysummarypopView.New()
	}
end

return ActivitysummarypopViewPresentor
