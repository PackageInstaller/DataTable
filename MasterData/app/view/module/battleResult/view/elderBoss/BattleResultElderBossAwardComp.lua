local BattleResultElderBossAwardComp = class("BattleResultElderBossAwardComp", require("app.fairyGUI.battleResult.UI_BattleResultElderBossAwardComp"))

function BattleResultElderBossAwardComp:ctor()
	self._awards = {}

	self.m_awardList:setVirtual()
	self.m_awardList:setItemRenderer(handler(self, self._onAwardRenderer))
end

function BattleResultElderBossAwardComp:update(arg_2_1)
	self.m_damageTxt:setText(arg_2_1.content.damage)
	self.m_getScoreTxt:setText(arg_2_1.content.honor)
	self.m_maxRankTxt:setText(arg_2_1.content.new_max_rank)

	local var_2_0 = g.core.model.User.elderBossData:getMaxDamage()

	g.core.model.User.elderBossData:setMaxDamage(math.max(var_2_0, arg_2_1.content.damage))
	self.m_newImg:setVisible(var_2_0 < arg_2_1.content.damage)
	self.m_curRankUpImg:setVisible((arg_2_1.content.old_max_rank == 0 and 99999 or arg_2_1.content.old_max_rank) > arg_2_1.content.new_max_rank)
	self.m_historyRankDamageTxt:setText(arg_2_1.content.new_total_rank)
	self.m_historyRankUpImg:setVisible((arg_2_1.content.old_total_rank == 0 and 99999 or arg_2_1.content.old_total_rank) > arg_2_1.content.new_total_rank)
	table.insertto(self._awards, arg_2_1.content.challenge_awards)

	if arg_2_1.content.lucky_awards then
		table.insertto(self._awards, arg_2_1.content.lucky_awards)
	end

	self.m_awardList:setNumItems(#self._awards)
end

function BattleResultElderBossAwardComp:_onAwardRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateIcon(self._awards[arg_3_1 + 1])
end

return BattleResultElderBossAwardComp
