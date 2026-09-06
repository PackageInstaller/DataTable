-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/smallsummary/ActivitySmallSummaryThreeViewPresentor.lua

module("logic.extensions.operationsummary.view.smallsummary.ActivitySmallSummaryThreeViewPresentor", package.seeall)

local ActivitySmallSummaryThreeViewPresentor = class("ActivitySmallSummaryThreeViewPresentor", ActivitySmallSummaryOneViewPresentor)

function ActivitySmallSummaryThreeViewPresentor:buildViews()
	return {
		ActivitySmallSummaryThreeView.New()
	}
end

return ActivitySmallSummaryThreeViewPresentor
