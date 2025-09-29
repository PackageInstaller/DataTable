-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/DungeonEnemyViewPresentor.lua

module("logic.extensions.dungeon.view.DungeonEnemyViewPresentor", package.seeall)

local M = class("DungeonEnemyViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Branchline_enemy_details_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, DungeonEnemyView.New())

	return views
end

return M
