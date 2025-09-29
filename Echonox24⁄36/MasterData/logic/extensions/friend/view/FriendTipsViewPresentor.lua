-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendTipsViewPresentor.lua

module("logic.extensions.friend.view.FriendTipsViewPresentor", package.seeall)

local M = class("FriendTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Friend_friend_handle_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsLimitInScreenComp.New())
	table.insert(views, FriendTipsView.New())
	table.insert(views, ToolTipsMaskComp.New())

	return views
end

return M
