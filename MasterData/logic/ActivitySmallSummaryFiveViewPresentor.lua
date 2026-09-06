-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/smallsummary/ActivitySmallSummaryFiveViewPresentor.lua

module("logic.extensions.operationsummary.view.smallsummary.ActivitySmallSummaryFiveViewPresentor", package.seeall)

local ActivitySmallSummaryFiveViewPresentor = class("ActivitySmallSummaryFiveViewPresentor", ActivitySmallSummaryOneViewPresentor)

function ActivitySmallSummaryFiveViewPresentor:buildViews()
	return {
		ActivitySmallSummaryFiveView.New()
	}
end

return ActivitySmallSummaryFiveViewPresentor
