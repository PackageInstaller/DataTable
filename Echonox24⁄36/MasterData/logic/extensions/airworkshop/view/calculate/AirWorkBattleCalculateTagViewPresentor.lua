-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/calculate/AirWorkBattleCalculateTagViewPresentor.lua

module("logic.extensions.airworkshop.view.calculate.AirWorkBattleCalculateTagViewPresentor", package.seeall)

local M = class("AirWorkBattleCalculateTagViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.AirWorkShop_air_workshop_calculate_tag
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, AirWorkBattleCalculateTagView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
