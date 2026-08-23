local var_0_0 = g.core.config.passive_skill_info
local var_0_1 = g.core.model.User.knightTissueData
local KnightTissuePassiveCell = class("KnightTissuePassiveCell", require("app.fairyGUI.knightTissue.UI_KnightTissuePassiveCell"))

function KnightTissuePassiveCell:updatePassive(arg_1_1)
	local var_1_0 = var_0_1:getKnightTissueLevel(arg_1_1.id)
	local var_1_1 = var_0_0.get(arg_1_1.skill_id)
	local var_1_2, var_1_3 = g.core.utils.String.formatPassiveSkillDesc(arg_1_1.skill_id)

	self.m_skillNameTxt:setText(g.core.lang:get(111910, {
		skillName = var_1_1.name
	}))
	self.m_levelTxt:setText(g.core.lang:get(111914, {
		level = var_1_1.level
	}))

	if var_0_1:isKnightTissueActive(arg_1_1.id) and var_1_0 >= 0 then
		self.m_isActiveController:setSelectedIndex(var_1_0 < arg_1_1.level and 0 or 1)
	else
		self.m_isActiveController:setSelectedIndex(0)
	end

	var_1_2 = self.m_isActiveController:getSelectedIndex() == 1 and var_1_2 or g.core.utils.String.paintDescGreyColorful(var_1_2)

	self.m_skillDescTxt:setText(var_1_2)

	if arg_1_1.level == 0 then
		self.m_unLockTxt:setText(g.core.lang:get(111919))
	else
		self.m_unLockTxt:setText(g.core.lang:get(111911, {
			level = arg_1_1.level
		}))
	end
end

return KnightTissuePassiveCell
