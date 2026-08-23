local CultivateConst = require("app.view.module.cultivate.const.CultivateConst")
local var_0_1 = g.core.common.Path
local var_0_2 = g.core.model.User.cultivateDataMgr
local var_0_3 = {
	[CultivateConst.TASK_TYPE.DAILY_TASK] = g.core.lang:get(421402),
	[CultivateConst.TASK_TYPE.ACHIEVEMENT_TASK] = g.core.lang:get(421403)
}
local CultivateTaskTab = class("CultivateTaskTab", require("app.fairyGUI.cultivate.UI_CultivateTaskTab"))

function CultivateTaskTab:onLoad()
	if self._actId and self.m_redPointComp then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				actValue = self._actId
			}
		})
	end
end

function CultivateTaskTab:updateTaskTab(arg_2_1, arg_2_2)
	if arg_2_1 == CultivateConst.TASK_TYPE.DAILY_TASK then
		self:setTitle(var_0_3[arg_2_1])
	else
		self:setTitle(g.core.config.cultivate_activity_display_info.get(arg_2_2).task_tab)
	end

	self._actData = var_0_2:getCultivateData(arg_2_2)

	local var_2_0 = self._actData:getActivityCfg()

	if var_2_0.type == CultivateConst.ACTIVITY_TYPE.WITCH then
		self.m_upLoader:setURL(var_0_1:getCultivateImage("btn_mnzj_renwutab2", var_0_2:getResDirId(var_2_0.id)))
		self.m_downLoader:setURL(var_0_1:getCultivateImage("btn_mnzj_renwutab1", var_0_2:getResDirId(var_2_0.id)))
	end
end

function CultivateTaskTab:setRedPoint(arg_3_1, arg_3_2)
	self._actId = arg_3_2

	self.m_redPointComp:setId(arg_3_1)

	if arg_3_1 and self.m_redPointComp then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				actValue = arg_3_2
			}
		})
	end
end

return CultivateTaskTab
