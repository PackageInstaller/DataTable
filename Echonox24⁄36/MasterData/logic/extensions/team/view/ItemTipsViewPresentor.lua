-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/team/view/ItemTipsViewPresentor.lua

module("logic.extensions.team.view.ItemTipsViewPresentor", package.seeall)

local M = class("ItemTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Team_item_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ItemTipsView.New())

	return views
end

function M:onClickOutside()
	ViewMgr.instance:close(ViewName.ItemTipsViewPresentor)
end

return M
