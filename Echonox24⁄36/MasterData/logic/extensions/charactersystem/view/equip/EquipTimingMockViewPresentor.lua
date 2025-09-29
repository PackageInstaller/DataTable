-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipTimingMockViewPresentor.lua

module("logic.extensions.charactersystem.view.equip.EquipTimingMockViewPresentor", package.seeall)

local M = class("EquipTimingMockViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Equipsystem_timing_or_reset_show_view_test
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EquipTimingMockView.New())

	return views
end

return M
