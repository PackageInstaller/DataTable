-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/equipdungeon/RedMistChapterView.lua

module("logic.extensions.dungeon.view.equipdungeon.RedMistChapterView", package.seeall)

local M = class("RedMistChapterView", ViewComponent)

function M:ctor()
	self._dungeonCellList = {}
	self._moneyCodes = {}
	self._ownItemGoList = {}
end

function M:buildUI()
	self._imgBg = Astral.ImageDynIcon.Get(self:getGo("red_mist_chapters_view_1575211541"))
	self._dungeonLoopList = LoopListHelper.New(self:getGo("red_mist_chapters_view_1318769934"))

	self._dungeonLoopList:InitListView(0, self._updateDungeonCell, self)
	goutil.setActive(self._goItemPrefab, false)

	self._bossComp = self._viewPresentor:getBossComp()
	self._detailComp = self._viewPresentor:getDetailComp()
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
	self._dungeonLoopList:Dispose()

	self._dungeonLoopList = nil
end

function M:_initData()
	if not self._viewPresentor:getIsBackOpen() then
		self._chapterId = self:getOpenParam()[1]
		self._curDungeonIndex = self:getOpenParam()[2] or 1

		if not self:getFirstParam() then
			local chapterId, dungeonIndex = DungeonEquipExploreChapterModel.instance:getClickChapterIdAndDungeonIndex()

			self._chapterId = chapterId
			self._curDungeonIndex = dungeonIndex or 1
		end
	end

	self._chapterMo = DungeonEquipExploreChapterModel.instance:getChapterMoByChapterId(self._chapterId)
	self._dungeonMoList = {}

	for _, dungeonId in ipairs(self._chapterMo:getDungeonIds()) do
		local dungeonMo = DungeonEquipExploreChapterModel.instance:getDungeonMoById(dungeonId)

		table.insert(self._dungeonMoList, dungeonMo)
	end

	self._curDungeonMo = self._dungeonMoList[self._curDungeonIndex]
end

function M:_refreshView()
	self:_refreshInfo()
	self:_refreshDungeonList()
	self:_refreshBossInfo()
	self:_refreshDetail()
end

function M:_refreshInfo()
	local bgName = self._chapterMo:getBg()
	local bgUrl = string.format("ui/bigbg/resources_explore/red_mist_bg/%s.png", bgName)

	self._imgBg:SetImage(bgUrl)
end

function M:_refreshDungeonList()
	table.clear(self._dungeonCellList)
	self._dungeonLoopList:SetListItemCount(#self._dungeonMoList)
	self._dungeonLoopList:RefreshAllShownItem()

	local loopIndex = self._curDungeonIndex - 1

	if not self._dungeonLoopList:GetShownItemByItemIndex(loopIndex) then
		self._dungeonLoopList:MoveToItemIndex(loopIndex)
	end
end

function M:_refreshBossInfo()
	self._bossId = self._curDungeonMo:getBossId()

	self._bossComp:setData(self._bossId, self._chapterMo, self._curDungeonMo:getId())
end

function M:_refreshDetail()
	self._detailComp:setData(self._curDungeonMo, self._chapterMo, self._curDungeonIndex)
end

function M:_updateDungeonCell(index)
	local cellIndex = index + 1
	local item = self._dungeonLoopList:NewListViewItem("red_mist_dungeon_item")
	local cell = Astral.SimpleLuaComponentContainer.Add(item.gameObject, RedMistDungeonCell)
	local dungeonMo = self._dungeonMoList[cellIndex]
	local isSelect = self._curDungeonMo:getId() == dungeonMo:getId()

	cell:setData(dungeonMo, cellIndex, self._onClickDungeon, self)
	cell:setSelect(isSelect)

	self._dungeonCellList[cellIndex] = cell

	return item
end

function M:_onClickDungeon(dungeonMo, index)
	if dungeonMo == self._curDungeonMo then
		return
	end

	self._curDungeonMo = dungeonMo
	self._curDungeonIndex = index

	for _, cell in pairs(self._dungeonCellList) do
		local isSelect = cell:getDungeonId() == dungeonMo:getId()

		cell:setSelect(isSelect)
	end

	self:_refreshDetail()
	self:_refreshBossInfo()
end

return M
