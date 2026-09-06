-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/smallsummary/ActivitySmallSummaryFourView.lua

module("logic.extensions.operationsummary.view.smallsummary.ActivitySmallSummaryFourView", package.seeall)

local ActivitySmallSummaryFourView = class("ActivitySmallSummaryFourView", ActivityGrandSummaryView)

function ActivitySmallSummaryFourView:_getSumActivityId()
	local key = self._viewPresentor.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))

		return
	end

	return data.activityId
end

return ActivitySmallSummaryFourView
