-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/defset/AirWorkShopTriggerConditionSelectViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.defset.AirWorkShopTriggerConditionSelectViewPresentor", package.seeall)

local M = class("AirWorkShopTriggerConditionSelectViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_def_trigger_condition_select
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopTriggerConditionSelectView.New())

	return views
end

return M
