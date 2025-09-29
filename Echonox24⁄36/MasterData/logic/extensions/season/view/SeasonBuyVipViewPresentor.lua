-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonBuyVipViewPresentor.lua

module("logic.extensions.season.view.SeasonBuyVipViewPresentor", package.seeall)

local M = class("SeasonBuyVipViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Season_fcpy_buy_privilege_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, BlurBgView.New())
	table.insert(views, SeasonBuyVipView.New())

	return views
end

return M
