-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/materialdungeon/StableAreaChapterView.lua

module("logic.extensions.dungeon.view.materialdungeon.StableAreaChapterView", package.seeall)

local M = class("StableAreaChapterView", ViewComponent)
local GuideId = 1001

function M:ctor()
	self._dungeonCellList = {}
	self._moneyCodes = {}
	self._ownItemGoList = {}
end

function M:buildUI()
	self._btnReturn = self:getBtn("6&title_view_-878360263")
	self._btnHome = self:getBtn("6&title_view_1398742689")
	self._btnExplain = self:getBtn("6&title_view_-636449388")
	self._imgBg = Astral.ImageDynIcon.Get(self:getGo("stable_area_chapters_view_939861505"))
	self._imgItemIcon = Astral.ImageDynIcon.Get(self:getGo("stable_area_chapters_view_-610986746"))
	self._dungeonLoopList = LoopListHelper.New(self:getGo("stable_area_chapters_view_729555226"))

	self._dungeonLoopList:InitListView(0, self._updateDungeonCell, self)

	self._transfItemRoot = self:getRectTransform("stable_area_chapters_view_-1130540935")
	self._detailComp = self._viewPresentor:getDetailComp()
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
	self._btnExplain:AddClickListener(self._onClickExplain, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
	self._btnExplain:RemoveClickListener()
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
			local chapterId, dungeonIndex = DungeonMaterialChapterModel.instance:getClickChapterIdAndDungeonIndex()

			self._chapterId = chapterId
			self._curDungeonIndex = dungeonIndex or 1
		end
	end

	self._chapterMo = DungeonMaterialChapterModel.instance:getChapterMoByChapterId(self._chapterId)
	self._dungeonMoList = {}

	for _, dungeonId in ipairs(self._chapterMo:getDungeonIds()) do
		local dungeonMo = DungeonMaterialChapterModel.instance:getDungeonMoById(dungeonId)

		table.insert(self._dungeonMoList, dungeonMo)
	end

	self._curDungeonMo = self._dungeonMoList[self._curDungeonIndex]
end

function M:_refreshView()
	self:_refreshInfo()
	self:_refreshDungeonList()
	self:_refreshDetail()
	self:_refreshOwnedItems()
end

function M:_refreshInfo()
	local itemIcon = self._chapterMo:getBgItemIcon()
	local itemUrl = string.format("ui/bigbg/resources_explore/stable_area_icon/%s.png", itemIcon)

	self._imgItemIcon:SetImage(itemUrl)

	local bgName = self._chapterMo:getBg()
	local bgUrl = string.format("ui/bigbg/resources_explore/stable_area_bg/%s.png", bgName)

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

function M:_refreshDetail()
	self._detailComp:setData(self._curDungeonMo, self._chapterMo, self._curDungeonIndex)
end

function M:_hideOwnedItems()
	for i = 0, self._transfItemRoot.childCount - 1 do
		local goChild = self._transfItemRoot:GetChild(i).gameObject

		goutil.setActive(goChild, false)
	end
end

function M:_getOwnedItem(index)
	local go = self._ownItemGoList[index]

	if not go then
		local template = self:getResInstance(ResName.Common_Backpack_Item)

		go = goutil.cloneAndSetParent(template, self._transfItemRoot)
		self._ownItemGoList[index] = go
	end

	goutil.setActive(go, true)

	return go
end

function M:_refreshOwnedItems()
	self:_hideOwnedItems()
	self:_updateMoneyCodes()

	for index, code in ipairs(self._moneyCodes) do
		local go = self:_getOwnedItem(index)
		local itemCell = Astral.SimpleLuaComponentContainer.Add(go, StableItemCell)
		local numStr = MoneyModel.instance:getMoneyUpdateParams(code)
		local itemData = ItemUtil.createItemData({
			itemId = code,
			count = numStr
		})

		itemCell:updateData(itemData)
		itemCell:setCellRange(self._transfItemRoot.gameObject)
		itemCell:setShowSelectedEffect(false)
	end
end

function M:_updateMoneyCodes()
	local moneyShowType = string.format("MaterialChapter%s", self._chapterId)
	local moneyShowInfo = MoneyUtil.getMoneyInfoByShowType(moneyShowType)
	local moneyCodes = moneyShowInfo.moneyCodes

	table.clear(self._moneyCodes)

	for i = 1, #moneyCodes do
		local codeInfo = moneyCodes[i]

		if codeInfo.code ~= CommEnum.CurrencyCodeEnum.TlCode then
			table.insert(self._moneyCodes, codeInfo.code)
		end
	end

	self._moneyCodes = TableUtil.reverseTable(self._moneyCodes)
end

function M:_onClickReturn()
	local sceneFlowType = SceneFace.instance:getCurSceneFlowTyp()

	if sceneFlowType == nil then
		self:_onClickHome()
	else
		DungeonMaterialChapterModel.instance:setClickChapterIdAndDungeonIndex(self._chapterId, nil)
		self:back()
	end
end

function M:_onClickHome()
	DungeonMaterialChapterModel.instance:setClickChapterIdAndDungeonIndex(self._chapterId, nil)
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onClickExplain()
	ViewMgr.instance:open(ViewName.ImageGuide, {
		GuideId
	})
end

function M:_updateDungeonCell(index)
	local cellIndex = index + 1
	local item = self._dungeonLoopList:NewListViewItem("stable_area_dungeon_item")
	local cell = Astral.SimpleLuaComponentContainer.Add(item.gameObject, StableAreaDungeonCell)
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
end

return M
