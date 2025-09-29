-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/teachingdungeon/TeachingChapterViewPresentor.lua

module("logic.extensions.dungeon.view.teachingdungeon.TeachingChapterViewPresentor", package.seeall)

local M = class("TeachingChapterViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Teach_explore_teach_explore_main_view,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_TeachExplore)
	}
end

function M:buildViews()
	local views = {}

	table.insert(views, TeachingChapterView.New())

	return views
end

return M
