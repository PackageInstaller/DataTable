-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/mainline/MainlineChapterSelectView.lua

module("logic.extensions.dungeon.view.mainline.MainlineChapterSelectView", package.seeall)

local M = class("MainlineChapterSelectView", ViewComponent)

function M:buildUI()
	self._btnReturn = self:getBtn("0&title_view_-878360263")
	self._btnHome = self:getBtn("0&title_view_1398742689")
	self._loopListHelper = LoopListHelper.New(self:getGo("instance_chapter_view_1639270761"))

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)

	self._bgNormalGo = self:getGo("instance_chapter_view_393680786")
	self._bgSecretGo = self:getGo("instance_chapter_view_416031877")
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
end

function M:_onClickHome()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)
end

function M:_onClickReturn()
	self:back()
end

function M:destroyUI()
	self._btnReturn = nil
	self._btnHome = nil

	self._loopListHelper:Dispose()

	self._loopListHelper = nil
end

function M:onEnter()
	ViewMgr.instance:close(ViewName.MainlineDungeonView, false, WindowType.WindowCloseReasonType.QuickCloseType, false)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Dungeon)

	self._chapterId = self:getFirstParam() or 0

	self:_initView()
	self:_refreshView()
	GlobalDispatcher:dispatchEvent(EventType.ON_SCENE_BGMAMBCHANGE, CriwareAudioEnum.music_main_huodong)
end

function M:_initView()
	local chapterMOList = DungeonMainLineChapterModel.instance:getAllMainlineChapter()

	self._unlockChapterMOList = {}

	for i, chapterMO in ipairs(chapterMOList) do
		if chapterMO[1]:isPreChapterPassed() then
			table.insert(self._unlockChapterMOList, chapterMO)
		end
	end

	local nowTime = AirtightRoomModel.instance:getServerTime()
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo(nowTime)

	self._isAirtightTime = inAirtightTime or inTimeByItem

	goutil.setActive(self._bgNormalGo, not self._isAirtightTime)
	goutil.setActive(self._bgSecretGo, self._isAirtightTime)
end

function M:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Dungeon)
	self._loopListHelper:ClearCells()
	GlobalDispatcher:dispatchEvent(EventType.ON_CUR_BGMAMBCLOSE)
end

function M:_refreshView()
	local showIndex = 0
	local difficulty = DungeonEnum.Difficulty.Easy

	for index, chapterMoMap in ipairs(self._unlockChapterMOList) do
		if chapterMoMap[difficulty]:getChapterId() == self._chapterId then
			showIndex = index - 1

			break
		end
	end

	self._loopListHelper:SetListItemCount(#self._unlockChapterMOList, true)
	self._loopListHelper:MoveToItemIndex(showIndex)

	for _, chapterMoMap in ipairs(self._unlockChapterMOList) do
		DungeonMainLineChapterModel.instance:setDungeonChapterCache(chapterMoMap[difficulty]:getChapterId())
	end
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local itemData = self._unlockChapterMOList[curIndex]
	local item = self._loopListHelper:NewListViewItem("instance_chapter_item")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, MainlineChapterCell)

	shower:setData(itemData)

	return item
end

return M
