-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/record/HandbookRecordEntriesViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.record.HandbookRecordEntriesViewPresentor", package.seeall)

local M = class("HandbookRecordEntriesViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_record_entries_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookRecordEntriesView.New())

	return views
end

return M
