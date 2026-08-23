local NewSlgSeasonAwardIcon = class("NewSlgSeasonAwardIcon", require("app.fairyGUI.newSlg.UI_NewSlgSeasonAwardIcon"))

function NewSlgSeasonAwardIcon:updateIcon(arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	self._params = arg_1_1
	self._taskId = arg_1_4

	self.m_icon:updateIcon(arg_1_1)
	self.m_stateController:setSelectedIndex(arg_1_3 and 1 or 0)
	self.m_eff:removeAllEffect()

	if arg_1_2 then
		self.m_eff:addEffectSpine({
			anim = "play_0",
			name = "eff_ui_common_iconget",
			scale = 0.58,
			isLoop = true
		})
		self.m_icon:setTouchFunc(handler(self, self.clickReward))
	else
		self.m_icon:setTouchFunc(handler(self, self.showItemDetail))
	end
end

function NewSlgSeasonAwardIcon:showItemDetail()
	local var_2_0 = clone(self._params)

	if not var_2_0.value or not var_2_0.type then
		return
	end

	var_2_0.component = self

	g.core.common.GlobalFunc.pushInfoPop(var_2_0)
end

function NewSlgSeasonAwardIcon:clickReward()
	g.core.network.GameNetProxy:send_C2S_NewSlg_SeasonTaskAward({
		id = self._taskId
	})
end

return NewSlgSeasonAwardIcon
