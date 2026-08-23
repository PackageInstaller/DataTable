local AncientsTeamSpoilsDetailCell = class("AncientsTeamSpoilsDetailCell", require("app.fairyGUI.ancients.UI_AncientsTeamSpoilsDetailCell"))

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0:updateCell(arg_2_1)
	self.m_Txt_curPoint:setText(arg_2_1.points)

	local var_2_0 = g.core.config.knight_info.get(arg_2_1.base_id)

	self.m_Txt_playerName:setText(arg_2_1.name)
end

return var_0_0
