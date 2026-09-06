-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/smallsummary/ActivitySmallSummarySevenViewPresentor.lua

module("logic.extensions.operationsummary.view.smallsummary.ActivitySmallSummarySevenViewPresentor", package.seeall)

local ActivitySmallSummarySevenViewPresentor = class("ActivitySmallSummarySevenViewPresentor", ViewPresentor)

function ActivitySmallSummarySevenViewPresentor:ctor()
	ActivitySmallSummarySevenViewPresentor.super.ctor(self)
end

function ActivitySmallSummarySevenViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivitySmallSummarySevenViewPresentor:dependWhatResources()
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

function ActivitySmallSummarySevenViewPresentor:buildViews()
	return {
		ActivitySmallSummarySevenView.New()
	}
end

return ActivitySmallSummarySevenViewPresentor
