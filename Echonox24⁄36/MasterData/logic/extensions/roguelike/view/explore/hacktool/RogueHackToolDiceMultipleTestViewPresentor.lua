-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/hacktool/RogueHackToolDiceMultipleTestViewPresentor.lua

module("logic.extensions.roguelike.view.explore.hacktool.RogueHackToolDiceMultipleTestViewPresentor", package.seeall)

local M = class("RogueHackToolDiceMultipleTestViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroup_hacktool_dice_mock_roguelike_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueHackToolDiceMultipleTestView.New())

	return views
end

return M
