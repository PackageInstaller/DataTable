-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/forum/ForumViewPresentor.lua

module("logic.extensions.controlaction.view.forum.ForumViewPresentor", package.seeall)

local M = class("ForumViewPresentor", ViewPresentor)

M.Url_View = ResName.Regulatory_forum_panel

function M:dependWhatResources()
	return {
		M.Url_View
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ForumView.New())

	return views
end

return M
