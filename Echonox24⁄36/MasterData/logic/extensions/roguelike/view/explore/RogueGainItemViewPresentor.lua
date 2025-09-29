-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueGainItemViewPresentor.lua

module("logic.extensions.roguelike.view.explore.RogueGainItemViewPresentor", package.seeall)

local M = class("RogueGainItemViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Gainitem_gain_item,
		ResName.Common_Backpack_Item
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueGainItemView.New())
	table.insert(views, BlurBgView.New())

	return views
end

return M
