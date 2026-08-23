local var_0_0 = g.core.const.ConstMgr.GuildWarConst.FightStageType
local var_0_1 = 100
local var_0_2 = {
	[g.core.const.ConstMgr.GuildWarConst.FightStageType.DEPLOY] = 12,
	[g.core.const.ConstMgr.GuildWarConst.FightStageType.FIGHTING] = 44,
	[g.core.const.ConstMgr.GuildWarConst.FightStageType.WAR_RESULT] = 76
}
local var_0_3 = g.core.model.User.guildWarData
local var_0_4 = g.core.common.ServerTime
local GWFightStageScheduleComp = class("GWFightStageScheduleComp", require("app.fairyGUI.guildWar.UI_GWFightStageScheduleComp"))

function GWFightStageScheduleComp:ctor()
	self._deployStartSecond = 0
	self._resultEndSecond = 86400

	self.m_deployTitleLabel:setTimeTxt((var_0_4:getHourTime(0)))
	self.m_fightingTitleLabel:setTimeTxt((var_0_4:getHourTime((var_0_3:getDayDeployEndTime()))))
	self.m_resultTitleLabel:setTimeTxt((var_0_4:getHourTime((var_0_3:getDayFightingEndTime()))))
	self.m_scheduleBar:setMax(var_0_1)
	self.m_scheduleBar:setValue(0)
end

function GWFightStageScheduleComp:onLoad()
	self:onCD()
end

function GWFightStageScheduleComp:onCD()
	local var_3_0 = var_0_3:getFightStageType()
	local var_3_1 = 0
	local var_3_2 = 0
	local var_3_3 = 0

	if var_3_0 == var_0_0.DEPLOY then
		var_3_1 = self._deployStartSecond
		var_3_2 = var_0_3:getDayDeployEndTime()
		var_3_3 = var_0_2[var_0_0.FIGHTING]
	elseif var_3_0 == var_0_0.FIGHTING then
		var_3_1 = var_0_3:getDayDeployEndTime()
		var_3_2 = var_0_3:getDayFightingEndTime()
		var_3_3 = var_0_2[var_0_0.WAR_RESULT]
	else
		var_3_1 = var_0_3:getDayFightingEndTime()
		var_3_2 = self._resultEndSecond
		var_3_3 = var_0_1
	end

	local var_3_4 = var_0_4:secondsFromToday() - var_3_1
	local var_3_5 = var_0_2[var_3_0]

	if var_3_2 - var_3_1 > 0 then
		var_3_5 = (var_3_3 - var_0_2[var_3_0]) * (var_3_4 / (var_3_2 - var_3_1))
		var_3_5 = math.max(0, (var_3_3 - var_0_2[var_3_0]) * (var_3_4 / (var_3_2 - var_3_1)))
		var_3_5 = (var_3_3 - var_0_2[var_3_0]) * (var_3_4 / (var_3_2 - var_3_1)) + var_0_2[var_3_0]
	end

	self.m_scheduleBar:setValue(var_3_5)
	self.m_deployTitleLabel:setHighlight(var_3_0 == var_0_0.DEPLOY)
	self.m_fightingTitleLabel:setHighlight(var_3_0 == var_0_0.FIGHTING)
	self.m_resultTitleLabel:setHighlight(var_3_0 == var_0_0.WAR_RESULT)
end

return GWFightStageScheduleComp
