-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueBuyPropTipsViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueBuyPropTipsViewPresentor", package.seeall)

local M = class("RogueBuyPropTipsViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Tips_item_detail_tips_old,
		CommonResPath.Url_Currency_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueBuyPropTipsView.New())

	return views
end

return M
