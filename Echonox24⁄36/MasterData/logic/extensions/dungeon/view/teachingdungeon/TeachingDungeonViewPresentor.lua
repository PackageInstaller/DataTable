-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/teachingdungeon/TeachingDungeonViewPresentor.lua

module("logic.extensions.dungeon.view.teachingdungeon.TeachingDungeonViewPresentor", package.seeall)

local M = class("TeachingDungeonViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Teach_explore_teach_explore_chapter_view
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TeachingDungeonView.New())

	return views
end

return M
