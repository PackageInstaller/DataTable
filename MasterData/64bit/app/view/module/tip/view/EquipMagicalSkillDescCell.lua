local EquipMagicalSkillDescCell = class("EquipMagicalSkillDescCell", require("app.fairyGUI.tip.UI_EquipMagicalSkillDescCell"))

function EquipMagicalSkillDescCell:updateCell(arg_1_1)
	local var_1_0

	if arg_1_1.state == 0 then
		var_1_0 = arg_1_1.text or g.core.utils.String.paintDescGreyColorful(arg_1_1.text)
	end

	self.m_levelText:setText(arg_1_1.level)
	self.m_descText:enableRich()
	self.m_descText:setText(var_1_0, true)
	self.m_stateController:setSelectedIndex(arg_1_1.state)
end

return EquipMagicalSkillDescCell
