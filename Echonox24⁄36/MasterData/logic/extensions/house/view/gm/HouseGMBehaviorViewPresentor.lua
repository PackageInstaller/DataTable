-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/view/gm/HouseGMBehaviorViewPresentor.lua

module("logic.extensions.house.view.gm.HouseGMBehaviorViewPresentor", package.seeall)

local M = class("HouseGMBehaviorViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Main_behavior_tree_select_tips,
		ResName.Main_behavior_tree_select_item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, HouseGMBehaviorView.New())

	return views
end

return M
