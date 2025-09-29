-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/plot/HandbookPlotEntryViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.plot.HandbookPlotEntryViewPresentor", package.seeall)

local M = class("HandbookPlotEntryViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_memory_entry_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookPlotEntryView.New())

	return views
end

return M
