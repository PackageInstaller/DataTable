local var_0_0 = g.core.model.User.guildWarData
local var_0_1 = g.core.const.ConstMgr.GuildWarConst
local GuildWarTimeStageComp = class("GuildWarTimeStageComp", require("app.fairyGUI.guildWar.UI_GuildWarTimeStageComp"))

function GuildWarTimeStageComp:updateStage()
	if var_0_0:getMyGroup() == var_0_1.GROUP_TYPE.FIRED then
		self.m_groupController:setSelectedIndex(0)
	else
		self.m_groupController:setSelectedIndex(1)
	end

	self.m_schedulerComp:onCD()
end

function GuildWarTimeStageComp:onCD()
	self.m_schedulerComp:onCD()
end

function GuildWarTimeStageComp:getTimeObject(arg_3_1)
	return {
		day = (arg_3_1 - arg_3_1 % 86400) / 86400,
		hour = (arg_3_1 - (arg_3_1 - arg_3_1 % 86400) / 86400 * 86400 - arg_3_1 % 3600) / 3600,
		minute = math.floor(arg_3_1 / 60) % 60,
		second = arg_3_1 % 60
	}
end

return GuildWarTimeStageComp
