-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/challenge/AirWorkShopRodeoFinishResultTipsPresentor.lua

module("logic.extensions.airworkshop.view.challenge.AirWorkShopRodeoFinishResultTipsPresentor", package.seeall)

local M = class("AirWorkShopRodeoFinishResultTipsPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_sports_calculate_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopRodeoFinishResultTips.New())

	return views
end

return M
