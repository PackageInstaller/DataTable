-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tooltips/view/ToolTipsCurrencyViewPresentor.lua

module("logic.extensions.tooltips.view.ToolTipsCurrencyViewPresentor", package.seeall)

local M = class("ToolTipsCurrencyViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Common_top_currency_layout_view,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, ToolTipsCurrencyViewComp.New())

	return views
end

return M
