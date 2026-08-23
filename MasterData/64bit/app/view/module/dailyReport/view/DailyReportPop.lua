local DailyReportConst = require("app.view.module.dailyReport.const.DailyReportConst")
local var_0_1 = g.core.model.User.dailyReportData
local DailyReportPop = class("DailyReportPop", require("app.fairyGUI.dailyReport.UI_DailyReportPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/dailyReport/dailyReport",
		resName = "DailyReportPop",
		pkgName = "dailyReport"
	}, ...)
end)

function DailyReportPop:ctor(arg_2_1)
	if arg_2_1 and arg_2_1.endcall then
		self._closeCallBack = arg_2_1.endcall
	end

	self._isClose = false

	self:showAtCenter()
	self:setSize(display.width, display.height)
	self.m_touchPanel:setSize(display.width, display.height)
	self.m_touchPanel:addClickListener(handler(self, self._onClickClose))
	self.m_ignoreBtn:addClickListener(handler(self, self._onSelectedNoPop))
	self.m_oneKeyBtn:addClickListener(handler(self, self._onOneKeyBtnClick))

	self._oneKeyAwardNum = 0
	self._rcvAwardNum = 0
	self._mergeOneKeyAward = {}

	self.m_closeBtn:setClickFunc(handler(self, self._onClickClose))
	self:_initColumn()
	self.m_typeController:setSelectedIndex(2)
	self.m_ignoreBtn:setSelected(not var_0_1:isToDayPop())
end

function DailyReportPop:onLoad()
	self.m_shareBtn:setCallback(handler(self, self._onShareClick))
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DAILY_REPORT_GETAWARD, self._onDailyReportGetAward, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_DAILY_REPORT_GETINFO, self._onDailyReportGetInfo, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_USER_SNAP_SHOT, handler(self, self._onS2CGetUserSnapShot), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_GET_GUILD_SNAP_SHOT, handler(self, self._onS2CGetUserSnapShot), self)
	g.core.network.GameNetProxy:send_C2S_Daily_Report_GetInfo({})
	self:newSchedule(handler(self, self._onSchedule), 1)
	g.core.sound.SoundManager:playSound(g.core.const.ConstMgr.SoundConst.Sound.DAILY_REPORT)
end

function DailyReportPop:_initColumn()
	for iter_4_0 = DailyReportConst.DAILY_COLUMNS[1], DailyReportConst.DAILY_COLUMNS[2] do
		self["m_report" .. iter_4_0]:setColumn(iter_4_0)
	end

	for iter_4_1 = DailyReportConst.WEEK_COLUMNS[1], DailyReportConst.WEEK_COLUMNS[2] do
		self["m_report" .. iter_4_1]:setColumn(iter_4_1)
	end
end

function DailyReportPop:_onShareClick()
	if g.core.guide.GuideProxy:isGuideRunning() then
		self.m_shareBtn:setVisible(false)

		return
	end

	self.m_shareBtn:setVisible(false)
	self.m_closeBtn:setVisible(false)
	self.m_ignoreBtn:setVisible(false)
	self:showCutView(true)

	local var_5_0 = cc.utils:captureNode(self)

	var_5_0:saveToFile(g.core.model.User.ShareData:getShotPath())
	var_5_0:release()
	self.m_closeBtn:setVisible(true)
	self.m_shareBtn:setVisible(true)
	self.m_ignoreBtn:setVisible(true)
	self:showCutView(false)
	g.core.module.ModuleManager:pushModule(g.view.entrance.SHARE_LAYER, {
		shareType = g.core.const.ConstMgr.ShareConst.SHARE_TYPE.TYPE_ID_15
	})
end

function DailyReportPop:_onDailyReportGetInfo(arg_6_1, arg_6_2, arg_6_3)
	self:_updateReport()
end

function DailyReportPop:_onS2CGetUserSnapShot()
	if var_0_1:getReportType() == DailyReportConst.REPORT_TYPE.WEEK then
		for iter_7_0 = DailyReportConst.WEEK_COLUMNS[1], DailyReportConst.WEEK_COLUMNS[2] do
			self["m_report" .. iter_7_0]:updatePartBySnapShot()
		end
	else
		for iter_7_1 = DailyReportConst.DAILY_COLUMNS[1], DailyReportConst.DAILY_COLUMNS[2] do
			self["m_report" .. iter_7_1]:updatePartBySnapShot()
		end
	end
end

function DailyReportPop:_onDailyReportGetAward(arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = arg_8_3.award or {}

	local function var_8_1()
		g.core.module.ModuleManager:awardSummary(var_8_0)
	end

	if self._oneKeyAwardNum > 0 then
		var_8_1 = nil
		self._rcvAwardNum = self._rcvAwardNum + 1

		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			table.insert(self._mergeOneKeyAward, iter_8_1)
		end

		if self._rcvAwardNum >= self._oneKeyAwardNum then
			self._mergeOneKeyAward = g.core.utils.Tools.mergeAwardList(self._mergeOneKeyAward)

			g.core.module.ModuleManager:awardSummary(self._mergeOneKeyAward)

			self._mergeOneKeyAward = {}
			self._oneKeyAwardNum = 0
			self._rcvAwardNum = 0
		end
	end

	self["m_report" .. arg_8_3.column_id]:updatePart(var_0_1:getReportDataByColumn(arg_8_3.column_id), true, var_8_1)
end

function DailyReportPop:_onSchedule()
	local var_10_0 = var_0_1:getReportType()

	if var_10_0 >= 0 then
		if var_10_0 == DailyReportConst.REPORT_TYPE.WEEK then
			for iter_10_0 = DailyReportConst.WEEK_COLUMNS[1], DailyReportConst.WEEK_COLUMNS[2] do
				self["m_report" .. iter_10_0]:onScheduleEvent()
			end
		else
			for iter_10_1 = DailyReportConst.DAILY_COLUMNS[1], DailyReportConst.DAILY_COLUMNS[2] do
				self["m_report" .. iter_10_1]:onScheduleEvent()
			end
		end
	end
end

function DailyReportPop:_updateReport()
	local var_11_0 = var_0_1:getReportType() == DailyReportConst.REPORT_TYPE.WEEK

	if var_11_0 then
		local var_11_1 = g.core.common.ServerTime:getTime()
		local var_11_2 = g.core.common.ServerTime:getDateObject(var_11_1 - 86400)
		local var_11_3 = g.core.common.ServerTime:getDateObject(var_11_1 - 604800)

		self.m_curMonthTxt2:setText((g.core.utils.Number.getFormatNum(2, var_11_2.month)))
		self.m_curDayTxt2:setText((g.core.utils.Number.getFormatNum(2, var_11_2.day)))
		self.m_curMonthTxt1:setText((g.core.utils.Number.getFormatNum(2, var_11_3.month)))
		self.m_curDayTxt1:setText((g.core.utils.Number.getFormatNum(2, var_11_3.day)))

		for iter_11_0 = DailyReportConst.WEEK_COLUMNS[1], DailyReportConst.WEEK_COLUMNS[2] do
			self["m_report" .. iter_11_0]:updatePart((var_0_1:getReportDataByColumn(iter_11_0)))
		end
	else
		local var_11_4 = g.core.common.ServerTime:getTime()
		local var_11_5 = g.core.common.ServerTime:getDateObject(var_11_4)
		local var_11_6 = g.core.utils.Number.getFormatNum(2, var_11_5.day)

		self.m_curMonthTxt:setText((g.core.utils.Number.getFormatNum(2, var_11_5.month)))
		self.m_curDayTxt:setText(var_11_6)

		local var_11_7 = g.core.common.ServerTime:getWeekDayByTimeTamp(var_11_4)

		if var_11_7 == 0 then
			var_11_7 = 7
		end

		self.m_dayTxt:setText(g.core.lang:get(206000 + var_11_7))
		self.m_curDayTxt:setText(var_11_6)

		for iter_11_1 = DailyReportConst.DAILY_COLUMNS[1], DailyReportConst.DAILY_COLUMNS[2] do
			self["m_report" .. iter_11_1]:updatePart(var_0_1:getReportDataByColumn(iter_11_1))
		end
	end

	self.m_typeController:setSelectedIndex(var_11_0 and 1 or 0)
end

function DailyReportPop:showCutView(arg_12_1)
	if var_0_1:getReportType() == DailyReportConst.REPORT_TYPE.WEEK then
		for iter_12_0 = DailyReportConst.WEEK_COLUMNS[1], DailyReportConst.WEEK_COLUMNS[2] do
			if arg_12_1 then
				self["m_report" .. iter_12_0]:showCutPage()
			else
				self["m_report" .. iter_12_0]:hideCutPage()
			end
		end
	else
		for iter_12_1 = DailyReportConst.DAILY_COLUMNS[1], DailyReportConst.DAILY_COLUMNS[2] do
			if arg_12_1 then
				self["m_report" .. iter_12_1]:showCutPage()
			else
				self["m_report" .. iter_12_1]:hideCutPage()
			end
		end
	end
end

function DailyReportPop:_onOneKeyBtnClick()
	if not self.m_ignoreBtn:isSelected() then
		self.m_ignoreBtn:setSelected(true)
		self:_onSelectedNoPop()
	end

	local var_13_0 = var_0_1:getCanLikeColumnIdListByType((self.m_typeController:getSelectedIndex()))

	self._oneKeyAwardNum = #var_13_0

	if self._oneKeyAwardNum == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(206009))

		return
	end

	for iter_13_0 = 1, #var_13_0 do
		self["m_report" .. var_13_0[iter_13_0]]:onOneKeyBtnClick()
	end
end

function DailyReportPop:_onSelectedNoPop()
	var_0_1:setTodayNotPop((self.m_ignoreBtn:isSelected()))
end

function DailyReportPop:_onClickClose()
	if not self._isClose then
		self:newScheduleOnce(handler(self, function()
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			self:homeLayerAutoPopup()

			self._isClose = true
		end), 0.3)
	end
end

function DailyReportPop:homeLayerAutoPopup()
	if self._closeCallBack then
		self._closeCallBack()

		self._closeCallBack = nil
	end
end

function DailyReportPop:onUnload()
	self:cancelAllSchedule()
end

return DailyReportPop
