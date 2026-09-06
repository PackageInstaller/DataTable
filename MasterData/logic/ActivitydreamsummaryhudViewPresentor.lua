-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/view/ActivitydreamsummaryhudViewPresentor.lua

module("logic.extensions.operationsummary.view.ActivitydreamsummaryhudViewPresentor", package.seeall)

local ActivitydreamsummaryhudViewPresentor = class("ActivitydreamsummaryhudViewPresentor", ActivitydreamsummaryViewPresentor)

function ActivitydreamsummaryhudViewPresentor:buildViews()
	return {
		ActivitydreamsummaryhudView.New()
	}
end

return ActivitydreamsummaryhudViewPresentor
