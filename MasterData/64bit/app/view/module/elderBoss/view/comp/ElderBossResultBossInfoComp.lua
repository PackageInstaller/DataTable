local var_0_0 = g.core.model.User.elderBossData
local var_0_1 = g.core.const.ConstMgr.ElderBossConst
local ElderBossResultBossInfoComp = class("ElderBossResultBossInfoComp", require("app.fairyGUI.elderBoss.UI_ElderBossResultBossInfoComp"))

function ElderBossResultBossInfoComp:updateBossInfo(arg_1_1)
	self.m_nameTxt:setText(arg_1_1.name)

	self._bossData = var_0_0:getBossSvrData()
	self._level = self._bossData and self._bossData.grade and math.min(self._bossData.grade, var_0_1.ELDER_BOSS_LEVEL_LIMIT) or 1

	self.m_lvTxt:setText(g.core.lang:get(120) .. self._level)
	self.m_openTimeTxt:setText(g.core.lang:get(432518))
end

return ElderBossResultBossInfoComp
