-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/smallsummary/ActivitySmallSummaryFourViewPresentor.lua

module("logic.extensions.operationsummary.view.smallsummary.ActivitySmallSummaryFourViewPresentor", package.seeall)

local ActivitySmallSummaryFourViewPresentor = class("ActivitySmallSummaryFourViewPresentor", ActivitySmallSummaryOneViewPresentor)

function ActivitySmallSummaryFourViewPresentor:buildViews()
	return {
		ActivitySmallSummaryFourView.New()
	}
end

return ActivitySmallSummaryFourViewPresentor
