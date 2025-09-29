-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/RedMistEntryViewPresentor.lua

module("logic.extensions.dungeon.view.equipdungeon.RedMistEntryViewPresentor", package.seeall)

local M = class("RedMistEntryViewPresentor", ViewPresentor)
local GuideId = 1005

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Red_mist_entry_view,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RedMistEntryView.New())
	table.insert(views, TitleView.New(GuideId))

	return views
end

return M
