-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/free/AirWorkShopFreeLevelSelectViewPresentor.lua

module("logic.extensions.airworkshop.view.free.AirWorkShopFreeLevelSelectViewPresentor", package.seeall)

local M = class("AirWorkShopFreeLevelSelectViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_free_mode_level_select_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopFreeLevelSelectView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
