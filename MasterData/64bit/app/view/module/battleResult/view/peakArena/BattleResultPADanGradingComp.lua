local var_0_0 = {
	ADD = 1,
	NO = 0,
	SUB = 2
}
local BattleResultPADanGradingComp = class("BattleResultPADanGradingComp", require("app.fairyGUI.battleResult.UI_BattleResultPADanGradingComp"))

function BattleResultPADanGradingComp:update(arg_1_1)
	local var_1_0 = arg_1_1.content.score or 0
	local var_1_1 = arg_1_1.content.old_score or 0

	if var_1_0 == var_1_1 then
		self.m_scoreChangeController:setSelectedIndex(var_0_0.NO)
	elseif var_1_1 < var_1_0 then
		self.m_scoreChangeController:setSelectedIndex(var_0_0.ADD)
		self.m_scoreChangeTxt:setText(g.core.lang:get(110411, {
			num = var_1_0 - var_1_1
		}))
	else
		self.m_scoreChangeTxt:setText(g.core.lang:get(110423, {
			num = var_1_1 - var_1_0
		}))
		self.m_scoreChangeController:setSelectedIndex(var_0_0.SUB)
	end

	self.m_scoreTxt:setText(var_1_0)

	local var_1_2 = arg_1_1.content.rank or 0
	local var_1_3 = arg_1_1.oldRanking

	if arg_1_1.oldRanking == 0 or var_1_2 == var_1_3 then
		self.m_rankChangeController:setSelectedIndex(var_0_0.NO)
	elseif var_1_2 < var_1_3 then
		self.m_rankChangeController:setSelectedIndex(var_0_0.ADD)
		self.m_rankingChangeTxt:setText(g.core.lang:get(110411, {
			num = var_1_3 - var_1_2
		}))
	else
		self.m_rankChangeController:setSelectedIndex(var_0_0.SUB)
		self.m_rankingChangeTxt:setText(g.core.lang:get(110423, {
			num = var_1_2 - var_1_3
		}))
	end

	self.m_rankingTxt:setText(var_1_2)

	local var_1_4 = g.core.model.User.peakArenaData:getPALevelInfo(var_1_0)

	self.m_danGradingTxt:setText(var_1_4.name)
	self.m_danGradingLoader:setURL((g.core.common.Path:getPeakArenaDanGradingPic(var_1_4.pic)))
end

return BattleResultPADanGradingComp
