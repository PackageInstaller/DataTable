local RedCliffSemiFinalCell = class("RedCliffSemiFinalCell", require("app.fairyGUI.redCliff.UI_RedCliffSemiFinalCell"))

function RedCliffSemiFinalCell:ctor()
	return
end

function RedCliffSemiFinalCell:updateSemiCell(arg_2_1, arg_2_2)
	self.m_bgTypeController:setSelectedIndex(arg_2_2 % 2 == 0 and 1 or 0)
	self.m_index:setText(arg_2_2 + 1)

	local var_2_0 = arg_2_1.user

	self.m_isSelfController:setSelectedIndex(g.core.model.User:getId() == arg_2_1.id and 1 or 0)
	self.m_headIcon:updateAsUser(var_2_0)
	self.m_name:setText(var_2_0.name)
	self.m_server:setText(var_2_0.server_name)
	self.m_fightValue:setText(var_2_0.fight_value)
end

return RedCliffSemiFinalCell
