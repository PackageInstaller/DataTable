-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/view/integral_drop/ActivityIntegralDropViewPresentor.lua

module("logic.extensions.welfare.view.integral_drop.ActivityIntegralDropViewPresentor", package.seeall)

local M = class("ActivityIntegralDropViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Activity_integralDrop_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ActivityIntegralDropView.New())

	return views
end

return M
