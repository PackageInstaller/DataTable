local var_0_0 = g.core.const.ConstMgr.NewSlgConst.REPORT
local NewSlgBattleReportPop = class("NewSlgBattleReportPop", function()
	return fgui.GComponent:create({
		resName = "NewSlgBattleReportPop",
		pkgPath = "ui/newSlg/newSlg",
		pkgName = "newSlg"
	}, ...)
end, require("app.fairyGUI.newSlg.UI_NewSlgBattleReportPop"))

function NewSlgBattleReportPop:ctor()
	self._allianceReportContent = {}
	self._userReportContent = {}
	self._selectTab = var_0_0.TAB_TYPE.USER
	self._selType = var_0_0.TYPE.NEW_SLG_REPORT_TYPE_ALL
	self._showReports = {}
	self._selectIdMap = {}
	self._showReportIdxList = {}
	self._oldReportTime = g.core.model.User.newSlgData:loadCache("lsat_Battle_report_time")

	self:_initComp()
	self:showAtCenter()
	self.m_enterTransition:play()
end

function NewSlgBattleReportPop:_initComp()
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(var_0_0.REPORT_TYPE) do
		var_3_0[#var_3_0 + 1] = g.core.lang:get(iter_3_1)
	end

	self.m_chooseComp:updateChooseComp(var_3_0)
	self.m_chooseComp:setSelectHandler(handler(self, self._onComboBoxChanged))
	self.m_chooseComp:setListShowHandler(handler(self, self._onChooseCompVisibleChanged))
	self.m_chooseCompHideTouch:addClickListener(handler(self, self._hideChooseComp))
	self.m_reportList:setVirtual(self)
	self.m_reportList:setItemRenderer(handler(self, self._renderReportItem))
	self.m_reportList:setItemProvider(handler(self, self._onReportItemProvider))
	self.m_closeBtn:addClickListener(handler(self, self.onCancelCallback))
	self.m_showViewController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onShowViewChanged))
	self.m_arrowBtn:addClickListener(handler(self, self._onClickArrowBtn))
end

function NewSlgBattleReportPop:_onClickArrowBtn()
	self.m_reportList:scrollToView(0)
end

function NewSlgBattleReportPop:_onShowViewChanged()
	local var_5_0 = self.m_showViewController:getSelectedIndex() + 1

	if self._selectTab == var_5_0 then
		return
	end

	self._selectTab = var_5_0

	if self._selectTab == var_0_0.TAB_TYPE.ALLIANCE then
		self._selectTab = var_0_0.TYPE.NEW_SLG_REPORT_TYPE_CITY
		self._selTypeKey = "NEW_SLG_REPORT_TYPE_CITY"
	else
		self._selectTab = var_0_0.TYPE.NEW_SLG_REPORT_TYPE_ALL
	end

	self.m_reportList:scrollToView(0)
	self:updateReportView()
end

function NewSlgBattleReportPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETREPORTLIST, self._onRecReport, self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETREPORT, self.updateReportView, self)
	g.core.network.GameNetProxy:send_C2S_NewSlg_GetReportList({
		single_num = 0
	})
end

function NewSlgBattleReportPop:_onRecReport(arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = g.core.model.User.newSlgData:getNewBattleReportList()

	if #var_7_0 > 0 then
		self._lastReportTime = var_7_0[1].start_tm
	end

	self._allianceReportContent = {}
	self._userReportContent = {}

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		if iter_7_1.report_type == var_0_0.SVR_TYPE.NEW_SLG_REPORT_TYPE_CITY then
			table.insert(self._allianceReportContent, iter_7_1)
		end

		if iter_7_1.is_join then
			table.insert(self._userReportContent, iter_7_1)
		end
	end

	self:updateReportView()
end

function NewSlgBattleReportPop:updateReportView()
	self:_updateReport()
	self:_updateReportIdxList()

	if #self._showReportIdxList > 0 then
		self.m_reportList:setNumItems(#self._showReportIdxList)
		self.m_emptyController:setSelectedIndex(1)
	else
		self.m_emptyController:setSelectedIndex(0)
	end
end

function NewSlgBattleReportPop:_updateReport()
	self._showReports = {}

	if self._selectTab == var_0_0.TAB_TYPE.USER then
		if self._selType == var_0_0.TYPE.NEW_SLG_REPORT_TYPE_ALL then
			self._showReports = self._userReportContent
		else
			local var_9_0 = {}

			for iter_9_0, iter_9_1 in ipairs(self._userReportContent) do
				if iter_9_1.report_type == var_0_0.SVR_TYPE[self._selTypeKey] then
					table.insert(var_9_0, iter_9_1)
				end
			end

			self._showReports = var_9_0
		end
	elseif self._selType == var_0_0.TYPE.NEW_SLG_REPORT_TYPE_ALL then
		self._showReports = self._allianceReportContent
	else
		local var_9_1 = {}

		for iter_9_2, iter_9_3 in ipairs(self._allianceReportContent) do
			if iter_9_3.report_type == var_0_0.SVR_TYPE[self._selTypeKey] then
				table.insert(var_9_1, iter_9_3)
			end
		end

		self._showReports = var_9_1
	end
end

function NewSlgBattleReportPop:_updateReportIdxList()
	self._showReportIdxList = {}

	for iter_10_0, iter_10_1 in ipairs(self._showReports) do
		self._showReportIdxList[#self._showReportIdxList + 1] = tostring(iter_10_0)

		if self._selectIdMap[iter_10_1.report_id] then
			local var_10_0 = 1

			for iter_10_2, iter_10_3 in ipairs(iter_10_1.detail.battles) do
				self._showReportIdxList[#self._showReportIdxList + 1] = table.concat({
					iter_10_0,
					var_10_0
				}, "_")
				var_10_0 = var_10_0 + 1
			end

			for iter_10_4, iter_10_5 in ipairs(iter_10_1.detail.battles2 or {}) do
				self._showReportIdxList[#self._showReportIdxList + 1] = table.concat({
					iter_10_0,
					var_10_0
				}, "_")
				var_10_0 = var_10_0 + 1
			end
		end
	end
end

function NewSlgBattleReportPop:_renderReportItem(arg_11_1, arg_11_2)
	local var_11_0 = string.split(self._showReportIdxList[arg_11_1 + 1], "_")
	local var_11_1 = self._showReports[tonumber(var_11_0[1])]

	if #var_11_0 > 1 then
		arg_11_2:updateReportDetailInfo(var_11_1, tonumber(var_11_0[2]))
	else
		arg_11_2:updateReportCell(var_11_1, var_11_1.isNew, self._selectIdMap[var_11_1.report_id])
	end
end

function NewSlgBattleReportPop:_onReportItemProvider(arg_12_1)
	if string.find(self._showReportIdxList[arg_12_1 + 1] or "", "_") then
		return "ui://newSlg/NewSlgBattleReportDetailCell"
	else
		return "ui://newSlg/NewSlgBattleReportCell"
	end
end

function NewSlgBattleReportPop:_onComboBoxChanged(arg_13_1)
	self._selType = arg_13_1

	for iter_13_0, iter_13_1 in pairs(var_0_0.TYPE) do
		if iter_13_1 == arg_13_1 then
			self._selTypeKey = iter_13_0

			break
		end
	end

	self:updateReportView()
end

function NewSlgBattleReportPop:onUnload()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_NEW_SLG_REPORT_VIEW_CLOSED)
end

function NewSlgBattleReportPop:receiveCompEvent(arg_15_1, arg_15_2)
	if arg_15_1 == "changeDetail" then
		self._selectIdMap[arg_15_2.id] = not self._selectIdMap[arg_15_2.id]

		if self._selectIdMap[arg_15_2.id] then
			if g.core.model.User.newSlgData:getBattleReportById(arg_15_2.id).detail then
				self:updateReportView()
			else
				g.core.network.GameNetProxy:send_C2S_NewSlg_GetReport({
					report_id = arg_15_2.id
				})
			end
		else
			self:updateReportView()
		end

		return true
	end
end

function NewSlgBattleReportPop:_closeReportPop()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgBattleReportPop:onCancelCallback()
	self.m_backTransition:play(handler(self, self._closeReportPop))
end

function NewSlgBattleReportPop:_onChooseCompVisibleChanged(arg_18_1)
	self.m_chooseCompHideTouch:setVisible(arg_18_1)
end

function NewSlgBattleReportPop:_hideChooseComp()
	self.m_chooseComp:setShowListEnable(false)
end

return NewSlgBattleReportPop
