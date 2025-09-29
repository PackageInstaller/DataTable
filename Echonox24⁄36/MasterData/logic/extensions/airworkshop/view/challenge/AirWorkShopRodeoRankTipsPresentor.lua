-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/challenge/AirWorkShopRodeoRankTipsPresentor.lua

module("logic.extensions.airworkshop.view.challenge.AirWorkShopRodeoRankTipsPresentor", package.seeall)

local M = class("AirWorkShopRodeoRankTipsPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_sports_rank_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopRodeoRankTips.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
