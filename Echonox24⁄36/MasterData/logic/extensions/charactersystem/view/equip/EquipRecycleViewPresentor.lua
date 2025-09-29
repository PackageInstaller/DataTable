-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipRecycleViewPresentor.lua

module("logic.extensions.charactersystem.view.equip.EquipRecycleViewPresentor", package.seeall)

local M = class("EquipRecycleViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Equipsystem_new_equip_decompose_view,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, EquipRecycleView.New())
	table.insert(views, TitleView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
