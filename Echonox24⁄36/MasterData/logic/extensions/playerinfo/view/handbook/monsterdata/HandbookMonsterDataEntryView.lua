-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/monsterdata/HandbookMonsterDataEntryView.lua

module("logic.extensions.playerinfo.view.handbook.monsterdata.HandbookMonsterDataEntryView", package.seeall)

local M = class("HandbookMonsterDataEntryView", ViewComponent)

M.SubToggleType = {
	NormalMythos = 4,
	EliteEtc = 3,
	NormalEtc = 5,
	EliteBoss = 2,
	EliteMythos = 1
}

function M:ctor()
	M.super.ctor(self)
	MonsterConfig.instance:loadLevelMonsterConfig(100000)
end

function M:getSubPageTyp()
	return CommEnum.HandBookSubView.Monster
end

function M:buildUI()
	self._btnReturn = self:getBtn("2&title_view_-878360263")
	self._txtTitle = self:getText("2&title_view_-788888785")
	self._loopLst = LoopGridViewHelper.New(self:getGo("handbook_mosterdata_entry_view_1447146319"))

	self._loopLst:InitGridView(0, self._onCellUpdate, self)

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self)
	self._toggleTabControl:setTabCheckFunc(nil)

	self._tabComp = Astral.LuaComponentContainer.Add(self:getGo("right_tab_content_-399612422"), HandbookRightTabComp)

	self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(1))
	self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(2))
	self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(3))
	self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(4))
	self._toggleTabControl:addToggleTab(self._tabComp:getToggleTab(5))

	for keyStr, valInt in pairs(self.SubToggleType) do
		self._tabComp:setTabName(valInt, lang(string.format("tip_handbook_monster_tab_%s", valInt)))
	end
end

function M:destroyUI()
	self._btnReturn = nil
	self._txtTitle = nil

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

	print(string.format("cell click[%s] typ[%s] lock[%s]", id, typ, isLock))

	if isLock then
		FloatWordMgr.instance:show(lang("tip_handbook_monster_evaluate_2"))

		return
	end

	if not self._passThroughInfo then
		self._passThroughInfo = {}
	end

	self._passThroughInfo.id = id

	ViewMgr.instance:open(ViewName.HandbookMonsterdataView, self._passThroughInfo)
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
	self._pageDataGroup = {}

	local cfgLst = HandbookConfig.instance:getConfigList(ConfigName.GalleryMonster)

	if cfgLst and #cfgLst > 0 then
		for _, cfg in ipairs(cfgLst) do
			local typ = cfg.typ

			if not self._pageDataGroup[typ] then
				self._pageDataGroup[typ] = {}
			end

			table.insert(self._pageDataGroup[typ], cfg)
		end
	end
end

function M:_getPageUnReadCount(pageTyp)
	local count = 0

	for index, cfg in ipairs(self._pageDataGroup[pageTyp] or {}) do
		if GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.Monster, cfg.id) then
			count = count + 1
		end
	end

	return count
end

function M:_getItemDataLst(pageTyp)
	return self._pageDataGroup[pageTyp] or {}
end

function M:_getItemDataLstLen(pageTyp)
	local dataLst = self._pageDataGroup[pageTyp]

	return dataLst and #dataLst or 0
end

function M:_getItemData(index)
	local curPageTyp = self:getActiveIndex()

	if self._pageDataGroup[curPageTyp] then
		return self._pageDataGroup[curPageTyp][index]
	else
		return nil
	end
end

function M:_onCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local data = self:_getItemData(curIndex)
	local item = self._loopLst:NewListViewItem("handbook_mosterdata_item")
	local shower = Astral.LuaComponentContainer.Get(item.gameObject, HandbookMonsterItemCell)

	if shower == nil then
		shower = Astral.LuaComponentContainer.Add(item.gameObject, HandbookMonsterItemCell)
	end

	shower:setHandler(self)
	shower:setData(data)

	return item
end

return M
