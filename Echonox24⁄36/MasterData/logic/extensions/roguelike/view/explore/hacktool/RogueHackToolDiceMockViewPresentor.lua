-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/hacktool/RogueHackToolDiceMockViewPresentor.lua

module("logic.extensions.roguelike.view.explore.hacktool.RogueHackToolDiceMockViewPresentor", package.seeall)

local M = class("RogueHackToolDiceMockViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Rungroup_hacktool_dice_mock_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RogueHackToolDiceMockView.New())

	return views
end

return M
