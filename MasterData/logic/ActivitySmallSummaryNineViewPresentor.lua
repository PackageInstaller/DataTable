-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/smallsummary/ActivitySmallSummaryNineViewPresentor.lua

module("logic.extensions.operationsummary.view.smallsummary.ActivitySmallSummaryNineViewPresentor", package.seeall)

local ActivitySmallSummaryNineViewPresentor = class("ActivitySmallSummaryNineViewPresentor", ViewPresentor)

function ActivitySmallSummaryNineViewPresentor:ctor()
	ActivitySmallSummaryNineViewPresentor.super.ctor(self)
end

function ActivitySmallSummaryNineViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivitySmallSummaryNineViewPresentor:dependWhatResources()
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

function ActivitySmallSummaryNineViewPresentor:buildViews()
	return {
		ActivitySmallSummaryNineView.New()
	}
end

return ActivitySmallSummaryNineViewPresentor
