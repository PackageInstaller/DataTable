-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/task/AirWorkShopTrophyTopTipsPresentor.lua

module("logic.extensions.airworkshop.view.task.AirWorkShopTrophyTopTipsPresentor", package.seeall)

local M = class("AirWorkShopTrophyTopTipsPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_trophy_tips
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkShopTrophyTopTips.New())

	return views
end

return M
