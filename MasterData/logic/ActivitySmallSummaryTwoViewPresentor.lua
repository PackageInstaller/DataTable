-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/smallsummary/ActivitySmallSummaryTwoViewPresentor.lua

module("logic.extensions.operationsummary.view.smallsummary.ActivitySmallSummaryTwoViewPresentor", package.seeall)

local ActivitySmallSummaryTwoViewPresentor = class("ActivitySmallSummaryTwoViewPresentor", ActivitySmallSummaryOneViewPresentor)

function ActivitySmallSummaryTwoViewPresentor:buildViews()
	return {
		ActivitySmallSummaryTwoView.New()
	}
end

return ActivitySmallSummaryTwoViewPresentor
