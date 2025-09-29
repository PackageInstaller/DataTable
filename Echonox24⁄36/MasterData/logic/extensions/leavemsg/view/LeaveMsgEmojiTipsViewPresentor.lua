-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/leavemsg/view/LeaveMsgEmojiTipsViewPresentor.lua

module("logic.extensions.leavemsg.view.LeaveMsgEmojiTipsViewPresentor", package.seeall)

local M = class("LeaveMsgEmojiTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.LeaveMsg_leave_message_emoji_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, LeaveMsgEmojiTipsView.New())

	return views
end

return M
