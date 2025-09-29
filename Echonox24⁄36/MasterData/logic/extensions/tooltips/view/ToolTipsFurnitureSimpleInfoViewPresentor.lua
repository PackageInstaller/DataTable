-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsFurnitureSimpleInfoViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsFurnitureSimpleInfoViewPresentor", package.seeall)

local M = class("ToolTipsFurnitureSimpleInfoViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_facility_live_furniture_info_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsFurnitureSimpleInfoView.New())
	table.insert(views, ToolTipsLimitInScreenComp.New())

	return views
end

return M
