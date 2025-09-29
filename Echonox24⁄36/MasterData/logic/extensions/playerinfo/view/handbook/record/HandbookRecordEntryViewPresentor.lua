-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/record/HandbookRecordEntryViewPresentor.lua

module("logic.extensions.playerinfo.view.handbook.record.HandbookRecordEntryViewPresentor", package.seeall)

local M = class("HandbookRecordEntryViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Handbook_handbook_record_entry_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HandbookRecordEntryView.New())

	return views
end

return M
