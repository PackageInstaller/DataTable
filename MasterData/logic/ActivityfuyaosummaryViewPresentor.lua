-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivityfuyaosummaryViewPresentor.lua

module("logic.extensions.operationsummary.view.ActivityfuyaosummaryViewPresentor", package.seeall)

local ActivityfuyaosummaryViewPresentor = class("ActivityfuyaosummaryViewPresentor", ViewPresentor)

function ActivityfuyaosummaryViewPresentor:ctor()
	ActivityfuyaosummaryViewPresentor.super.ctor(self)
end

function ActivityfuyaosummaryViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivityfuyaosummaryViewPresentor:dependWhatResources()
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

function ActivityfuyaosummaryViewPresentor:buildViews()
	return {
		ActivityfuyaosummaryView.New()
	}
end

return ActivityfuyaosummaryViewPresentor
