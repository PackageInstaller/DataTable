local AncientsTeamSpoilsPop = class("AncientsTeamSpoilsPop", require("app.fairyGUI.ancients.UI_AncientsTeamSpoilsPop"), function()
	return fgui.GComponent:create({
		resName = "AncientsTeamSpoilsPop",
		pkgPath = "ui/ancients/ancients",
		pkgName = "ancients"
	}, ...)
end)

function AncientsTeamSpoilsPop:ctor()
	self:getView():center(true)
	self.m_Tab_week2:getController("isLock"):setSelectedIndex(1)
	self.m_Tab_week3:getController("isLock"):setSelectedIndex(1)
	self.m_Tab_week4:getController("isLock"):setSelectedIndex(1)
	self.m_Btn_week2:addClickListener(handler(self, self._onClickBtnWeek2))
	self.m_Btn_week3:addClickListener(handler(self, self._onClickBtnWeek3))
	self.m_Btn_week4:addClickListener(handler(self, self._onClickBtnWeek4))
	self.m_Btn_detail:addClickListener(handler(self, self._onClickBtnDetail))
	self.m_List_notAllocated:setVirtual(self)
	self.m_List_notAllocated:setItemRenderer(handler(self, self._onRenderListNotAllocatedCell))
	self.m_List_allocating:setVirtual(self)
	self.m_List_allocating:setItemRenderer(handler(self, self._onRenderListAllocatingCell))
	self.m_tabTypeController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChangeTabCtrl))

	local var_2_0 = g.core.model.User.ancientsData:getActivityData()
	local var_2_1 = g.core.common.ServerTime:getDeltaDays(var_2_0.score_start_time, g.core.common.ServerTime:getTime()) - 1 <= 0 and 0 or g.core.common.ServerTime:getTime() <= var_2_0.score_end_time and 1 or 2

	self._curTab = var_2_1

	self.m_red_posController:setSelectedIndex(var_2_1)

	self._lootDataMap = {}
	self._dicesDataMap = {}
	self._awardInfo = nil
	self._deltaDay = 0
end

function AncientsTeamSpoilsPop:onLoad()
	g.core.network.GameNetProxy:send_C2S_Ancient_LootInfo({})
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_LOOTINFO, handler(self, self._onRevGetLootInfo), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_DICENOTIFY, handler(self, self._onRevDiceNotify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_ANCIENT_DICEROLL, handler(self, self._updateRes), self)
end

function AncientsTeamSpoilsPop:_onRevGetLootInfo(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	self.m_Tab_redPoint:setVisible(false)

	for iter_4_0, iter_4_1 in ipairs(arg_4_4.loots) do
		self._lootDataMap[iter_4_1.score_day] = iter_4_1

		if iter_4_1.status == g.core.const.ConstMgr.AncientsConst.ANCIENT_LOOT_STATUS.DISTRIBUTE and g.core.model.User.ancientsData:getSelfDiceNum() > 0 then
			self.m_Tab_redPoint:setVisible(true)
		end

		if iter_4_1.dices then
			for iter_4_2, iter_4_3 in ipairs(iter_4_1.dices) do
				self._dicesDataMap[iter_4_1.score_day .. "_" .. iter_4_3.id] = iter_4_3
			end
		end
	end

	self.m_tabTypeController:setSelectedIndex(self._curTab)
	self:_updateView()
end

function AncientsTeamSpoilsPop:_onRevDiceNotify(arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	self._dicesDataMap[arg_5_4.score_day .. "_" .. arg_5_4.dice.id] = arg_5_4.dice

	self:_updateView()
end

function AncientsTeamSpoilsPop:_onChangeTabCtrl()
	self._curTab = self.m_tabTypeController:getSelectedIndex()

	self:_updateView()
end

function AncientsTeamSpoilsPop:_updateView()
	self:_updateRes()
	self:_updateTab()
	dump("weekIndex:" .. self._curTab + self._deltaDay)

	local var_7_0 = self._lootDataMap[self._curTab + self._deltaDay]

	self.m_stateController:setSelectedIndex(self._lootDataMap[self._curTab + self._deltaDay].status)

	local var_7_1, var_7_2 = g.core.model.User.ancientsData:getPetEquipmentIconTypeAndPathByPetId(var_7_0.pet_id)
	local var_7_3 = g.core.config.ancients_pet_info.get(var_7_0.pet_id)

	self._awardInfo = nil
	self._fakeMaxInfo = nil
	self._fakeQuality = 0

	local var_7_4 = g.core.config.ancients_award_info.indexOf(g.core.config.ancients_award_info.getLength()).exp

	for iter_7_0 = 1, g.core.config.ancients_award_info.getLength() do
		local var_7_5 = g.core.config.ancients_award_info.indexOf(iter_7_0)
		local var_7_6

		if var_7_5.award_group == var_7_3.award_group and var_7_5.exp <= var_7_0.exp and -1 < var_7_5.exp then
			self._awardInfo = var_7_5
			var_7_6 = var_7_5.exp
		end

		if var_7_5.award_group == var_7_3.award_group and self._fakeQuality <= var_7_5.quality then
			self._fakeMaxInfo = var_7_5
			self._fakeQuality = var_7_5.quality
		end

		if var_7_5.award_group == var_7_3.award_group and var_7_5.exp > var_7_0.exp and var_7_4 > var_7_5.exp then
			var_7_4 = var_7_5.exp
		end
	end

	if var_7_0.status == g.core.const.ConstMgr.AncientsConst.ANCIENT_LOOT_STATUS.NOT_OPEN then
		self._awardInfo = self._fakeMaxInfo
	end

	self.m_Img_box:setURL(g.core.common.Path:getAncientsTeamBoxIcon(self._awardInfo.quality))

	if self._awardInfo then
		self._showArr = g.core.model.User.ancientsData:getBoxGoodsArray(self._awardInfo.box)

		self.m_Txt_name:setText(g.core.lang:get(433342, {
			name = self._awardInfo.name
		}))

		if var_7_0.status == g.core.const.ConstMgr.AncientsConst.ANCIENT_LOOT_STATUS.NONE then
			self.m_List_notAllocated:setNumItems(#self._showArr)
			self.m_Txt_point:setText(var_7_0.exp .. "/" .. var_7_4)
			self.m_is_fullExpController:setSelectedIndex(var_7_4 <= var_7_0.exp and 1 or 0)
			self.m_Comp_progress:setValue(var_7_0.exp)
			self.m_Comp_progress:setMax(var_7_4)
			self.m_Txt_pointTime:setText((g.core.common.ServerTime:getAwardLeftTime(24, 0, 0)))
		elseif var_7_0.status == g.core.const.ConstMgr.AncientsConst.ANCIENT_LOOT_STATUS.DISTRIBUTE then
			self.m_List_allocating:setNumItems(#self._showArr)
			self.m_Txt_allocateTime:setText("")
			self.m_Txt_allocateTime:setText((g.core.common.ServerTime:getAwardLeftTime(12, 0, 0)))
		elseif var_7_0.status == g.core.const.ConstMgr.AncientsConst.ANCIENT_LOOT_STATUS.DISTRIBUTE_DONE then
			self.m_Comp_allocated:updateView({
				showArr = self._showArr,
				dicesDataMap = self._dicesDataMap,
				weekIndex = self._curTab + self._deltaDay
			})
		elseif var_7_0.status == g.core.const.ConstMgr.AncientsConst.ANCIENT_LOOT_STATUS.NOT_OPEN then
			self.m_List_notAllocated:setNumItems(#self._showArr)
			self.m_Txt_openTime:setText((g.core.common.ServerTime:getAwardLeftTime(24, 0, 0)))
		end
	end

	self._timeSchedule = self:newSchedule(handler(self, self._updateTime), 1)
end

function AncientsTeamSpoilsPop:_updateTime()
	if self._lootDataMap[self._curTab + self._deltaDay].status == g.core.const.ConstMgr.AncientsConst.ANCIENT_LOOT_STATUS.NONE then
		self.m_Txt_pointTime:setText((g.core.common.ServerTime:getAwardLeftTime(24, 0, 0)))
	elseif self._lootDataMap[self._curTab + self._deltaDay].status == g.core.const.ConstMgr.AncientsConst.ANCIENT_LOOT_STATUS.DISTRIBUTE then
		self.m_Txt_allocateTime:setText((g.core.common.ServerTime:getAwardLeftTime(g.core.config.ancients_parameter_info.get(42).parameter, 0, 0)))
	elseif self._lootDataMap[self._curTab + self._deltaDay].status == g.core.const.ConstMgr.AncientsConst.ANCIENT_LOOT_STATUS.DISTRIBUTE_DONE then
		-- block empty
	elseif self._lootDataMap[self._curTab + self._deltaDay].status == g.core.const.ConstMgr.AncientsConst.ANCIENT_LOOT_STATUS.NOT_OPEN then
		self.m_Txt_openTime:setText((g.core.common.ServerTime:getAwardLeftTime(24, 0, 0)))
	end
end

function AncientsTeamSpoilsPop:_updateRes()
	if g.core.model.User.ancientsData:getSelfDiceNum() > 0 then
		self.m_Tab_redPoint:setVisible(true)
	else
		self.m_Tab_redPoint:setVisible(false)
	end

	self.m_Comp_res:updateResBtn({
		value = 12004,
		type = g.core.common.Goods.TYPE_ITEM,
		updateResFunc = function()
			return g.core.model.User.ancientsData:getSelfDiceNum()
		end
	})
end

function AncientsTeamSpoilsPop:_updateTab()
	local var_11_0 = g.core.model.User.ancientsData:getActivityData()
	local var_11_1 = math.max(math.min(math.max(1, (g.core.common.ServerTime:getDeltaDays(var_11_0.score_start_time, g.core.common.ServerTime:getTime()))), g.core.common.ServerTime:getDeltaDays(var_11_0.score_start_time, var_11_0.score_end_time) - 1) - 1, 1)

	self._deltaDay = var_11_1

	self.m_Tab_week2:setTitle(g.core.common.ServerTime:getDateMDFormat(g.core.common.ServerTime:getNextNDayZeroTime(var_11_0.score_start_time, var_11_1)))
	self.m_Tab_week3:setTitle(g.core.common.ServerTime:getDateMDFormat(g.core.common.ServerTime:getNextNDayZeroTime(var_11_0.score_start_time, var_11_1 + 1)))
	self.m_Tab_week4:setTitle(g.core.common.ServerTime:getDateMDFormat(g.core.common.ServerTime:getNextNDayZeroTime(var_11_0.score_start_time, var_11_1 + 2)))

	local var_11_2 = g.core.common.ServerTime:getLeftSeconds(g.core.common.ServerTime:getNextNDayZeroTime(var_11_0.score_start_time, var_11_1)) < 0
	local var_11_3 = g.core.common.ServerTime:getLeftSeconds(g.core.common.ServerTime:getNextNDayZeroTime(var_11_0.score_start_time, var_11_1 + 1)) < 0
	local var_11_4 = g.core.common.ServerTime:getLeftSeconds(g.core.common.ServerTime:getNextNDayZeroTime(var_11_0.score_start_time, var_11_1 + 2)) < 0

	self.m_Tab_week2:getController("isLock"):setSelectedIndex(var_11_2 and 0 or 1)
	self.m_Tab_week2:setTouchable(var_11_2)
	self.m_Btn_week2:setVisible(not var_11_2)
	self.m_Tab_week3:getController("isLock"):setSelectedIndex(var_11_3 and 0 or 1)
	self.m_Tab_week3:setTouchable(var_11_3)
	self.m_Btn_week3:setVisible(not var_11_3)
	self.m_Tab_week4:getController("isLock"):setSelectedIndex(var_11_4 and 0 or 1)
	self.m_Tab_week4:setTouchable(var_11_4)
	self.m_Btn_week4:setVisible(not var_11_4)
end

function AncientsTeamSpoilsPop:_onClickBtnDetail()
	g.core.module.ModuleManager:pushModule(g.view.entrance.ANCIENTS_TEAM_SPOILS_PREVIEW_POP, {
		groupId = g.core.config.ancients_pet_info.get(self._lootDataMap[self._curTab + self._deltaDay].pet_id).award_group,
		quality = g.core.model.User.ancientsData:getAwardProg(g.core.model.User.ancientsData:getAwardExp()).cfg.quality
	})
end

function AncientsTeamSpoilsPop:_onRenderListNotAllocatedCell(arg_13_1, arg_13_2)
	arg_13_2:updateCell({
		state = 0,
		weekDay = self._curTab + self._deltaDay,
		info = self._showArr[arg_13_1 + 1]
	})
end

function AncientsTeamSpoilsPop:_onRenderListAllocatingCell(arg_14_1, arg_14_2)
	local var_14_0 = self._showArr[arg_14_1 + 1]

	arg_14_2:updateCell({
		state = 1,
		weekDay = self._curTab + self._deltaDay,
		info = var_14_0,
		dices = (self._dicesDataMap[self._curTab + self._deltaDay .. "_" .. self._showArr[arg_14_1 + 1].id] or nil) and (self._dicesDataMap[self._curTab + self._deltaDay .. "_" .. var_14_0.id].rolls or {})
	})
end

function AncientsTeamSpoilsPop:_onClickBtnWeek2()
	g.core.module.ModuleManager:tip(g.core.lang:get(433369, {
		date = self.m_Tab_week2:getTitle()
	}))
end

function AncientsTeamSpoilsPop:_onClickBtnWeek3()
	g.core.module.ModuleManager:tip(g.core.lang:get(433369, {
		date = self.m_Tab_week3:getTitle()
	}))
end

function AncientsTeamSpoilsPop:_onClickBtnWeek4()
	g.core.module.ModuleManager:tip(g.core.lang:get(433369, {
		date = self.m_Tab_week4:getTitle()
	}))
end

return AncientsTeamSpoilsPop
