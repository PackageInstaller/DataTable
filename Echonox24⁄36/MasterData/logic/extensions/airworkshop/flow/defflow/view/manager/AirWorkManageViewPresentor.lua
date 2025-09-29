-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/manager/AirWorkManageViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.manager.AirWorkManageViewPresentor", package.seeall)

local M = class("AirWorkManageViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_def_manager_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkManagerView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
