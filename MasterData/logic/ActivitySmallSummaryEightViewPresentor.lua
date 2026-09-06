-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/smallsummary/ActivitySmallSummaryEightViewPresentor.lua

module("logic.extensions.operationsummary.view.smallsummary.ActivitySmallSummaryEightViewPresentor", package.seeall)

local ActivitySmallSummaryEightViewPresentor = class("ActivitySmallSummaryEightViewPresentor", ViewPresentor)

function ActivitySmallSummaryEightViewPresentor:ctor()
	ActivitySmallSummaryEightViewPresentor.super.ctor(self)
end

function ActivitySmallSummaryEightViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivitySmallSummaryEightViewPresentor:dependWhatResources()
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

function ActivitySmallSummaryEightViewPresentor:buildViews()
	return {
		ActivitySmallSummaryEightView.New()
	}
end

return ActivitySmallSummaryEightViewPresentor
