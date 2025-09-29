-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/defset/AirWorkShopMessageSetViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.defset.AirWorkShopMessageSetViewPresentor", package.seeall)

local M = class("AirWorkShopMessageSetViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_def_set_message
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopMessageSetView.New())
	table.insert(views, TitleView.New():blockOrgBtn(true, true, true):setHideHomeBtn(true))

	return views
end

return M
