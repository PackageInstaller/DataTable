local BattleResultMineRewardComp = class("BattleResultMineRewardComp", require("app.fairyGUI.battleResult.UI_BattleResultMineRewardComp"))

function BattleResultMineRewardComp:update(arg_1_1)
	self.m_myHpTxt:setText(arg_1_1.selfResult.powerAfter)
	self.m_otherHpTxt:setText(arg_1_1.enemyResult.powerAfter)

	local var_1_0 = arg_1_1.enemyResult.powerBefore - arg_1_1.enemyResult.powerAfter

	self.m_myShield:setVisible(checkbool(arg_1_1.selfResult.shieldStage))
	self.m_otherShield:setVisible(checkbool(arg_1_1.enemyResult.shieldStage))

	if arg_1_1.selfResult.powerBefore - arg_1_1.selfResult.powerAfter ~= 0 then
		self.m_myGroup:setVisible(true)
		self.m_myHpDownTxt:setText(arg_1_1.selfResult.powerBefore - arg_1_1.selfResult.powerAfter .. ")")
	else
		self.m_myGroup:setVisible(false)
	end

	if var_1_0 ~= 0 then
		self.m_otherGroup:setVisible(true)
		self.m_otherHpDownTxt:setText(var_1_0 .. ")")
	else
		self.m_otherGroup:setVisible(false)
	end
end

return BattleResultMineRewardComp
