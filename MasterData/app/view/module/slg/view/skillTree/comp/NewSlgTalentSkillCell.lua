local NewSlgTalentSkillCell = class("NewSlgTalentSkillCell", require("app.fairyGUI.newSlg.UI_NewSlgTalentSkillCell"))

function NewSlgTalentSkillCell:updateSkillCell(arg_1_1)
	self.m_icon:setURL(g.core.common.Path:getTalentIcon(arg_1_1.pot_icon))
	self.m_skillName:setText(arg_1_1.pot_name)
	self.m_skillDesc:setText(arg_1_1.pot_des)
end

return NewSlgTalentSkillCell
