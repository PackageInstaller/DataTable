local var_0_0 = g.core.const.ConstMgr.MysteryBossConst
local MysteryBossChallengePosComp = class("MysteryBossChallengePosComp", require("app.fairyGUI.mystery.UI_MysteryBossChallengePosComp"))

function MysteryBossChallengePosComp:updateChallengePosInfo(arg_1_1)
	self._boss = arg_1_1
	self._bossType = self._boss:getBossType()

	local var_1_0 = var_0_0.NORMAL_POS_NUM
	local var_1_1 = self._bossType == var_0_0.BOSS_TYPE.LIMIT and "m_limitPos" or "m_pos"

	if self._bossType == var_0_0.BOSS_TYPE.LIMIT then
		var_1_0 = var_0_0.LIMIT_POS_NUM

		self.m_bossTypeController:setSelectedIndex(1)
	else
		self.m_bossTypeController:setSelectedIndex(0)
	end

	for iter_1_0 = 1, var_1_0 do
		self[var_1_1 .. iter_1_0]:updatePosInfo(self._boss:getBossUserDataByPos(iter_1_0), self._boss, iter_1_0)
	end
end

return MysteryBossChallengePosComp
