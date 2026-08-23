local EquipResonanceSkillCell = class("EquipResonanceSkillCell", require("app.fairyGUI.infoPop.UI_EquipResonanceSkillCell"))

function EquipResonanceSkillCell:ctor()
	return
end

function EquipResonanceSkillCell:updateSkillCell(arg_2_1)
	local var_2_0 = arg_2_1.level or 0
	local var_2_1 = arg_2_1.levelName or ""
	local var_2_2 = arg_2_1.talent or 0

	if var_2_2 == 0 then
		return
	end

	local var_2_3 = g.core.lang
	local var_2_4 = g.core.config.talent_skill_info.get(var_2_2)

	self.m_levelComp:setResonanceLevel(var_2_0)
	self.m_skillNameTxt:setText(var_2_3:get(201604, {
		str = var_2_4.name
	}))
	self.m_skillDescTxt:setText(var_2_3:get(201604, {
		str = var_2_4.description
	}))
	self.m_unlockTxt:setText(var_2_3:get(201603, {
		level = var_2_1
	}))
end

function EquipResonanceSkillCell:setActive(arg_3_1)
	self.m_activeController:setSelectedIndex(arg_3_1 and 1 or 0)
end

function EquipResonanceSkillCell:onLoad()
	return
end

function EquipResonanceSkillCell:onUnload()
	return
end

return EquipResonanceSkillCell
