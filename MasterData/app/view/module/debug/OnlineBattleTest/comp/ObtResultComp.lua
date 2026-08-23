local ObtResultComp = class("ObtResultComp", require("app.fairyGUI.debug.UI_ObtResultComp"))

function ObtResultComp:ctor()
	self._highRoundList = {}

	self:initView()
end

function ObtResultComp:initView()
	self.m_highRoundList:setVirtual()
	self.m_highRoundList:setItemRenderer(handler(self, self._onHighRoundListRenderer))
end

function ObtResultComp:_onHighRoundListRenderer(arg_3_1, arg_3_2)
	arg_3_2:setTitle("战斗" .. self._highRoundList[arg_3_1 + 1].battleIndex .. "回合数：" .. self._highRoundList[arg_3_1 + 1].round)
end

function ObtResultComp:updateBattleResult(arg_4_1, arg_4_2)
	if not arg_4_2 then
		self:setVisible(false)

		return
	end

	self:setVisible(true)

	local var_4_0 = g.core.model.User.obtData:getUserBattleTeamIndex(arg_4_1.attack)
	local var_4_1 = var_4_0.user or {}
	local var_4_2 = g.core.model.User.obtData:getUserBattleTeamIndex(arg_4_1.victim)

	if var_4_0 and var_4_2 then
		self.m_fightValueRate:setText(string.format("%.2f%%", ((var_4_1.fight_value or 0) / ((var_4_2.user or {}).fight_value or 0) - 1) * 100))
	end

	local var_4_4 = arg_4_2.winCount or 0
	local var_4_5 = g.core.model.User.obtData:getOnceBattleCount()

	self.m_averageRound:setText(arg_4_2.averageRound)
	self.m_maxRound:setText(arg_4_2.maxRound)
	self.m_winCount:setText(var_4_5 - var_4_4 .. "/" .. var_4_5)
	self.m_winRate:setText((1 - var_4_4 / var_4_5) * 100 .. "%")

	self._highRoundList = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_2.highRoundDict or {}) do
		table.insert(self._highRoundList, {
			battleIndex = iter_4_0,
			round = iter_4_1
		})
	end

	self.m_highRoundList:setNumItems(#self._highRoundList)
end

return ObtResultComp
