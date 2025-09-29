-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/view/LeaveMsgVoiceHeroTipsViewPresentor.lua

module("logic.extensions.leavemsg.view.LeaveMsgVoiceHeroTipsViewPresentor", package.seeall)

local M = class("LeaveMsgVoiceHeroTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.LeaveMsg_leave_message_role_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LeaveMsgVoiceHeroTipsView.New())

	return views
end

return M
