-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/cg/HandbookCGEntryView.lua

module("logic.extensions.playerinfo.view.handbook.cg.HandbookCGEntryView", package.seeall)

local M = class("HandbookCGEntryView", ViewComponent)

M.SubToggleType = {
	LoadingCG = 2,
	PlotCG = 1,
	EventCG = 3
}

function M:ctor()
	M.super.ctor(self)
end

function M:getSubPageTyp()
	return CommEnum.HandBookSubView.CG
end

function M:buildUI()
	self._btnReturn = self:getBtn("2&title_view_-878360263")
	self._loopLst = LoopGridViewHelper.New(self:getGo("handbook_cg_entry_view_2049145520"))

	self._loopLst:InitGridView(0, self._onCellUpdate, self)

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:setTabCheckFunc(nil)

	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("right_tab_content_-399612422"), HandbookRightTabComp)

	self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(1))
	self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(2))
	self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(3))
end

function M:destroyUI()
	self._btnReturn = nil

	self._tabComp:destroyUI()
	self._toggleTabControl:destroy()

	self._toggleTabControl = nil

	self._loopLst:Dispose()

	self._loopLst = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	self:_prepareData()
	self:_refreshTabNewMark()

	local defaultSelectTabIndex = 1

	self._toggleTabControl:selectTab(defaultSelectTabIndex)
end

function M:onExit()
	self:setEvent(false)

	self._passThroughInfo = nil

	self:setActiveIndex(nil)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleHandbookUnreadInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HANDBOOK_UNREAD_INFO_CHANGE, self._handleHandbookUnreadInfoChange, self)
	end
end

function M:_handleHandbookUnreadInfoChange(e)
	self:_refreshTabNewMark()

	local len = self:_getItemDataLstLen(self:getActiveIndex())

	self._loopLst:SetListItemCount(len, true)
	self._loopLst:RefreshAllShownItem()
end

function M:_refreshTabNewMark()
	for keyStr, valInt in pairs(self.SubToggleType) do
		local redPoint = self:_getPageUnReadCount(valInt)

		self._tabComp:setRedPointNum(valInt, redPoint)
	end
end

function M:_onClickReturn()
	self:close()
end

function M:onCellClick(cgItemCell)
	local id = cgItemCell:getId()
	local typ = cgItemCell:getTyp()
	local isLock = cgItemCell:getIsLock()

	print(string.format("cell click[%s] lock[%s]", id, isLock))

	if isLock then
		FloatWordMgr.instance:show(lang("tip_not_unlock"))

		return
	end

	if not self._passThroughInfo then
		self._passThroughInfo = {}
	end

	if cgItemCell:getIsNew() then
		HandbookController.instance:setHandbookTypIdRead(GameEnum.UnlockTypeEnum.CG, id, true)
		cgItemCell:setNewMark(false)
	end

	self._passThroughInfo.id = id
	self._passThroughInfo.typ = typ
	self._passThroughInfo.lst = self:_getItemDataLst(typ)

	ViewMgr.instance:open(ViewName.HandbookCGPreviewView, self._passThroughInfo)
end

function M:getActiveIndex()
	return self._activeIndex or -1
end

function M:setActiveIndex(index)
	self._activeIndex = index
end

function M:setPage(tabIndex)
	local orgIndex = self:getActiveIndex()
	local needReresh = orgIndex ~= tabIndex

	self:setActiveIndex(tabIndex)

	if needReresh then
		local len = self:_getItemDataLstLen(self:getActiveIndex())

		if len > 0 then
			self._loopLst:SetListItemCount(len, true)
			self._loopLst:RefreshAllShownItem()
		else
			self._loopLst:ClearCells()
		end
	end
end

function M:_prepareData()
	self._pageCgGroup = {}
	self._pageCgGroup[self.SubToggleType.PlotCG] = {}
	self._pageCgGroup[self.SubToggleType.LoadingCG] = {}
	self._pageCgGroup[self.SubToggleType.EventCG] = {}

	local cfgLst = HandbookConfig.instance:getConfigList(ConfigName.GalleryCg)

	if cfgLst and #cfgLst > 0 then
		for _, cfg in ipairs(cfgLst) do
			table.insert(self._pageCgGroup[cfg.typ], cfg)
		end
	end

	for key, lst in pairs(self._pageCgGroup) do
		if #lst > 0 then
			table.sort(lst, function(a, b)
				return a.sortType > b.sortType
			end)

			self._pageCgGroup[key] = lst
		end
	end
end

function M:_getPageUnReadCount(pageTyp)
	local count = 0

	for index, cfg in ipairs(self._pageCgGroup[pageTyp] or {}) do
		if GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.CG, cfg.id) then
			count = count + 1
		end
	end

	return count
end

function M:_getItemDataLst(pageTyp)
	return self._pageCgGroup[pageTyp] or {}
end

function M:_getItemDataLstLen(pageTyp)
	local dataLst = self._pageCgGroup[pageTyp]

	return dataLst and #dataLst or 0
end

function M:_getItemData(index)
	local curPageTyp = self:getActiveIndex()

	if self._pageCgGroup[curPageTyp] then
		return self._pageCgGroup[curPageTyp][index]
	else
		return nil
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local data = self:_getItemData(curIndex)
	local item = self._loopLst:NewListViewItem("handbook_cg_item")
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, HandbookCGItemCell)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(item.gameObject, HandbookCGItemCell)
	end

	shower:setHandler(self)
	shower:setData(data)

	return item
end

return M
