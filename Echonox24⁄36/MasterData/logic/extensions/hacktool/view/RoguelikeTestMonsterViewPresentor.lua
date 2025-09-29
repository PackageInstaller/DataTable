-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hacktool/view/RoguelikeTestMonsterViewPresentor.lua

module("logic.extensions.hacktool.view.RoguelikeTestMonsterViewPresentor", package.seeall)

local M = class("RoguelikeTestMonsterViewPresentor", ViewPresentor)

function M:dependWhatResources()
	return {
		ResName.Hacktool_roguelike_test_monster
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, RoguelikeTestMonsterView.New())

	return views
end

return M
