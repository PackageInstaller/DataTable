-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/smallsummary/ActivitySmallSummaryFiveView.lua

module("logic.extensions.operationsummary.view.smallsummary.ActivitySmallSummaryFiveView", package.seeall)

local ActivitySmallSummaryFiveView = class("ActivitySmallSummaryFiveView", ActivityGrandSummaryView)

function ActivitySmallSummaryFiveView:onExit()
	ActivitySmallSummaryFiveView.super.onExit(self)

	if self._tween then
		self._tween:Kill()

		self._tween = nil
	end
end

function ActivitySmallSummaryFiveView:_getSumActivityId()
	local key = self._viewPresentor.viewName
	local data = OperationSummaryConfig.instance:getSummaryStartUpData(key)

	if data == nil then
		printError(string.format("key错误,无法读到正确配置.( key = %s )", key))

		return
	end

	return data.activityId
end

return ActivitySmallSummaryFiveView
