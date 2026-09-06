-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/anniversarykoi/view/AnniversaryKoirecordView.lua

module("logic.extensions.anniversarykoi.view.AnniversaryKoirecordView", package.seeall)

local AnniversaryKoirecordView = class("AnniversaryKoirecordView", ViewComponent)

function AnniversaryKoirecordView:ctor()
	AnniversaryKoirecordView.super.ctor(self)
end

function AnniversaryKoirecordView:unbindEvents()
	AnniversaryKoirecordView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)

	for i = 1, #self._btnRecords do
		GameUtil.rmClickHandler(self._btnRecords[i], self._onClickRecord, self, i)
	end
end

function AnniversaryKoirecordView:bindEvents()
	AnniversaryKoirecordView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)

	for i = 1, #self._btnRecords do
		GameUtil.addClickHandler(self._btnRecords[i], GameUtil.handler(self._onClickRecord, self, i))
	end
end

function AnniversaryKoirecordView:buildUI()
	AnniversaryKoirecordView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableviewGo = self:getGo("tableview")
	self._scrollRect = self:getScrollRect("tableview")
	self._cell = self:getGo("cell")
	self._empty = self:getGo("empty")
	self._tableView = ScrollerList.create(self._tableviewGo, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnRecords = {}

	for i = 1, 3 do
		self._btnRecords[i] = self:getGo("btnRecord_" .. i)
	end
end

function AnniversaryKoirecordView:onExit()
	AnniversaryKoirecordView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnniversaryKoiGetRecordsRes, self._refreshUI, self)
	self._tableView:dispose()
end

function AnniversaryKoirecordView:onEnter()
	AnniversaryKoirecordView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.AnniversaryKoi)

	AnniversaryKoiController.instance:sendPM_AnniversaryKoiGetRecordsReq(self._activityId)
	GlobalDispatcher:addListener(GlobalNotify.AnniversaryKoiGetRecordsRes, self._refreshUI, self)

	self._curSelectId = 1
end

function AnniversaryKoirecordView:_refreshUI()
	for i = 1, #self._btnRecords do
		local change = self._btnRecords[i]:GetComponent(typeof(UIChangeGroup))

		change:SetState(self._curSelectId == i and 1 or 0)
	end

	local data = self:_recordData() or {}

	table.sort(data, function(a, b)
		return checknumber(b.timeStamp) < checknumber(a.timeStamp)
	end)
	GameUtil.SetActive(self._tableviewGo, #data > 0)
	GameUtil.SetActive(self._empty, #data <= 0)

	if #data <= 0 then
		return
	end

	self._poolName = self:_getPoolName()

	self._tableView:reloadData(data)
end

function AnniversaryKoirecordView:_getPoolName()
	if self._curSelectId == 1 then
		return "天选锦鲤奖"
	elseif self._curSelectId == 2 then
		return "免单锦鲤奖"
	else
		return "肝帝锦鲤奖"
	end
end

function AnniversaryKoirecordView:_recordData()
	local starTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.AnniversaryKoi, self._activityId)
	local nowTimeStamp = ServerTime.now()
	local nowTimeDate = GameUtil.time2date(nowTimeStamp)
	local oneDayStamp = 86400
	local todayTimeStamp = GameUtil.date2time(nowTimeDate.year, nowTimeDate.month, nowTimeDate.day, 20, 0, 0)
	local nowTimeStamp = todayTimeStamp <= nowTimeStamp and todayTimeStamp or todayTimeStamp - oneDayStamp
	local newData = {}

	for i = 1, 5 do
		local day = i - 1
		local timeStamp = nowTimeStamp - day * oneDayStamp
		local isInTime = GameUtil.getTimePeriodBySecWithOther(timeStamp, starTime, endTime) == GameUtil.inTimePeriod

		if isInTime then
			local data = self:_getOneRecord(timeStamp * 1000)

			if not data then
				local noRecord = {}

				noRecord.timeStamp = timeStamp * 1000

				table.insert(newData, noRecord)
			else
				table.insert(newData, data)
			end
		end
	end

	return newData
end

function AnniversaryKoirecordView:_getOneRecord(timeStamp)
	local record = AnniversaryKoiModel.instance:getRecord(self._curSelectId) or {}

	for _, data in pairs(record) do
		local date = GameUtil.time2date(data.timeStamp / 1000)

		if checknumber(data.timeStamp) == timeStamp then
			return data
		end
	end
end

function AnniversaryKoirecordView:_getLotteryResult(prizeType)
	if prizeType == 1 then
		return "并抽中了<color=#fffdd2>大奖</color>！"
	elseif prizeType == 2 then
		return "并抽中了<color=#fffdd2>特等奖</color>！"
	else
		return "但<color=#fffdd2>未抽中奖励</color>，再接再厉！"
	end
end

function AnniversaryKoirecordView:_updateCell(view, cell, data)
	local txtTime = goutil.findChildTextComponent(cell, "txtTime")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local time = GameUtil.time2date(data.timeStamp / 1000)

	txtTime.text = string.format("%04d年%02d月%02d日", time.year, time.month, time.day)

	local name = self._poolName

	if data.prizeType then
		local resultDesc = self:_getLotteryResult(data.prizeType)

		txtDesc.text = string.format("你成功参与%s%s", name, resultDesc)
	else
		txtDesc.text = string.format("很遗憾，本日您<color=#fffdd2>未参加</color>%s抽奖。", name)
	end
end

function AnniversaryKoirecordView:_clearCell(cell)
	return
end

function AnniversaryKoirecordView:_onClickRecord(id)
	self._curSelectId = id

	self:_refreshUI()

	self._scrollRect.scrollRect.verticalNormalizedPosition = 1
end

return AnniversaryKoirecordView
