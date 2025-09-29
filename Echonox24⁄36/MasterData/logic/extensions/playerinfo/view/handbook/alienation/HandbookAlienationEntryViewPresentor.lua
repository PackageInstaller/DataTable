-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/alienation/HandbookAlienationEntryViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.alienation.HandbookAlienationEntryViewPresentor", package.seeall)

local M = class("HandbookAlienationEntryViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_alienation_entry_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookAlienationEntryView.New())

	return views
end

return M
