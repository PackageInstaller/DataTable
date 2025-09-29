-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/PlayerInfoLeaveMsgViewPresentor.lua

module("logic.extensions.playerinfo.view.PlayerInfoLeaveMsgViewPresentor", package.seeall)

local M = class("PlayerInfoLeaveMsgViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.LeaveMsg_leave_message_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, PlayerInfoLeaveMsgView.New())

	local titleView = TitleView.New():blockOrgBtn(true, false, false)

	titleView:setHideHomeBtn(true)
	table.insert(views, titleView)

	return views
end

return M
