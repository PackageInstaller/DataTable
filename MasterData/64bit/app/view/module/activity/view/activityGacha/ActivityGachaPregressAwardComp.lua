local ActivityGachaPregressAwardComp = class("ActivityGachaPregressAwardComp", require("app.fairyGUI.activity.UI_ActivityGachaPregressAwardComp"))

function ActivityGachaPregressAwardComp:ctor()
	self:addClickListener(handler(self, self.onClickReward))
end

function ActivityGachaPregressAwardComp:onClickReward()
	if not self._data then
		return
	end

	if self._data.isReward then
		g.core.module.ModuleManager:tip(g.core.lang:get(408112))

		return
	end

	if self._data.curValue < self._data.taskCfg.task_value then
		g.core.module.ModuleManager:tip(g.core.lang:get(408113))

		return
	end

	g.core.network.GameNetProxy:send_C2S_MonthGacha_TaskAward({
		task_ids = {
			self._data.taskCfg.id
		}
	})
end

function ActivityGachaPregressAwardComp:updateGachaTaskReward(arg_3_1)
	self._data = arg_3_1

	local var_3_0 = {}

	for iter_3_0 = 1, 4 do
		if arg_3_1.taskCfg["reward_size_" .. iter_3_0] ~= 0 then
			table.insert(var_3_0, {
				type = arg_3_1.taskCfg["reward_type_" .. iter_3_0],
				value = arg_3_1.taskCfg["reward_value_" .. iter_3_0],
				size = arg_3_1.taskCfg["reward_size_" .. iter_3_0]
			})
		end
	end

	if var_3_0[1] then
		local var_3_1 = g.core.common.Goods:convert(var_3_0[1])

		self.m_itemIconMask:setURL(var_3_1.icon)
		self.m_itemIcon:setURL(var_3_1.icon)
		self.m_timesTxt:setText(arg_3_1.taskCfg.task_value)
		self.m_numTxt:setText("x" .. var_3_0[1].size)
	end

	self.m_eff:removeAllEffect()

	if arg_3_1.curValue >= arg_3_1.taskCfg.task_value then
		if arg_3_1.isReward then
			self.m_stateController:setSelectedIndex(1)
		else
			self.m_eff:addEffectSpine({
				anim = "play",
				isLoop = true,
				name = "eff_ui_activityGacha_award"
			})
			self.m_stateController:setSelectedIndex(0)
		end
	else
		self.m_stateController:setSelectedIndex(0)
	end
end

return ActivityGachaPregressAwardComp
