local var_0_0 = g.core.model.User.allianceTrialData
local AllianceTrialLevelCell = class("AllianceTrialLevelCell", require("app.fairyGUI.allianceTrial.UI_AllianceTrialLevelCell"))

function AllianceTrialLevelCell:updateLevelCell(arg_1_1)
	self.m_levelText:setText(g.core.lang:get(2052, {
		level = arg_1_1
	}))

	if var_0_0:isLevelFinish(arg_1_1) then
		if var_0_0:isBoxAwarded(arg_1_1) then
			self.m_levelStateController:setSelectedIndex(2)
		else
			self.m_levelStateController:setSelectedIndex(1)
		end
	else
		self.m_levelStateController:setSelectedIndex(0)
	end

	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_REFRESH_RED_POINT, false, {
		redPointComp = self.m_redPointComp,
		customData = {
			level = arg_1_1
		}
	})
end

return AllianceTrialLevelCell
