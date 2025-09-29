-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/CommonEquipFilterViewPresentor.lua

module("logic.extensions.charactersystem.view.equip.CommonEquipFilterViewPresentor", package.seeall)

local M = class("CommonEquipFilterViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Backpack_backpack_filter_tips_2
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, CommonEquipFilterView.New())

	return views
end

return M
