-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/setting/AirWorkSelectHeroViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.setting.AirWorkSelectHeroViewPresentor", package.seeall)

local M = class("AirWorkSelectHeroViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_def_select_hero_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkSelectHeroView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
