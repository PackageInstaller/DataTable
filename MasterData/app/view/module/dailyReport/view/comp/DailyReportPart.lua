local DailyReportConst = require("app.view.module.dailyReport.const.DailyReportConst")
local var_0_1 = g.core.model.User.dailyReportData
local DailyReportPart = class("DailyReportPart", require("app.fairyGUI.dailyReport.UI_DailyReportPart"))

function DailyReportPart:ctor()
	self._panelNum = 0
	self._column = 0
	self._data = nil
	self._timeRunner = 0

	self.m_panelPage:setIniter()
	self.m_panelPage:setItemRenderer(handler(self, self._onPanelPageRenderer))
	self.m_panelPage:setItemProvider(handler(self, self._onItemProvider))
	self.m_panelPage:doFairyBatching(false)
	self.m_panelPage:getScrollPane():cancelDragging()
	self.m_likeBtn:addClickListener(handler(self, self._onLikeBtnClick))
end

function DailyReportPart:onLoad()
	self.m_panelPage:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_panelPage:addEventListener(fgui.UIEventType.TouchMove, handler(self, self._onTouchMove))
	self.m_panelPage:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self._onTouchEnd))
end

function DailyReportPart:setColumn(arg_3_1)
	self._column = arg_3_1
end

function DailyReportPart:updatePart(arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_1 then
		self.m_emptyController:setSelectedIndex(0)

		return
	end

	if arg_4_1 then
		self._panelNum = #arg_4_1 or 0
	end

	if self._panelNum == 0 then
		self.m_emptyController:setSelectedIndex(0)

		return
	else
		self.m_emptyController:setSelectedIndex(1)
	end

	self._data = arg_4_1

	for iter_4_0 = self.m_selectIndexController:getPageCount() + 1, self._panelNum do
		self.m_selectIndexController:addPage(iter_4_0, "tab_" .. iter_4_0)
	end

	self.m_panelPage:setNumItems(self._panelNum)

	if self._panelNum > 1 then
		self.m_pointPage:setNumItems(self._panelNum)
		self.m_pointPage:setSelectedIndex(0)
	else
		self.m_pointPage:setVisible(false)
	end

	if self._column and self._column ~= 0 then
		local var_4_0 = g.core.model.User.dailyReportData:getLikeData(self._column)

		if var_4_0 then
			self.m_likeBtn:setTitle(var_4_0.award_num)

			if var_4_0.award then
				self.m_likeBtn:setLike(true)

				if arg_4_2 then
					self.m_likeBtn:onLikeSuccess(arg_4_3)
				end
			else
				self.m_likeBtn:setLike(false)
			end
		end
	end
end

function DailyReportPart:updatePartBySnapShot()
	self.m_panelPage:setNumItems(self._panelNum)
end

function DailyReportPart:showCutPage()
	if self._panelNum >= 1 then
		self.m_panelPage:setVisible(false)

		local var_6_0 = self.m_selectIndexController:getSelectedIndex()
		local var_6_1 = self:getItemProviderName(var_6_0)

		if not var_6_1 then
			self.m_panelPage:setVisible(true)

			return
		end

		self._obj = fgui.UIPackage:createObject("dailyReport", var_6_1)

		self._obj:updatePanel(self._data[var_6_0 + 1], var_6_0)
		self._obj:showCutPage()
		self:addChild(self._obj)
		self._obj:setPosition((self.m_panelPage:getPosition()))
	end
end

function DailyReportPart:hideCutPage()
	if self._panelNum >= 1 then
		self.m_panelPage:setVisible(true)

		if self._obj then
			self._obj:removeSelf()

			self._obj = nil
		end
	end
end

function DailyReportPart:getItemProviderName(arg_8_1)
	if not self._data or not self._data[arg_8_1 + 1] then
		return nil
	end

	local var_8_0 = self._data[arg_8_1 + 1]

	if not self._data[arg_8_1 + 1].cfgData then
		return nil
	end

	local var_8_1 = var_8_0.cfgData.info

	if not var_8_0.cfgData.info then
		return nil
	end

	if var_8_1.style then
		if DailyReportConst.REPORT_STYLE_MAP_COMP[var_8_1.style] then
			return DailyReportConst.REPORT_STYLE_MAP_COMP[var_8_1.style]
		else
			return "DailyReportPanelComp"
		end
	else
		return "DailyReportPanelComp"
	end
end

function DailyReportPart:_onItemProvider(arg_9_1)
	if self._data[arg_9_1 + 1].cfgData.info.style then
		if DailyReportConst.REPORT_STYLE_MAP[self._data[arg_9_1 + 1].cfgData.info.style] then
			return DailyReportConst.REPORT_STYLE_MAP[self._data[arg_9_1 + 1].cfgData.info.style]
		else
			return "ui://dailyReport/DailyReportPanelComp"
		end
	else
		return "ui://dailyReport/DailyReportPanelComp"
	end
end

function DailyReportPart:onScheduleEvent()
	self._timeRunner = self._timeRunner + 1

	if self._timeRunner > 10 then
		self._timeRunner = 0

		if self._panelNum > 1 then
			self:_onSchedule()
		end
	end
end

function DailyReportPart:_onPanelPageRenderer(arg_11_1, arg_11_2)
	arg_11_2:updatePanel(self._data[arg_11_1 + 1], arg_11_1)
end

function DailyReportPart:_onSchedule()
	local var_12_0 = (self.m_selectIndexController:getSelectedIndex() + 1) % self._panelNum

	self.m_panelPage:scrollToView(var_12_0, true)
	self.m_pointPage:setSelectedIndex(var_12_0)
end

function DailyReportPart:_onTouchBegin(arg_13_1)
	self._timeRunner = 0

	if self._panelNum <= 0 then
		return
	end

	arg_13_1:captureTouch()

	self._startPosX = arg_13_1:getInput():getTouch():getLocationInView().x
end

function DailyReportPart:_onTouchMove(arg_14_1)
	self._timeRunner = 0

	if self._startPosX and self._panelNum > 0 then
		local var_14_0 = arg_14_1:getInput()

		if math.abs(var_14_0 - self._startPosX) > 20 then
			local var_14_1 = self.m_selectIndexController:getSelectedIndex() + (var_14_0:getTouch():getLocationInView().x > self._startPosX and -1 or 1)

			if var_14_1 < 0 then
				var_14_1 = 0
			end

			if var_14_1 >= self._panelNum then
				var_14_1 = self._panelNum - 1
			end

			self.m_pointPage:setSelectedIndex(var_14_1)
			self.m_panelPage:scrollToView(var_14_1, true)

			self._startPosX = nil
		end
	end
end

function DailyReportPart:_onTouchEnd(arg_15_1)
	self._timeRunner = 0
end

function DailyReportPart:_onLikeBtnClick()
	if self._column and self._column ~= 0 then
		if self.m_likeBtn:isInLike() then
			g.core.module.ModuleManager:tip(g.core.lang:get(206008))
		else
			local var_16_0 = var_0_1:getLikeData(self._column)

			if var_16_0 and not var_16_0.award then
				g.core.network.GameNetProxy:send_C2S_Daily_Report_GetAward({
					column_id = self._column
				})
			end
		end
	end
end

function DailyReportPart:onOneKeyBtnClick()
	if self.m_emptyController:getSelectedIndex() == 1 then
		self:_onLikeBtnClick()
	end
end

function DailyReportPart:onUnload()
	return
end

return DailyReportPart
