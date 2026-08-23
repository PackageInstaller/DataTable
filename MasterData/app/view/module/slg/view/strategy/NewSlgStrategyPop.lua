local var_0_0 = g.core.model.User.allianceData
local var_0_1 = g.core.const.ConstMgr.AllianceConst
local NewSlgStrategyPop = class("NewSlgStrategyPop", require("app.fairyGUI.newSlg.UI_NewSlgStrategyPop"), function()
	return fgui.GComponent:create({
		resName = "NewSlgStrategyPop",
		pkgPath = "ui/newSlg/newSlg",
		isFullScreen = true,
		pkgName = "newSlg"
	})
end)

function NewSlgStrategyPop:ctor()
	self.m_timeTxt:setText(g.core.lang:get(429761, {
		time = g.core.config.new_slg_parameter_info.get(g.core.const.ConstMgr.NewSlgConst.STRATEGY_REFRESH_TIME_PARAMETER_ID).parameter * 24
	}))
	self.m_mask:addClickListener(handler(self, self.onPopStrategy))
end

function NewSlgStrategyPop:onPopStrategy()
	g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
end

function NewSlgStrategyPop:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_SETALLIANCESTRATEGY, handler(self, self._onS2CNewSlgSetAllianceStrategy), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_NOTIFYALLIANCESTRATEGY, handler(self, self._updatePop), self)
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_NEW_SLG_GETALLIANCEINFO, handler(self, self._updatePop), self)
	self:_updatePop()
end

function NewSlgStrategyPop:onUnload()
	self:_stopTimer()
end

function NewSlgStrategyPop:_updatePop()
	self._refreshTime = g.core.model.User.newSlgData:getEndStrategyTime()

	local var_6_0 = g.core.model.User.newSlgData:getAllianceData()
	local var_6_1 = var_6_0.strategy_base_id
	local var_6_2 = var_0_0:getMyGrade()
	local var_6_3 = (var_6_2 == var_0_1.GRADE.LEADER or var_6_2 == var_0_1.GRADE.VICE_LEADER) and var_6_1 == 0
	local var_6_4 = not (var_6_2 == var_0_1.GRADE.LEADER or var_6_2 == var_0_1.GRADE.VICE_LEADER) and var_6_1 == 0
	local var_6_5 = var_6_0.refresh_strategy_base_ids or {}

	for iter_6_0, iter_6_1 in ipairs(var_6_5) do
		local var_6_6 = var_6_1 == iter_6_1

		if var_6_4 then
			var_6_6 = true
		end

		self["m_card" .. iter_6_0]:updateStrategyCell({
			cfg = g.core.config.new_slg_alli_strategy_info.get(iter_6_1),
			canChose = var_6_3,
			isUsing = var_6_6,
			forceHideUseBtn = var_6_4
		})

		if var_6_6 then
			self.m_choseIndexController:setSelectedIndex(iter_6_0 - 1)
		end
	end

	self:_startTimer()

	if #var_6_5 == 0 then
		g.core.module.ModuleManager:tip(g.core.lang:get(429809))
		g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
	else
		self:_updateStrategyRefreshTime()
	end
end

function NewSlgStrategyPop:receiveCompEvent(arg_7_1, arg_7_2)
	if arg_7_1 == "doUseStrategy" then
		self:_doUseStrategy(arg_7_2.id)

		return true
	end
end

function NewSlgStrategyPop:_doUseStrategy(arg_8_1)
	g.core.network.GameNetProxy:send_C2S_NewSlg_SetAllianceStrategy({
		alli_strategy_base_id = arg_8_1
	})
end

function NewSlgStrategyPop:_onS2CNewSlgSetAllianceStrategy()
	self:_updatePop()

	local var_9_0 = g.core.model.User.newSlgData:getAllianceData()

	for iter_9_0, iter_9_1 in ipairs(var_9_0.refresh_strategy_base_ids) do
		if iter_9_1 == var_9_0.strategy_base_id then
			self["m_card" .. iter_9_0]:playChoseEffect()

			break
		end
	end

	g.core.module.ModuleManager:tip(g.core.lang:get(429762))
end

function NewSlgStrategyPop:_startTimer()
	self._timer = self._timer or self:newSchedule(handler(self, self._updateStrategyRefreshTime), 1)
end

function NewSlgStrategyPop:_stopTimer()
	if self._timer then
		self:cancelSchedule(self._timer)
	end

	self._timer = nil
end

function NewSlgStrategyPop:_updateStrategyRefreshTime()
	local var_12_0, var_12_1, var_12_2, var_12_3 = g.core.common.ServerTime:getLeftTimeParts(self._refreshTime)

	if var_12_0 + var_12_1 + var_12_2 + var_12_3 <= 0 then
		-- block empty
	else
		local var_12_4

		if var_12_0 > 0 then
			var_12_1 = var_12_1 + var_12_0 * 24
			var_12_4 = {}
		end

		var_12_4.time = g.core.lang:get(1060, {
			hour = var_12_1,
			minute = var_12_2,
			second = var_12_3
		})

		self.m_timeTxt:setText(g.core.lang:get(429761, var_12_4))
	end
end

return NewSlgStrategyPop
