-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/free/AirWorkshopFreeModeViewPresentor.lua

module("logic.extensions.airworkshop.view.free.AirWorkshopFreeModeViewPresentor", package.seeall)

local M = class("AirWorkshopFreeModeViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_free_mode_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkshopFreeModeView.New())

	local titleView = TitleView.New()

	titleView:setTitle(lang("tip_air_entry_free_mode"))
	table.insert(views, titleView)

	return views
end

return M
