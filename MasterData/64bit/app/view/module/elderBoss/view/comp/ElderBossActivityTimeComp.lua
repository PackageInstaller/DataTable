local var_0_0 = g.core.model.User.elderBossData
local var_0_1 = g.core.common.ServerTime
local ElderBossActivityTimeComp = class("ElderBossActivityTimeComp", require("app.fairyGUI.elderBoss.UI_ElderBossActivityTimeComp"))

function ElderBossActivityTimeComp:updateActivityTime()
	self.m_activityTimeTxt:setText((var_0_1:getActivityLeftTime(math.max(0, var_0_0:getCurStageFinishTime() - var_0_1:getTime()))))
end

return ElderBossActivityTimeComp
