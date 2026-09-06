-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/annimatch/view/AnnimatchHistoryBanView.lua

module("logic.extensions.annimatch.view.AnnimatchHistoryBanView", package.seeall)

local AnnimatchHistoryBanView = class("AnnimatchHistoryBanView", ViewComponent)

function AnnimatchHistoryBanView:ctor()
	AnnimatchHistoryBanView.super.ctor(self)
end

function AnnimatchHistoryBanView:unbindEvents()
	AnnimatchHistoryBanView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function AnnimatchHistoryBanView:bindEvents()
	AnnimatchHistoryBanView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function AnnimatchHistoryBanView:buildUI()
	AnnimatchHistoryBanView.super.buildUI(self)

	self._empty = self:getGo("empty")
	self._btnClose = self:getGo("btnClose")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function AnnimatchHistoryBanView:onExit()
	AnnimatchHistoryBanView.super.onExit(self)
	self._scrollList:dispose()

	for cell, scroll in pairs(self._scrollMap) do
		scroll:dispose()

		self._scrollMap[cell] = nil
	end
end

function AnnimatchHistoryBanView:onEnter()
	AnnimatchHistoryBanView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 133001
	end

	self._actType = 133
	self._banInfo = AnnimatchModel.instance:getBanPetInfo(self._activityId)
	self._scrollMap = {}
	self._history = self._banInfo.history
	self._startTime, self._endTime = ActivityDefineController.instance:getStartTimeAndEndTime(self._actType, self._activityId)

	if #self._history > 0 then
		self._scrollList:reloadData(self._history)
	end

	GameUtil.SetActive(self._empty, #self._history <= 0)
end

function AnnimatchHistoryBanView:_updateCell(view, cell, data)
	local tableviewPet = goutil.findChild(cell, "tableviewPet")
	local tablecellPet = goutil.findChild(cell, "tableviewPet/tablecellPet")
	local txtWeek = goutil.findChildTextComponent(cell, "txtWeek")
	local weekDate = data.weekDate
	local day = weekDate % 100

	weekDate = math.floor(weekDate / 100)

	local month = weekDate % 100

	weekDate = math.floor(weekDate / 100)

	local year = weekDate
	local oneWeekStamp = 604800
	local startHour = 18000
	local timeStamp = GameUtil.date2time(year, month, day)
	local diffTimeStamp = timeStamp - self._startTime + startHour + 1
	local week = math.ceil(diffTimeStamp / oneWeekStamp)

	if not data.banRaceIds then
		txtWeek.text = string.format("第%d周", week)

		local scroll = self._scrollMap[cell]

		if scroll == nil then
			scroll = ScrollerList.create(tableviewPet, tablecellPet, GameUtil.handler(self._updateCellPet, self), GameUtil.handler(self._clearCellPet, self))
			self._scrollMap[cell] = scroll
		end

		scroll:reloadData(data.banRaceIds)
	end
end

function AnnimatchHistoryBanView:_clearCell(cell)
	local scroll = self._scrollMap[cell]

	if scroll ~= nil then
		scroll:dispose()

		self._scrollMap[cell] = nil
	end
end

function AnnimatchHistoryBanView:_updateCellPet(view, cell, data)
	MaterialMgr.setCell(MatType.Pet, data, cell)
end

function AnnimatchHistoryBanView:_clearCellPet(cell)
	MaterialMgr.resetAll(cell)
end

return AnnimatchHistoryBanView
