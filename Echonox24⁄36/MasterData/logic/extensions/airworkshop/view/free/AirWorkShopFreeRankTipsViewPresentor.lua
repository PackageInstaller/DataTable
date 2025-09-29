-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/free/AirWorkShopFreeRankTipsViewPresentor.lua

module("logic.extensions.airworkshop.view.free.AirWorkShopFreeRankTipsViewPresentor", package.seeall)

local M = class("AirWorkShopFreeRankTipsViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_challenge_schema_rank_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopFreeRankTipsView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
