local var_0_0 = g.core.model.User.commonPassCardDataMgr
local var_0_1 = g.core.common.Path
local NewSlgBpBtn = class("NewSlgBpBtn", require("app.fairyGUI.newSlg.UI_NewSlgBpBtn"))

function NewSlgBpBtn:onLoad()
	g.core.event.EventManager:addEventListener(g.core.event.enum.EVENT_NET_S2C_COMMON_PASSCARD_GETINFO, handler(self, self.updateBpInfo), self)
end

function NewSlgBpBtn:updateBpInfo()
	local var_2_0 = g.core.model.User.newSlgData:getCommonPassCardActId()

	self:setVisible(var_2_0 > 0)

	if var_2_0 > 0 then
		local var_2_1 = var_0_0:getPassCardData(var_2_0)

		self:setIcon(var_0_1:getCommonPassCardIcon(var_2_1:getActivityCfg().entrance_res, 2))
		self.m_levelTxt:setText((var_2_1:getPassCardLv()))
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
			redPointComp = self.m_redPointComp,
			customData = {
				activityId = var_2_0
			}
		})

		if g.core.model.User.newSlgDevelopData:getMaxTroopNum() < g.core.model.User.newSlgData:getMaxTeamCnt() then
			self.m_isShowExtTeamController:setSelectedIndex(1)
		else
			self.m_isShowExtTeamController:setSelectedIndex(0)
		end
	end
end

return NewSlgBpBtn
