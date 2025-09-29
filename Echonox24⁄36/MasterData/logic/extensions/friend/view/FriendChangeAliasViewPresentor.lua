-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/view/FriendChangeAliasViewPresentor.lua

module("logic.extensions.friend.view.FriendChangeAliasViewPresentor", package.seeall)

local M = class("FriendChangeAliasViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Playerinfo_rename_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, FriendChangeAliasView.New())

	return views
end

return M
