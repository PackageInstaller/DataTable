-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/smallsummary/ActivitySmallSummarySixViewPresentor.lua

module("logic.extensions.operationsummary.view.smallsummary.ActivitySmallSummarySixViewPresentor", package.seeall)

local ActivitySmallSummarySixViewPresentor = class("ActivitySmallSummarySixViewPresentor", ActivitySmallSummaryOneViewPresentor)

function ActivitySmallSummarySixViewPresentor:buildViews()
	return {
		ActivitySmallSummarySixView.New()
	}
end

return ActivitySmallSummarySixViewPresentor
