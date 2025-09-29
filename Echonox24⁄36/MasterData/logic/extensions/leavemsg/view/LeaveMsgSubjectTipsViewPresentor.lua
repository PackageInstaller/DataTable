-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/view/LeaveMsgSubjectTipsViewPresentor.lua

module("logic.extensions.leavemsg.view.LeaveMsgSubjectTipsViewPresentor", package.seeall)

local M = class("LeaveMsgSubjectTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.LeaveMsg_leave_message_phrases_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LeaveMsgSubjectTipsView.New())

	return views
end

return M
