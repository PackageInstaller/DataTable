local var_0_0 = g.core.config.outpost_skill_info
local var_0_1 = g.core.config.outpost_passive_info
local OutpostKnightSkillDescCell = class("OutpostKnightSkillDescCell", require("app.fairyGUI.outpost.UI_OutpostKnightSkillDescCell"))

function OutpostKnightSkillDescCell:updateDesc(arg_1_1, arg_1_2)
	local var_1_0 = ((arg_1_2 or nil) and (var_0_1 or var_0_0)).get(arg_1_1.skillId)

	self.m_descText:setText((g.core.utils.String.formatCfgDescByPattern(var_1_0.description, var_1_0, arg_1_2 and "outpost_passive_info" or "outpost_skill_info")))

	local var_1_1 = "Lv." .. var_1_0.level

	if not arg_1_1.isUnlock then
		var_1_1 = var_1_1 .. g.core.lang:get(432628, {
			star = arg_1_1.star
		})
	end

	self.m_levelText:setText(var_1_1)
	self.m_stateController:setSelectedIndex(arg_1_1.isUnlock and 0 or 1)
end

return OutpostKnightSkillDescCell
