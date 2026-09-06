-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/smallsummary/ActivitySmallSummaryTenViewPresentor.lua

module("logic.extensions.operationsummary.view.smallsummary.ActivitySmallSummaryTenViewPresentor", package.seeall)

local ActivitySmallSummaryTenViewPresentor = class("ActivitySmallSummaryTenViewPresentor", ViewPresentor)

function ActivitySmallSummaryTenViewPresentor:ctor()
	ActivitySmallSummaryTenViewPresentor.super.ctor(self)
end

function ActivitySmallSummaryTenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivitySmallSummaryTenViewPresentor:dependWhatResources()
	local key = self.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))
	end

	local viewprefab = data.viewPrefab

	return {
		"ui/views/operationsummary/" .. viewprefab .. ".prefab"
	}
end

function ActivitySmallSummaryTenViewPresentor:buildViews()
	return {
		ActivitySmallSummaryTenView.New()
	}
end

return ActivitySmallSummaryTenViewPresentor
