-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/enter/AirWorkTemplateSelectViewPresentor.lua

module("logic.extensions.airworkshop.flow.defflow.view.enter.AirWorkTemplateSelectViewPresentor", package.seeall)

local M = class("AirWorkTemplateSelectViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_def_template_scene_select
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkTemplateSelectView.New())
	table.insert(views, BlurBgView.New("common_blur_rt"))

	return views
end

return M
