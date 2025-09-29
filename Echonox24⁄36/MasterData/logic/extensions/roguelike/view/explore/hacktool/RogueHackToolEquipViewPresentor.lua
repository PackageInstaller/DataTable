-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/hacktool/RogueHackToolEquipViewPresentor.lua

module("logic.extensions.roguelike.view.explore.hacktool.RogueHackToolEquipViewPresentor", package.seeall)

local M = class("RogueHackToolEquipViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroupother_rungroup_equip_main_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueHackToolEquipView.New())
	table.insert(views, TitleView.New())

	return views
end

return M
