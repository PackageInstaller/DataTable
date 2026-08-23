local RoleSkinStageTalentCell = class("RoleSkinStageTalentCell", require("app.fairyGUI.tip.UI_RoleSkinStageTalentCell"))
local var_0_3 = g.core.config.talent_skill_info

function RoleSkinStageTalentCell:updateCell(arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = var_0_3.get(arg_1_1.talentId)

	self.m_nameTitle:setText(g.core.lang:get(430516, {
		stage = arg_1_1.stage
	}))
	self.m_talentNameText:setText(var_1_0.name)
	self.m_talentUnLockTxt:setText(g.core.lang:get(430505, {
		stage = arg_1_1.stage
	}))

	if arg_1_2 then
		self.m_isActiveController:setSelectedIndex(1)
		self.m_descText:setText(var_1_0.description)
	else
		self.m_isActiveController:setSelectedIndex(0)

		if arg_1_3 then
			self.m_descText:setText(g.core.lang:get(430517, {
				desc = var_1_0.description,
				stage = arg_1_1.stage
			}))
		else
			self.m_descText:setText(g.core.lang:get(430501, {
				desc = var_1_0.description,
				level = arg_1_1.level
			}))
		end
	end
end

return RoleSkinStageTalentCell
