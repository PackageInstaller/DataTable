local BattleStormStationRewardComp = class("BattleStormStationRewardComp", require("app.fairyGUI.battleResult.UI_BattleStormStationRewardComp"))

function BattleStormStationRewardComp:update(arg_1_1)
	self.m_curRankTxt:setText(arg_1_1.rank)
	self.m_upImg:setVisible(arg_1_1.rank < arg_1_1.oldRank)

	local var_1_0 = arg_1_1 and arg_1_1.enemy

	if arg_1_1.user then
		self.m_nameTxt:setText(arg_1_1.user.name)
	elseif var_1_0.robot_id > 0 then
		self.m_nameTxt:setText(g.core.config.robot_info.get(var_1_0.robot_id).name)
	end
end

return BattleStormStationRewardComp
