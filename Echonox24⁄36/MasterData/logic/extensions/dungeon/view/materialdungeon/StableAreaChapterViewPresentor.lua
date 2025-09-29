-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/materialdungeon/StableAreaChapterViewPresentor.lua

module("logic.extensions.dungeon.view.materialdungeon.StableAreaChapterViewPresentor", package.seeall)

local M = class("StableAreaChapterViewPresentor", ViewPresentor)

function M:ctor()
	M.super.ctor(self)
end

function M:dependWhatResources()
	return {
		ResName.Resources_stable_area_chapter_view,
		ResName.Common_Backpack_Item,
		ResName.Resources_stable_area_item,
		ResName.Common_hero_item,
		CommonResPath.Url_Currency_Item,
		IconLoader.getSpriteAtlasUrl(IconType.DynSpriteAtlas_ResourcesExplore)
	}
end

function M:buildViews()
	local views = {}

	self._chapterView = StableAreaChapterView.New()

	table.insert(views, self._chapterView)

	self._detailComp = StableAreaDungeonDetailComp.New()

	table.insert(views, self._detailComp)
	table.insert(views, MoneyView.New(CommEnum.MoneyShowType.DungeonShowType))

	return views
end

function M:getDetailComp()
	return self._detailComp
end

function M:getChapterView()
	return self._chapterView
end

return M
