local GveInstituteAttrSkillCell = class("GveInstituteAttrSkillCell", require("app.fairyGUI.gve.UI_GveInstituteAttrSkillCell"))

function GveInstituteAttrSkillCell:updateItem(arg_1_1, arg_1_2)
	if arg_1_2 then
		self.m_activeController:setSelectedIndex(0)
	else
		self.m_activeController:setSelectedIndex(1)
	end

	local var_1_0 = g.core.config.skill_info.get(arg_1_1)

	self.m_titleTxt:setText(g.core.lang:get(309178, {
		name = var_1_0.curtain_name,
		lv = var_1_0.level
	}))
	self.m_descTxt:setText(var_1_0.description)
end

return GveInstituteAttrSkillCell
