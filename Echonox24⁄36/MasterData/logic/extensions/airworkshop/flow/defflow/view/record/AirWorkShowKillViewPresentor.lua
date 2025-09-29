-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/record/AirWorkShowKillViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.record.AirWorkShowKillViewPresentor", package.seeall)

local M = class("AirWorkShowKillViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_def_show_kill_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShowKillView.New())

	return views
end

return M
