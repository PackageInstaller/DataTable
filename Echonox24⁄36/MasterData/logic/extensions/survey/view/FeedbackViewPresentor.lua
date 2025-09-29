-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/survey/view/FeedbackViewPresentor.lua

module("logic.extensions.survey.view.FeedbackViewPresentor", package.seeall)

local M = class("FeedbackViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Feedback_feedback_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FeedbackView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
