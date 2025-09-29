-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/challenge/AirWorkShopRodeoWeekRewardTipsPresentor.lua

module("logic.extensions.airworkshop.view.challenge.AirWorkShopRodeoWeekRewardTipsPresentor", package.seeall)

local M = class("AirWorkShopRodeoWeekRewardTipsPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_week_reward_tips,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_AirWorkShop)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopRodeoWeekRewardTips.New())

	return views
end

return M
