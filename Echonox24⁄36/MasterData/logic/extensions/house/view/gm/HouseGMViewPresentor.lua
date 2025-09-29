-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/gm/HouseGMViewPresentor.lua

module("logic.extensions.house.view.gm.HouseGMViewPresentor", package.seeall)

local M = class("HouseGMViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Room_main_house_gm_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HouseGMView.New())

	return views
end

return M
