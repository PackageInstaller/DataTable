-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivitysmalljumpsummarythreeViewPresentor.lua

module("logic.extensions.operationsummary.view.ActivitysmalljumpsummarythreeViewPresentor", package.seeall)

local ActivitysmalljumpsummarythreeViewPresentor = class("ActivitysmalljumpsummarythreeViewPresentor", ViewPresentor)

function ActivitysmalljumpsummarythreeViewPresentor:ctor()
	ActivitysmalljumpsummarythreeViewPresentor.super.ctor(self)
end

function ActivitysmalljumpsummarythreeViewPresentor:attachToWhichRoot()
	return ViewRootType.FullScreen
end

function ActivitysmalljumpsummarythreeViewPresentor:dependWhatResources()
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

function ActivitysmalljumpsummarythreeViewPresentor:buildViews()
	return {
		ActivitysmalljumpsummarythreeView.New()
	}
end

return ActivitysmalljumpsummarythreeViewPresentor
