-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/smallsummary/ActivitySmallSummaryEightView.lua

module("logic.extensions.operationsummary.view.smallsummary.ActivitySmallSummaryEightView", package.seeall)

local ActivitySmallSummaryEightView = class("ActivitySmallSummaryEightView", ActivityGrandSummaryView)

function ActivitySmallSummaryEightView:_getSumActivityId()
	local key = self._viewPresentor.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))

		return
	end

	return data.activityId
end

return ActivitySmallSummaryEightView
