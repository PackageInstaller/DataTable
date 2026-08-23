local var_0_0 = g.core.config.talent_skill_info
local RoleSkinStrengthenTalentCell = class("RoleSkinStrengthenTalentCell", require("app.fairyGUI.roleSkin.UI_RoleSkinStrengthenTalentCell"))

function RoleSkinStrengthenTalentCell:ctor()
	return
end

function RoleSkinStrengthenTalentCell:updateCell(arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.get(arg_2_1.talentId)

	self.m_nameTxt:setText(g.core.lang:get(430509, {
		name = var_2_0.name
	}))

	if arg_2_2 then
		self.m_activeController:setSelectedIndex(1)
		self.m_descTxt:setText(var_2_0.description)
	else
		self.m_activeController:setSelectedIndex(0)
		self.m_descTxt:setText(g.core.lang:get(430501, {
			desc = var_2_0.description,
			level = arg_2_1.level
		}))
	end
end

return RoleSkinStrengthenTalentCell
