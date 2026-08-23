local AncientsGuessPop = class("AncientsGuessPop", require("app.fairyGUI.ancients.UI_AncientsGuessPop"), function()
	return fgui.GComponent:create({
		resName = "AncientsGuessPop",
		pkgPath = "ui/ancients/ancients",
		pkgName = "ancients"
	}, ...)
end)

function AncientsGuessPop:ctor()
	self:getView():center(true)
	self.m_List_guess:setVirtual(self)
	self.m_List_guess:doFairyBatching(false)
	self.m_List_guess:setItemRenderer(handler(self, self._onRenderListGuessCell))
	self.m_turn_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))
	self.m_tabController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeBigTabCtrl))
	self.m_ComTabPopCell1:addClickListener(handler(self, self._onClickBtnTab1))
	self.m_ComTabPopCell2:addClickListener(handler(self, self._onClickBtnTab2))
	self.m_Comp_Empty:setText(g.core.lang:get(433387))
	self.m_Txt_desc:setText(g.core.lang:get(433413, {
		date = g.core.common.ServerTime:getDateMDFormat(g.core.model.User.ancientsData:getActivityData().final_start_time),
		time1 = g.core.config.ancients_final_time_info.get(1).hour,
		time2 = g.core.config.ancients_final_time_info.get(2).hour,
		time3 = g.core.config.ancients_final_time_info.get(3).hour,
		time4 = g.core.config.ancients_final_time_info.get(4).hour
	}))

	local var_2_0 = 0
	local var_2_1 = 0
	local var_2_2 = 0
	local var_2_3 = g.core.model.User.ancientsData:getFinalStageTimeList()
	local var_2_4 = {
		0,
		var_2_3[1],
		var_2_3[2],
		var_2_3[3],
		var_2_3[4]
	}

	for iter_2_0 = 1, 4 do
		if g.core.model.User.ancientsData:checkAncientsFinalHasSubGuessAward({
			round = iter_2_0
		}) then
			var_2_0 = iter_2_0
		end

		if g.core.model.User.ancientsData:checkAncientsFinalSubCanGuess({
			round = iter_2_0
		}) then
			var_2_1 = iter_2_0
		end

		if g.core.common.ServerTime:getLeftSeconds(var_2_4[iter_2_0]) <= 0 or g.core.model.User.ancientsData:getAncientsState() ~= g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL then
			var_2_2 = iter_2_0
		end
	end

	self._curTabIndex = var_2_0 > 0 and var_2_0 - 1 or var_2_1 > 0 and var_2_1 - 1 or var_2_2 > 0 and var_2_2 - 1 or 0

	self.m_turn_tabController:setSelectedIndex(self._curTabIndex)
end

function AncientsGuessPop:onLoad()
	if g.core.model.User.ancientsData:getAncientsState() > g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP then
		g.core.network.GameNetProxy:send_C2S_Ancient_GuessInfo({})
	else
		self.m_tabController:setSelectedIndex(1)
	end

	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GUESSINFO, handler(self, self._updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_ROUNDNOTIFY, handler(self, self._updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GUESS, handler(self, self._updateView), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_GUESSAWARD, handler(self, self._showGuessAward), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_CROSS_DAY_NOTIFY, handler(self, self._updateView), self)
end

function AncientsGuessPop:_refreshRedPoint()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_tab_1,
		customData = {
			round = 1
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_tab_2,
		customData = {
			round = 2
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_tab_3,
		customData = {
			round = 3
		}
	})
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_tab_4,
		customData = {
			round = 4
		}
	})
end

function AncientsGuessPop:_showGuessAward(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	g.core.module.ModuleManager:awardSummary(arg_5_4.awards or {}, {
		autoDisappear = true
	})
	self:_updateView()
end

function AncientsGuessPop:_onChangeTabCtrl()
	self._curTabIndex = self.m_turn_tabController:getSelectedIndex()

	self:_updateView()
end

function AncientsGuessPop:_onChangeBigTabCtrl()
	self.m_time_stateController:setSelectedIndex(4)

	if self.m_tabController:getSelectedIndex() == 0 then
		if self._guessMap[self._curTabIndex + 1] and not g.core.model.User.ancientsData:isInStageShowTime(self._curTabIndex) then
			self.m_List_guess:setNumItems(#self._guessMap[self._curTabIndex + 1])
		else
			self.m_List_guess:setNumItems(0)
		end
	end

	self:_updateTimeCd()
end

function AncientsGuessPop:_onClickBtnTab1()
	if g.core.model.User.ancientsData:getAncientsState() <= g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL_COOP then
		self.m_ComTabPopCell2:setSelected(true)
		g.core.module.ModuleManager:tip(g.core.lang:get(433408, {
			date = g.core.common.ServerTime:getDateMDFormat(g.core.model.User.ancientsData:getActivityData().final_start_time)
		}))

		return
	end

	self.m_ComTabPopCell1:setSelected(true)
end

function AncientsGuessPop:_onClickBtnTab2()
	self.m_ComTabPopCell2:setSelected(true)
end

function AncientsGuessPop:_updateView()
	local var_10_0, var_10_1 = g.core.model.User.ancientsData:isInStageShowTimeAndCd()

	if var_10_0 then
		self._showTimeSchedule = self:newScheduleOnce(handler(self, self._updateView), var_10_1)
	end

	self.m_Comp_guessAward1:updateView(true)
	self.m_Comp_guessAward2:updateView(false)

	self._guessMap = g.core.model.User.ancientsData:getGuessMap()

	self.m_is_emptyController:setSelectedIndex((self._guessMap[self._curTabIndex + 1] == nil or g.core.model.User.ancientsData:isInStageShowTime(self._curTabIndex)) and 1 or 0)

	if self._guessMap[self._curTabIndex + 1] and not g.core.model.User.ancientsData:isInStageShowTime(self._curTabIndex) then
		self.m_List_guess:setNumItems(#self._guessMap[self._curTabIndex + 1])
	else
		self.m_List_guess:setNumItems(0)
	end

	self:_updateTab()
	self:_refreshRedPoint()
end

function AncientsGuessPop:_updateTab()
	local var_11_0 = g.core.model.User.ancientsData:getFinalStageTimeList()

	for iter_11_0 = 1, 4 do
		local var_11_1 = g.core.common.ServerTime:getLeftSeconds(({
			0,
			var_11_0[1],
			var_11_0[2],
			var_11_0[3],
			var_11_0[4]
		})[iter_11_0]) > 0 and g.core.model.User.ancientsData:getAncientsState() == g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL

		if var_11_1 then
			self["m_tab_" .. iter_11_0]:getChild("title"):setColor(g.core.common.Color.A3)
		end

		self["m_tab_" .. iter_11_0]:setTouchable(not var_11_1)
	end

	self:_updateTimeCd()

	if self._timeSchedule == nil then
		self._timeSchedule = self:newSchedule(handler(self, self._updateTimeCd), 1)
	end
end

function AncientsGuessPop:_updateTimeCd()
	local var_12_0 = 4
	local var_12_1 = 0
	local var_12_2 = g.core.model.User.ancientsData:getFinalStageTimeList()
	local var_12_3 = {
		0,
		var_12_2[1],
		var_12_2[2],
		var_12_2[3],
		var_12_2[4]
	}

	for iter_12_0 = 1, 4 do
		var_12_1 = g.core.common.ServerTime:getLeftSeconds(var_12_3[iter_12_0])

		if var_12_1 > 0 and var_12_0 == 4 then
			var_12_0 = iter_12_0 - 1

			break
		end
	end

	if self.m_tabController:getSelectedIndex() == 1 or g.core.model.User.ancientsData:getAncientsState() > g.core.const.ConstMgr.AncientsConst.ANCIENT_STATUS.FINAL then
		var_12_0 = 4
	end

	self.m_time_stateController:setSelectedIndex(var_12_0)
	self.m_Txt_timeCd:setText(g.core.common.ServerTime:secondToDHString(var_12_1))
end

function AncientsGuessPop:_onRenderListGuessCell(arg_13_1, arg_13_2)
	arg_13_2:updateCell(self._guessMap[self._curTabIndex + 1][arg_13_1 + 1])
end

return AncientsGuessPop
