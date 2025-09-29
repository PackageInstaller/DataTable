-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/setting/AirWorkSettingViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.setting.AirWorkSettingViewPresentor", package.seeall)

local M = class("AirWorkSettingViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_def_setting_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkSettingView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
