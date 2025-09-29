-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airtightroom/view/AirtightRoomTimeShowTips.lua

module("logic.extensions.airtightroom.view.AirtightRoomTimeShowTips", package.seeall)

local M = class("AirtightRoomTimeShowTips", ViewComponent)

function M:buildUI()
	self._btnHelp = self:getBtn("secret_time_show_tips_-1462001710")
	self._btnClose = self:getBtn("secret_time_show_tips_-404674805")
	self._btnOpen = self:getBtn("secret_time_show_tips_-549906236")
	self._btnTime = self:getBtn("secret_time_show_tips_-1930490359")
	self._goTimeRootNormal = self:getGo("secret_time_show_tips_-671326207")
	self._txtTimeNormal = self:getText("secret_time_show_tips_-1439750891")
	self._goTimeRootAirtight = self:getGo("secret_time_show_tips_-1378056991")
	self._txtTimeAirtight = self:getText("secret_time_show_tips_-327666229")
	self._txtRealTime = self:getText("secret_time_show_tips_-1513947666")
	self._txtAirtightEndTime = self:getText("secret_time_show_tips_-1484527169")

	local rootWeekDay = self:getGo("secret_time_show_tips_-1986992676")
	local rootDate = self:getGo("secret_time_show_tips_-644676110")
	local rootDayAM = self:getGo("secret_time_show_tips_-610024260")
	local rootDayPM = self:getGo("secret_time_show_tips_-117542505")

	for i = 1, 7 do
		local txtWeekDay = goutil.findChildTextComponent(rootWeekDay, string.format("day%s", i))
		local txtDate = goutil.findChildTextComponent(rootDate, string.format("day%s", i))
		local am = goutil.findChild(rootDayAM, string.format("day%s", i))
		local pm = goutil.findChild(rootDayPM, string.format("day%s", i))

		self:_buildDayMark(i, txtWeekDay, txtDate, am, pm)
	end
end

function M:destroyUI()
	self:setEvent(false)

	self._btnHelp = nil
	self._btnClose = nil
	self._btnOpen = nil
	self._btnTime = nil
	self._goTimeRootNormal = nil
	self._txtTimeNormal = nil
	self._goTimeRootAirtight = nil
	self._txtTimeAirtight = nil
	self._txtRealTime = nil
	self._txtAirtightEndTime = nil
	self._compsWeekDay = nil
end

function M:bindEvents()
	self._btnHelp:AddClickListener(self._onClickHelp, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnOpen:AddClickListener(self._onClickOpen, self)
	self._btnTime:AddClickListener(self._onClickTime, self)
end

function M:unbindEvents()
	self._btnHelp:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnOpen:RemoveClickListener()
	self._btnTime:RemoveClickListener()
end

function M:onEnter()
	self._isAirtightTime = nil

	self:_forceRefreshAll()
	self:setEvent(true)

	local isNormalOpen = not self._viewPresentor:getIsBackOpen()

	MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), 1, true, isNormalOpen)
end

function M:onExit(reasonTyp)
	self:setEvent(false)

	self._cacheHour = nil

	local isNormalClose = reasonTyp ~= WindowType.WindowCloseReasonType.QuickCloseType

	MainScenePerformUtil.viewCamCtrl(self._viewPresentor:getViewName(), 1, false, isNormalClose)
end

function M:setEvent(add)
	if add then
		Scheduler.addListener(1, self._updateAirtightTime, self, true)
		GlobalDispatcher:addEventListener(EventType.ON_AIRTIGHT_EXIT_TIME_CHANGE, self._handleAirtightExitTimeChange, self)
	else
		Scheduler.removeListener(self._updateAirtightTime, self)
		GlobalDispatcher:removeEventListener(EventType.ON_AIRTIGHT_EXIT_TIME_CHANGE, self._handleAirtightExitTimeChange, self)
	end
end

function M:_handleAirtightExitTimeChange(e)
	self:_forceRefreshAll()
end

function M:_onClickHelp()
	if Astral.OSDef.isEditor then
		self:_printWeekStatus()
	end

	ViewMgr.instance:open(ViewName.ImageGuide, {
		CommEnum.ManualKey.AirtightTimeTips
	})
end

function M:_onClickClose()
	self:close()
end

function M:_onClickOpen()
	if self._isAirtightTime then
		FloatWordMgr.instance:show(lang("tip_airtighttime_already"))

		return
	end

	local itemId = AirtightRoomUtil.getItemId()

	if ItemModel.instance:getItemCountByItemId(itemId) > 0 then
		ToolTipsMgr.showAirtightRoomTimeOpenTips()
	else
		FloatWordMgr.instance:show(lang("tip_goods_not_enough"))
	end
end

function M:_onClickTime()
	printWarn("click time")
end

function M:_forceRefreshAll()
	self._cacheHour = nil

	self:_updateAirtightTime()
end

function M:refreshDetail()
	local nowTime = AirtightRoomModel.instance:getServerTime()
	local isAm = tonumber(os.date("%H", nowTime)) < 12
	local nowWeekDay = AirtightRoomUtil.getNowWeekDay(nowTime)

	for i = 1, 7 do
		local showWeekDay = i - 1 + nowWeekDay
		local offsetWeek = math.floor(showWeekDay / 8)

		showWeekDay = showWeekDay % 7
		showWeekDay = showWeekDay == 0 and 7 or showWeekDay

		local markWeekDay = nowWeekDay == showWeekDay and offsetWeek == 0
		local comps = self._compsWeekDay[i]
		local date = AirtightRoomUtil.getWeekDayDate(nowTime, showWeekDay, offsetWeek)

		comps.txtDate.text = string.format("%d/%d", date.month, date.day)
		comps.txtWeekDay.text = lang(string.format("tip_weekday_%s", showWeekDay))

		local inAirtightTime = self:_isTimeRangeAirtight(showWeekDay, true, offsetWeek)

		goutil.setActive(comps.goNowAM, isAm and markWeekDay and not inAirtightTime)
		goutil.setActive(comps.goAirtightMarkAM, inAirtightTime)
		goutil.setActive(comps.goAirtightActiveAM, isAm and markWeekDay and inAirtightTime)

		inAirtightTime = self:_isTimeRangeAirtight(showWeekDay, false, offsetWeek)

		goutil.setActive(comps.goNowPM, not isAm and markWeekDay and not inAirtightTime)
		goutil.setActive(comps.goAirtightMarkPM, inAirtightTime)
		goutil.setActive(comps.goAirtightActivePM, not isAm and markWeekDay and inAirtightTime)
	end
end

function M:_updateAirtightTime()
	local nowTime = AirtightRoomModel.instance:getServerTime()
	local inAirtightTime, inTimeByItem, hour, minute, second, airtightEndTS = AirtightRoomController.instance:getAirtightTimeInfo(nowTime)
	local txtTime = inAirtightTime and self._txtTimeAirtight or self._txtTimeNormal

	txtTime.text = string.format("%02d:%02d:%02d", hour, minute, second)
	self._txtRealTime.text = os.date("%H:%M", nowTime)

	if not self._cacheHour or self._cacheHour ~= hour or not self._isAirtightTime or self._isAirtightTime ~= inAirtightTime then
		self._cacheHour = hour

		self:refreshDetail()

		if inAirtightTime then
			self._txtAirtightEndTime.text = os.date("%H:%M", airtightEndTS)
		end

		goutil.setActive(self._txtAirtightEndTime.gameObject, inAirtightTime)
		goutil.setActive(self._goTimeRootNormal, not inAirtightTime)
		goutil.setActive(self._goTimeRootAirtight, inAirtightTime)
		goutil.setActive(self._btnTime.gameObject, inAirtightTime)
		goutil.setActive(self._btnOpen.gameObject, false)
	end

	self._isAirtightTime = inAirtightTime
end

function M:_isTimeRangeAirtight(weekDay, isAM, weekOffset)
	weekOffset = weekOffset or 0

	local systemOpen = AirtightRoomUtil.isSystemOpen(false)
	local nowTime = AirtightRoomModel.instance:getServerTime()
	local startTime = AirtightRoomModel.instance:getAirtightStartTimeStamp()
	local stepSecond = 43200
	local stepRealSec = 86400
	local stepAirtightSec = 129600
	local mondayTS = AirtightRoomUtil.getWDayTimeStamp(nowTime, 1)

	mondayTS = mondayTS + weekOffset * 7 * stepRealSec

	local _ts1 = mondayTS + (weekDay - 1) * 86400
	local _ts2 = _ts1 + stepSecond
	local _ts3 = _ts2 + stepSecond
	local ts = isAM and _ts1 or _ts2
	local ts2 = isAM and _ts2 or _ts3
	local inAirtightTime = false
	local useRealTime = ts <= startTime

	if not systemOpen then
		useRealTime = true
	end

	if useRealTime then
		inAirtightTime = false
	else
		local _startTime = startTime
		local _stepSec = stepAirtightSec
		local hour, minute, second = AirtightRoomUtil.getOneDayTimeStruct((ts - _startTime) % _stepSec)

		inAirtightTime = hour >= 24
		hour, minute, second = AirtightRoomUtil.getOneDayTimeStruct((ts2 - _startTime) % _stepSec)

		if inAirtightTime and hour == 0 then
			hour = 36
		end
	end

	return inAirtightTime
end

function M:_buildDayMark(wDay, txtWeekDay, txtDate, amRoot, pmRoot)
	if not self._compsWeekDay then
		self._compsWeekDay = {}
	end

	local comps = {}

	comps.txtWeekDay = txtWeekDay
	comps.txtDate = txtDate
	comps.goNowAM = goutil.findChild(amRoot, "now")
	comps.goAirtightMarkAM = goutil.findChild(amRoot, "nonTime")
	comps.goAirtightActiveAM = goutil.findChild(amRoot, "isTime")
	comps.goNowPM = goutil.findChild(pmRoot, "now")
	comps.goAirtightMarkPM = goutil.findChild(pmRoot, "nonTime")
	comps.goAirtightActivePM = goutil.findChild(pmRoot, "isTime")
	self._compsWeekDay[wDay] = comps
end

function M:_printWeekStatus()
	local systemOpen = AirtightRoomUtil.isSystemOpen(false)
	local nowTime = AirtightRoomModel.instance:getServerTime()
	local startTime = AirtightRoomModel.instance:getAirtightStartTimeStamp()
	local stepSecond = 43200
	local stepRealSec = 86400
	local stepAirtightSec = 129600
	local nowWeekDay = AirtightRoomUtil.getNowWeekDay(nowTime)
	local mondayTS = AirtightRoomUtil.getWDayTimeStamp(nowTime, 1)
	local mondayTSNext = mondayTS + 604800
	local airtightExitTime = AirtightRoomModel.instance:getExitTime()
	local strPrint = string.format("<color=#45e6f9>密室时间详情打印：</color>\n现在时间 [%s] [%s] 周[%s]", nowTime, TimeUtil.instance:stampToDateStr(nowTime), nowWeekDay)

	strPrint = string.format("%s\n------------------------------------------------------------", strPrint)
	strPrint = string.format("%s\n本周一时间 [%s] [%s]，下周一 [%s] [%s]", strPrint, mondayTS, TimeUtil.instance:stampToDateStr(mondayTS), mondayTSNext, TimeUtil.instance:stampToDateStr(mondayTSNext))
	strPrint = string.format("%s\n吃道具结束时间 [%s] [%s]", strPrint, airtightExitTime, TimeUtil.instance:stampToDateStr(airtightExitTime))

	local function _getTimeStr(ts, ts2)
		local str
		local inAirtightTime = false
		local useRealTime = ts <= startTime

		if not systemOpen then
			useRealTime = true
		end

		if useRealTime then
			inAirtightTime = false

			local info = os.date("*t", ts)

			str = string.format("%02d:%02d", info.hour, info.min)
			info = os.date("*t", ts2)
			str = string.format("%s-%02d:%02d", str, info.hour, info.min)
		else
			local _startTime = startTime
			local _stepSec = stepAirtightSec
			local hour, minute, second = AirtightRoomUtil.getOneDayTimeStruct((ts - _startTime) % _stepSec)

			inAirtightTime = hour >= 24
			str = string.format("%02d:%02d", hour, minute)
			hour, minute, second = AirtightRoomUtil.getOneDayTimeStruct((ts2 - _startTime) % _stepSec)

			if inAirtightTime and hour == 0 then
				hour = 36
			end

			str = string.format("%s-%02d:%02d", str, hour, minute)
		end

		return inAirtightTime, str
	end

	for i = 1, 14 do
		local weekDay = i % 7

		weekDay = weekDay == 0 and 7 or weekDay

		local _offsetWeek = math.floor(i / 8)
		local _mondayTS = i <= 7 and mondayTS or mondayTSNext
		local _ts1 = _mondayTS + (weekDay - 1) * 86400
		local _ts2 = _ts1 + stepSecond
		local _ts3 = _ts2 + stepSecond
		local _inTime1, str1 = _getTimeStr(_ts1, _ts2)

		if _inTime1 then
			str1 = string.format("<color=#FF4343>%s</color>", str1)
		end

		local _inTime2, str2 = _getTimeStr(_ts2, _ts3)

		if _inTime2 then
			str2 = string.format("<color=#FF4343>%s</color>", str2)
		end

		if weekDay == 1 then
			strPrint = string.format("%s\n------------------------------------------------------------", strPrint)
		end

		local weekDate = AirtightRoomUtil.getWeekDayDate(nowTime, weekDay, _offsetWeek)
		local _weekDayMarkColor = nowWeekDay == weekDay and _offsetWeek == 0 and "#45e6f9" or "#E4E4E4"

		strPrint = string.format("%s\n<color=%s>周%s--%s月%s----------------------%s\n[00:00-12:00] -> [%s]\n[12:00-24:00] -> [%s]</color>", strPrint, _weekDayMarkColor, weekDay, weekDate.month, weekDate.day, _ts1, str1, str2)
	end

	printWarn(strPrint)
end

return M
