local var_0_0 = g.core.model.User.wushTowerData
local var_0_1 = g.core.config.parameter_info
local var_0_2 = g.core.const.ConstMgr.PARAMETER_CONST
local BattleResultWushTowerLoseComp = class("BattleResultWushTowerLoseComp", require("app.fairyGUI.battleResult.UI_BattleResultWushTowerLoseComp"))

function BattleResultWushTowerLoseComp:update()
	self.m_userHpTxt:setText(g.core.lang:get(408425, {
		cur = var_0_0:getChallengeNum(),
		max = var_0_1.get(var_0_2.WUSH_TOWER_FAIL_TIME).parameter
	}))
	self.m_stepCountTxt:setText((var_0_0:getCanChallengeCount()))
end

return BattleResultWushTowerLoseComp
