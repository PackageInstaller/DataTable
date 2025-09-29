-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housemain/view/RoomBacklogView.lua

module("logic.extensions.housemain.view.RoomBacklogView", package.seeall)

local M = class("RoomBacklogView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._goRoomRoot = self:getGo("room_map_distribution_view_-900576721")
	self._backLogComps = {}
	self._goTradeCenterRoor = self:getGo("room_backlog_view_-260242682")
	self._btnIgnoreTradePriceChange = self:getBtn("room_backlog_view_-1618619629")
	self._backLogComps[HouseMainEnum.BackLogTyp.tradeOrderFull] = {
		go = self:getGo("room_backlog_view_-30203459"),
		txtNum = self:getText("room_backlog_view_-1147645459"),
		btn = self:getBtn("room_backlog_view_-369077694")
	}
	self._backLogComps[HouseMainEnum.BackLogTyp.tradeGoodsFull] = {
		go = self:getGo("room_backlog_view_-1065299323"),
		btn = self:getBtn("room_backlog_view_-789137766")
	}
	self._backLogComps[HouseMainEnum.BackLogTyp.tradePriceChange] = {
		go = self:getGo("room_backlog_view_-667803380"),
		btn = self:getBtn("room_backlog_view_-512428107")
	}
	self._backLogComps[HouseMainEnum.BackLogTyp.failReportNum] = {
		go = self:getGo("room_backlog_view_-934547031"),
		btn = self:getBtn("room_backlog_view_-1213592655"),
		txt = self:getText("room_backlog_view_-1021684603")
	}
	self._backLogComps[HouseMainEnum.BackLogTyp.spLivingRoomRemain] = {
		go = self:getGo("room_backlog_view_-1608070429"),
		btn = self:getBtn("room_backlog_view_-244929129"),
		txt = self:getText("room_backlog_view_-827090821")
	}
end

function M:destroyUI()
	self._goRoomRoot = nil
	self._goTradeCenterRoor = nil
	self._btnIgnoreTradePriceChange = nil
	self._backLogComps = nil
	self._signGroup = nil
	self._roomUICache = nil
end

function M:bindEvents()
	self._btnIgnoreTradePriceChange:AddClickListener(self._onClickIgnoreTradePriceChange, self)

	for typ, comps in pairs(self._backLogComps) do
		local btn = comps.btn

		if btn then
			btn:AddClickListener(function()
				self:_onClickBackLogItem(typ)
			end, self)
		end
	end
end

function M:unbindEvents()
	self._btnIgnoreTradePriceChange:RemoveClickListener()

	for typ, comps in pairs(self._backLogComps) do
		local btn = comps.btn

		if btn then
			btn:RemoveClickListener()
		end
	end
end

function M:setEventListener(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.HOUSE_BACKLOG_NUM_CHANGE, self.handleHouseBackLogNumChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.HOUSE_BACKLOG_NUM_CHANGE, self.handleHouseBackLogNumChange, self)
	end
end

function M:onEnter()
	local roomIds = HouseMainRoomModel.instance:getRoomIdsLst(HouseEnum.RoomType.Trading)

	self._tradeRoomId = roomIds[1] or 1203

	self:_updateRoomOpenType()
	self:_updateTradeShow()
	self:_updateFailReportShow()
	self:_updateSpLivingRoomRemainShow()
	self:setEventListener(true)
end

function M:onExit()
	self:setEventListener(false)

	self._tradeRoomId = nil
end

function M:handleHouseBackLogNumChange()
	self:_updateTradeShow()
	self:_updateFailReportShow()
	self:_updateSpLivingRoomRemainShow()
end

function M:_onClickBackLogItem(typ)
	local backTyp = HouseMainEnum.BackLogTyp

	if typ == backTyp.tradeOrderFull then
		ViewMgr.instance:open(ViewName.TradingOrder)
	elseif typ == backTyp.tradeGoodsFull then
		ViewMgr.instance:open(ViewName.TradingCentre)
	elseif typ == backTyp.tradePriceChange then
		ViewMgr.instance:open(ViewName.TradingCentre)
		HouseMainRoomModel.instance:setBackLogNum(HouseMainEnum.BackLogTyp.tradePriceChange, 0)
	elseif typ == backTyp.failReportNum then
		ContainmentFacade.instance:openReportDetailViewForUnReadFailReport()
	elseif typ == backTyp.spLivingRoomRemain then
		local roomList = LivingFacilitiesZoneModel.instance:getSpRoomsWithoutMember()

		Dialog.showWarnMessage(lang("tip_title"), string.format(lang("tip_house_backlog_lang"), #roomList))
	end
end

function M:_onClickIgnoreTradePriceChange()
	HouseMainRoomModel.instance:setIgnoreTradePriceChange(true)
end

function M:_updateRoomOpenType()
	local cfgZoneLst = HouseConfig.instance:getConfigList(ConfigName.HouseZone)

	for _, zoneCo in pairs(cfgZoneLst or {}) do
		local roomId = zoneCo.id

		if zoneCo.roomType > 0 and roomId < 9000 then
			local openTyp = HouseMainRoomModel.instance:getRoomOpenTyp(roomId)
			local canUse = openTyp == HouseMainEnum.RoomOpenTyp.OpenActive

			self:setRoomCanUseMark(roomId, canUse)
		end
	end
end

function M:_updateTradeShow()
	local allPoint = 0
	local rootTyp = 2
	local backTyp = HouseMainEnum.BackLogTyp
	local curTyp, curComps

	self:_hideRoomSign(self._tradeRoomId)

	curTyp = backTyp.tradeOrderFull
	curComps = self._backLogComps[curTyp]

	local point = HouseMainRoomModel.instance:getBackLogTypNum(curTyp)

	if point > 0 then
		allPoint = allPoint + point
		curComps.txtNum.text = string.format("x%s", point)

		self:_createRoomSign(self._tradeRoomId, HouseMainEnum.SignMark.TradeOrderFull, rootTyp)
	end

	goutil.setActive(curComps.go, point > 0)

	curTyp = backTyp.tradeGoodsFull
	curComps = self._backLogComps[curTyp]
	point = HouseMainRoomModel.instance:getBackLogTypNum(curTyp)

	if point > 0 then
		allPoint = allPoint + point

		self:_createRoomSign(self._tradeRoomId, HouseMainEnum.SignMark.TradeStorageFull, rootTyp)
	end

	goutil.setActive(curComps.go, point > 0)

	curTyp = backTyp.tradePriceChange
	curComps = self._backLogComps[curTyp]

	if HouseMainRoomModel.instance:getIgnoreTradePriceChange() then
		printWarn("本次登陆已忽视贸易站价格更新")
	end

	point = HouseMainRoomModel.instance:getBackLogTypNum(curTyp)

	if point > 0 then
		allPoint = allPoint + point

		self:_createRoomSign(self._tradeRoomId, HouseMainEnum.SignMark.TradePriceChange, rootTyp)
	end

	goutil.setActive(curComps.go, point > 0)
	goutil.setActive(self._goTradeCenterRoor, allPoint > 0)
end

function M:_updateSpLivingRoomRemainShow()
	local rootTyp = 2
	local roomIdsLst = HouseMainRoomModel.instance:getRoomIdsLst(HouseEnum.RoomType.Living)

	for _, roomId in ipairs(roomIdsLst) do
		self:_hideRoomSign(roomId)
	end

	local curTyp = HouseMainEnum.BackLogTyp.spLivingRoomRemain
	local curComps = self._backLogComps[curTyp]
	local point = HouseMainRoomModel.instance:getBackLogTypNum(curTyp)

	if point > 0 then
		local roomList = LivingFacilitiesZoneModel.instance:getSpRoomsWithoutMember()

		curComps.txt.text = string.format("x%s", #roomList)

		for _, mo in ipairs(roomList) do
			self:_createRoomSign(mo:getId(), HouseMainEnum.SignMark.SpLivingRoom, rootTyp)
		end
	end

	goutil.setActive(curComps.go, point > 0)
end

function M:_updateFailReportShow()
	local rootTyp = 2
	local totalFailReportCount = 0
	local roomIdsLst = HouseMainRoomModel.instance:getRoomIdsLst(HouseEnum.RoomType.Shelter)
	local roomWithFailReport

	for index, roomId in ipairs(roomIdsLst or {}) do
		self:_hideRoomSign(roomId)

		local failReport = ContainmentReportModel.instance:getUnReadFailReportCount(roomId)

		totalFailReportCount = totalFailReportCount + failReport

		if failReport > 0 then
			roomWithFailReport = roomWithFailReport or {}
			roomWithFailReport[roomId] = failReport

			self:_createRoomSign(roomId, HouseMainEnum.SignMark.HoldReportFail, rootTyp)
		end
	end

	local comps = self._backLogComps[HouseMainEnum.BackLogTyp.failReportNum]
	local show = totalFailReportCount > 0

	if show then
		comps.txt.text = string.format("x%d", totalFailReportCount)
	end

	goutil.setActive(comps.go, show)
end

function M:_createRoomSign(roomId, signMark, rootTyp)
	if not self._signGroup then
		self._signGroup = {}
	end

	if not self._signGroup[roomId] then
		self._signGroup[roomId] = {}
	end

	local root = self:getSignRoot(roomId, rootTyp)
	local obj = self._signGroup[roomId][signMark]

	if obj == nil then
		obj = goutil.findChild(root, HouseMainEnum.SignMarkObjName[signMark]).gameObject
	end

	if obj then
		self._signGroup[roomId][signMark] = obj

		goutil.setActive(obj.gameObject, true)
		goutil.setActive(root, true)
	end
end

function M:_hideRoomSign(roomId)
	local root = self:getSignRoot(roomId)
	local tr = root.transform

	for i = 0, tr.childCount - 1 do
		goutil.setActive(tr:GetChild(i).gameObject, false)
	end
end

function M:getSignRoot(cfgRoomId, rootTyp)
	return goutil.findChild(self._goRoomRoot, string.format("room_%d/signPos/room_distribution_sign", cfgRoomId)).gameObject
end

function M:setRoomCanUseMark(cfgRoomId, canUse)
	local itemGo = self:_getRoomOpenMarkItem(cfgRoomId, 4)

	if itemGo then
		goutil.setActive(itemGo, not canUse)
	end
end

function M:_getRoomOpenMarkItem(cfgRoomId, typ)
	return nil
end

return M
