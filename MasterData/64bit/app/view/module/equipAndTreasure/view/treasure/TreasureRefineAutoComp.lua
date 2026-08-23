local var_0_0 = g.core.model.User.treasureData
local DayNotifyToolConst = require("app.view.common.const.DayNotifyToolConst")
local TreasureConst = require("app.view.module.equipAndTreasure.const.TreasureConst")
local TreasureRefineAutoComp = class("TreasureRefineAutoComp", require("app.fairyGUI.equipAndTreasure.UI_TreasureRefineAutoComp"))

function TreasureRefineAutoComp:ctor()
	self._sid = 0

	self.m_purifyBtn:addClickListener(handler(self, self.onClickPurify))
	self.m_tenPurifyBtn:addClickListener(handler(self, self.onClickTenPurify))

	self._tenPurifying = false
	self._tenPurifyNum = 0

	self.m_cancelBtn:addClickListener(handler(self, self.onClickCancel))
	self.m_saveBtn:addClickListener(handler(self, self.onClickSave))
	self.m_normalCost:setClickHandler(handler(self, self.onExchangeCostItem))
	g.core.model.User.functionUnlockData:saveUnlockedFunc(g.core.const.ConstMgr.FUNCTION_TYPE.ARTIFACT_CAST)
end

function TreasureRefineAutoComp:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TREASURE_PURIFY, handler(self, self.onPurify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TREASURE_PURIFY_REPLACE, handler(self, self.onReplace), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_TREASURE_PURIFY_LOCK, handler(self, self.onPurify), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_OP_OBJECT, handler(self, self.onUpdateView), self)
end

function TreasureRefineAutoComp:onPurify()
	local var_3_0, var_3_1 = var_0_0:getTreasureFullPurifyScore(self._params.data.id)

	if self._tenPurifying and var_3_1 < var_3_0 then
		self:onCancelPurify()

		return
	elseif self._tenPurifying and var_3_0 <= var_3_1 then
		self._tenPurifyNum = 0
		self._tenPurifying = false

		self:dispatchCompEvent("block_click", false)
		g.core.module.ModuleManager:tip(g.core.lang:get(202073))
	end

	self:updateView(nil, true)
end

function TreasureRefineAutoComp:onReplace()
	local var_4_0, var_4_1 = var_0_0:getTreasureFullPurifyScore(self._params.data.id)

	if self._tenPurifying and self._tenPurifyNum < 10 then
		self:onClickPurify()

		return
	elseif self._tenPurifying and self._tenPurifyNum >= 10 then
		self._tenPurifyNum = 0
		self._tenPurifying = false

		self:dispatchCompEvent("block_click", false)
		g.core.module.ModuleManager:tip(g.core.lang:get(202073))
	end

	self:updateView(nil, true)
end

function TreasureRefineAutoComp:onUpdateView()
	self:updateView(nil, true)
end

function TreasureRefineAutoComp:updateView(arg_6_1, arg_6_2)
	arg_6_1 = arg_6_1 or self._params
	self._params = arg_6_1

	local var_6_0 = arg_6_1.data.id

	self._sid = arg_6_1.data.id

	local var_6_1, var_6_2 = var_0_0:getTreasureFullPurifyScore(var_6_0)
	local var_6_3 = var_0_0:isInPurify(var_6_0)

	if var_6_3 then
		if arg_6_2 then
			self.m_effholder:addEffectSpine({
				isLoop = false,
				remove = true,
				anim = "play",
				name = "eff_ui_treasure_wordlight"
			})
		end

		if self._tenPurifying then
			self.m_stateController:setSelectedIndex(2)
		else
			self.m_stateController:setSelectedIndex(1)
		end

		self.m_curScoreTxt:setText(var_6_1)
		self.m_tmpScoreTxt:setText(var_6_2)

		if var_6_1 < var_6_2 then
			self.m_upScoreController:setSelectedIndex(1)
		elseif var_6_2 < var_6_1 then
			self.m_upScoreController:setSelectedIndex(2)
		else
			self.m_upScoreController:setSelectedIndex(0)
		end
	else
		if self._tenPurifying then
			return
		end

		self.m_stateController:setSelectedIndex(0)
		self.m_upScoreController:setSelectedIndex(0)
		self.m_totalScoreTxt:setText(var_6_1)
	end

	local var_6_4 = var_0_0:getPurifyCfg(var_6_0)[1]

	if not var_6_4 then
		return
	end

	for iter_6_0 = 1, TreasureConst.PURIFY_MAX_NUM do
		if iter_6_0 <= var_6_4.hole_num then
			self["m_purifyAttr" .. iter_6_0]:setVisible(true)
			self["m_purifyAttr" .. iter_6_0]:updatePurifyAttr(var_0_0:getTreasureDataByOnlyId(var_6_0), var_6_3, iter_6_0, arg_6_2)
		else
			self["m_purifyAttr" .. iter_6_0]:setVisible(false)
		end
	end

	local var_6_5 = {}

	for iter_6_1, iter_6_2 in ipairs((var_0_0:getPurifyCost(var_6_0))) do
		for iter_6_3, iter_6_4 in ipairs(iter_6_2.normal) do
			var_6_5[#var_6_5 + 1] = iter_6_4
		end
	end

	self.m_normalCost:updateCostShow(var_6_5)

	local var_6_6 = self.m_normalCost:getSelectedCostIdx()

	if var_6_6 < 0 then
		self.m_normalCost:setSelectedCostIdx(0)
	else
		self.m_normalCost:setSelectedCostIdx(var_6_6)
	end
end

function TreasureRefineAutoComp:onExchangeCostItem(arg_7_1)
	local var_7_0 = var_0_0:getPurifyCost(self._sid)[arg_7_1]

	self:updateLockCost(var_7_0)
	self.m_isUseNewItemController:setSelectedIndex(arg_7_1 - 1)
	self.m_resNumComp:updateByTVS({
		type = var_7_0.normalEx[1].type,
		value = var_7_0.normalEx[1].value,
		size = var_7_0.normalEx[1].size
	})
end

function TreasureRefineAutoComp:updateLockCost(arg_8_1)
	if self:getLockNum() > 0 then
		local var_8_0 = {}

		for iter_8_0, iter_8_1 in ipairs(arg_8_1.lock) do
			var_8_0[#var_8_0 + 1] = iter_8_1
		end

		for iter_8_2, iter_8_3 in ipairs(arg_8_1.newlock) do
			var_8_0[#var_8_0 + 1] = iter_8_3
		end

		self.m_lockCost:updateCostShow(var_8_0)

		if self.m_lockCost:getSelectedCostIdx() < 0 then
			self.m_lockCost:setSelectedCostIdx(0)
		end

		self.m_showLockCostController:setSelectedIndex(1)
	else
		self.m_showLockCostController:setSelectedIndex(0)
	end
end

function TreasureRefineAutoComp:getLockNum()
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(var_0_0:getTreasureDataByOnlyId(self._sid).holes or {}) do
		if iter_9_1.lock then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0
end

function TreasureRefineAutoComp:onClickPurify()
	local var_10_0 = checkbool(self.m_lockCost:getSelectedCostIdx() == 1)
	local var_10_1, var_10_2 = var_0_0:isCostEnough(self._sid, nil, var_10_0, self.m_normalCost:getSelectedCostIdx() + 1)

	if self._sid > 0 and var_10_1 then
		if self._tenPurifying then
			self._tenPurifyNum = self._tenPurifyNum + 1
		end

		local var_10_3 = var_0_0:getCurPurifyOpenNum(self._sid)[1].curNum
		local var_10_4 = self:getLockNum()

		if var_10_4 > 0 then
			if not g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_TREASURE_PURIFY_EX_COST) then
				local var_10_5 = var_0_0:getPurifyCost(self._sid)[self.m_normalCost:getSelectedCostIdx() + 1]
				local var_10_6

				if var_10_0 then
					var_10_6 = var_10_5.newlock or var_10_5.lock
				end

				local var_10_7 = ""

				for iter_10_0, iter_10_1 in ipairs(var_10_6) do
					var_10_7 = g.core.common.Goods:convert(iter_10_1).name .. "*" .. iter_10_1.size .. " "
				end

				g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
					title = g.core.lang:get(111026),
					desc = g.core.lang:get(202068, {
						num = var_10_4,
						nameTxt = var_10_7
					}),
					confirmText = g.core.lang:get(1160),
					onConfirm = handler(self, self._onTreasurePurify),
					onCancel = handler(self, self._onCancelConfirmPop),
					tip = {
						txt = g.core.lang:get(408110),
						isChecked = g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_TREASURE_PURIFY_EX_COST)
					},
					onCheck = handler(self, self._onNotifyCheck)
				}), {
					touchDisappear = true
				})
			else
				self:_onTreasurePurify()
			end
		elseif var_10_4 < var_10_3 then
			self:_onTreasurePurify()
		end
	else
		if self._tenPurifying then
			self._tenPurifyNum = 0
			self._tenPurifying = false

			self:dispatchCompEvent("block_click", false)
			self.m_stateController:setSelectedIndex(0)
		end

		if var_10_2 then
			g.view.entrance.ModuleGotoProxy:gotoModuleBySource({
				type = var_10_2.type,
				value = var_10_2.value,
				needSize = var_10_2.size
			})
		end
	end
end

function TreasureRefineAutoComp:onClickTenPurify()
	self._tenPurifying = true

	self:dispatchCompEvent("block_click", true)
	self:onClickPurify()
end

function TreasureRefineAutoComp:_onNotifyCheck(arg_12_1)
	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_TREASURE_PURIFY_EX_COST, arg_12_1)
end

function TreasureRefineAutoComp:_onTreasurePurify()
	g.core.network.GameNetProxy:send_C2S_Treasure_Purify({
		id = self._sid,
		consume_type = self.m_normalCost:getSelectedCostIdx() == 1 and 2 or 1,
		lock_consume_type = self.m_lockCost:getSelectedCostIdx() > 0 and 2 or 1
	})
end

function TreasureRefineAutoComp:_onCancelConfirmPop()
	if self._tenPurifying then
		self._tenPurifyNum = 0
		self._tenPurifying = false

		self:dispatchCompEvent("block_click", false)
		self.m_stateController:setSelectedIndex(0)
	end
end

function TreasureRefineAutoComp:onClickCancel()
	if self._sid > 0 then
		local var_15_0, var_15_1 = var_0_0:getTreasureFullPurifyScore(self._sid)

		if var_15_0 < var_15_1 and not g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_TREASURE_PURIFY_CANCEL_NOTIFY) then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(111026),
				desc = g.core.lang:get(202069),
				confirmText = g.core.lang:get(1160),
				onConfirm = handler(self, self.onCancelPurify),
				tip = {
					txt = g.core.lang:get(408110),
					isChecked = g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_TREASURE_PURIFY_CANCEL_NOTIFY)
				},
				onCheck = handler(self, self.clickCancelNotNotify)
			}), {
				touchDisappear = true
			})
		else
			self:onCancelPurify()
		end
	end
end

function TreasureRefineAutoComp:onCancelPurify()
	g.core.network.GameNetProxy:send_C2S_Treasure_Purify_Replace({
		replace = false,
		id = self._sid
	})
end

function TreasureRefineAutoComp:clickCancelNotNotify(arg_17_1)
	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_TREASURE_PURIFY_CANCEL_NOTIFY, arg_17_1)
end

function TreasureRefineAutoComp:isAllChangeAttrLow()
	for iter_18_0, iter_18_1 in ipairs(var_0_0:getTreasureDataByOnlyId(self._sid).holes or {}) do
		if not iter_18_1.lock and iter_18_1.cur and iter_18_1.tmp then
			if iter_18_1.tmp.id > 0 and iter_18_1.cur.id == 0 then
				return false
			end

			if iter_18_1.cur.id ~= 0 and iter_18_1.tmp.id ~= 0 and var_0_0:getPurifyScore(iter_18_1.cur.id, iter_18_1.cur.init_value, iter_18_1.cur.group) < var_0_0:getPurifyScore(iter_18_1.tmp.id, iter_18_1.tmp.init_value, iter_18_1.tmp.group) then
				return false
			end
		end
	end

	return true
end

function TreasureRefineAutoComp:onClickSave()
	if self._sid > 0 then
		if not g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_TREASURE_PURIFY_CONFIRM_NOTIFY) then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(111026),
				desc = g.core.lang:get(202070),
				confirmText = g.core.lang:get(1160),
				onConfirm = handler(self, self.confirmSavePurify),
				tip = {
					txt = g.core.lang:get(408110),
					isChecked = g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_TREASURE_PURIFY_CONFIRM_NOTIFY)
				},
				onCheck = handler(self, self.confirmSavePurifyNotify)
			}), {
				touchDisappear = true
			})
		elseif self:isAllChangeAttrLow() and not g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_TREASURE_PURIFY_CONFIRM_NOTIFY_ALL_LOW) then
			g.core.module.ModuleManager:pushPopup(require("app.view.base.pop.BaseConfirmPop").new({
				title = g.core.lang:get(111026),
				desc = g.core.lang:get(202071),
				confirmText = g.core.lang:get(1160),
				onConfirm = handler(self, self.confirmSavePurify),
				tip = {
					txt = g.core.lang:get(408110),
					isChecked = g.core.model.User.dayNotifyTool:isTodayHasRecord(DayNotifyToolConst.TYPE_TREASURE_PURIFY_CONFIRM_NOTIFY_ALL_LOW)
				},
				onCheck = handler(self, self.confirmSavePurifyAllLowNotify)
			}), {
				touchDisappear = true
			})
		else
			self:confirmSavePurify()
		end
	end
end

function TreasureRefineAutoComp:confirmSavePurifyNotify(arg_20_1)
	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_TREASURE_PURIFY_CONFIRM_NOTIFY, arg_20_1)
end

function TreasureRefineAutoComp:confirmSavePurifyAllLowNotify(arg_21_1)
	g.core.model.User.dayNotifyTool:saveTodayRecord(DayNotifyToolConst.TYPE_TREASURE_PURIFY_CONFIRM_NOTIFY_ALL_LOW, arg_21_1)
end

function TreasureRefineAutoComp:confirmSavePurify()
	g.core.network.GameNetProxy:send_C2S_Treasure_Purify_Replace({
		replace = true,
		id = self._sid
	})
end

return TreasureRefineAutoComp
