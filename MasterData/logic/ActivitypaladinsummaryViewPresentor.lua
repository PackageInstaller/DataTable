-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/paladin/ActivitypaladinsummaryViewPresentor.lua

module("logic.extensions.operationsummary.view.paladin.ActivitypaladinsummaryViewPresentor", package.seeall)

local ActivitypaladinsummaryViewPresentor = class("ActivitypaladinsummaryViewPresentor", ViewPresentor)

function ActivitypaladinsummaryViewPresentor:ctor()
	ActivitypaladinsummaryViewPresentor.super.ctor(self)
end

function ActivitypaladinsummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivitypaladinsummaryViewPresentor:dependWhatResources()
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

function ActivitypaladinsummaryViewPresentor:buildViews()
	return {
		ActivitypaladinsummaryView.New()
	}
end

return ActivitypaladinsummaryViewPresentor
