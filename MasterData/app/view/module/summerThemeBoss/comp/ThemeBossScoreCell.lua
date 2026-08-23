local var_0_0 = g.core.model.User.themeData
local ThemeBossScoreCell = class("ThemeBossScoreCell", require("app.fairyGUI.summerThemeBoss.UI_ThemeBossScoreCell"))

function ThemeBossScoreCell:updateScoreCell(arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_1 then
		self.m_stateController:setSelectedIndex(0)

		return
	end

	local var_1_0 = var_0_0:getThemeData(arg_1_3):getBossData()

	if var_1_0:getTotalScore() < arg_1_1.integral_demand then
		local var_1_1, var_1_2 = var_1_0:getShowAwardInfo()

		if var_1_2 == arg_1_2 then
			self.m_stateController:setSelectedIndex(2)
		else
			self.m_stateController:setSelectedIndex(3)
		end
	else
		local var_1_3, var_1_4 = var_1_0:getShowAwardInfo()

		if var_1_4 == arg_1_2 then
			self.m_stateController:setSelectedIndex(2)
		elseif var_1_0:isGetAwardById(arg_1_1.id) then
			self.m_stateController:setSelectedIndex(1)
		else
			self.m_stateController:setSelectedIndex(3)
		end
	end

	self.m_scoreText1:setText(arg_1_1.integral_demand)
	self.m_scoreText2:setText(arg_1_1.integral_demand)
end

return ThemeBossScoreCell
