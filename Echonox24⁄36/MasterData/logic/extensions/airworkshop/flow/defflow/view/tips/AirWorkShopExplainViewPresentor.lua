-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/tips/AirWorkShopExplainViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.tips.AirWorkShopExplainViewPresentor", package.seeall)

local M = class("AirWorkShopExplainViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_def_teach
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopExplainView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
