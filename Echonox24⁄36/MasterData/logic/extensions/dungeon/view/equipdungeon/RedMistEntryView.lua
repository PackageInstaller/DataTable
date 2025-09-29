-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/RedMistEntryView.lua

module("logic.extensions.dungeon.view.equipdungeon.RedMistEntryView", package.seeall)

local M = class("RedMistEntryView", ViewComponent)
local SystemOpenMap = {
	[2001] = GameEnum.SystemEnum.EquipmentDungeonChapter1,
	[2002] = GameEnum.SystemEnum.EquipmentDungeonChapter2,
	[2003] = GameEnum.SystemEnum.EquipmentDungeonChapter3
}

function M:ctor()
	return
end

function M:buildUI()
	self._scrollRect = self:getUIComponent("red_mist_entry_view_-434669149", UIComponentType.ScrollRect)
	self._loopList = LoopListHelper.New(self:getGo("red_mist_entry_view_-434669149"))

	self._loopList:InitListView(0, self._updateChapterCell, self)
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	self:_initData()
	self:_refreshView()
end

function M:onExit()
	return
end

function M:destroyUI()
	self._loopList:Dispose()

	self._loopList = nil
end

function M:_initData()
	local chapterList = DungeonEquipExploreChapterModel.instance:getAllChapter()

	self._chapterList = {}

	for _, v in pairs(chapterList) do
		table.insert(self._chapterList, v)
	end

	table.sort(self._chapterList, function(chapter1, chapter2)
		return chapter1:getChapterId() < chapter2:getChapterId()
	end)
end

function M:_refreshView()
	self._loopList:SetListItemCount(#self._chapterList)
	self._loopList:RefreshAllShownItem()
end

function M:_updateChapterCell(index)
	local cellIndex = index + 1
	local item = self._loopList:NewListViewItem("red_mist_chapter_item")
	local itemView = Astral.SimpleLuaComponentContainer.Add(item.gameObject, RedMistChapterCell)
	local chapterMo = self._chapterList[cellIndex]
	local systemEnum = SystemOpenMap[chapterMo:getChapterId()]

	itemView:setData(chapterMo, systemEnum, self._onClickChapter, self)

	return item
end

function M:_onClickChapter(chapterMo)
	ViewMgr.instance:open(ViewName.RedMistChapterView, chapterMo:getChapterId())
end

return M
