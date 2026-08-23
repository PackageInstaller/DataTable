local var_0_0 = g.core.config.knight_classical_info
local var_0_1 = g.core.config.passive_skill_info
local var_0_2 = g.core.config.skill_info
local BaseClassicalDetailComp = class("BaseClassicalDetailComp", require("app.fairyGUI.infoPop.UI_BaseClassicalDetailComp"))

function BaseClassicalDetailComp:updateView(arg_1_1, arg_1_2)
	local var_1_0 = var_0_1.get(var_0_0.get(arg_1_1).passive_id)

	self.m_elemSkillNameTxt:setText(var_1_0.name)
	self.m_skillDescText:setText(var_0_2.get(var_1_0.passive_skill_value).description)

	local var_1_1 = var_0_1.get(arg_1_2.promote_passive_1_1)

	self.m_nameTitle:setText(var_1_1.name)
	self.m_descText:setText(var_0_2.get(var_1_1.passive_skill_value).description)
end

return BaseClassicalDetailComp
