local PetAdvSuccessPopComp = class("PetAdvSuccessPopComp", require("app.fairyGUI.pet.UI_PetAdvSuccessPopComp"))

function PetAdvSuccessPopComp:update(arg_1_1)
	local var_1_1 = g.core.model.User.petsData:getPetBySid(arg_1_1.petSid or 0)

	if not var_1_1 then
		return
	end

	local var_1_2 = var_1_1:getBigSmallStage()

	self.m_levelTxt:setText(var_1_2)

	local var_1_3 = math.max(0, var_1_2 - 1)

	self.m_lastLevelTxt:setText(var_1_3)

	local var_1_4 = var_1_1:getAdvCfg()
	local var_1_5 = g.core.config.talent_skill_info.get(var_1_4.talent_skill_1)

	self.m_talentNameLbl:setTitle(var_1_5.name)
	self.m_talentDescTxt:setText(var_1_5.description)
	self.m_passiveActiveController:setSelectedIndex(var_1_3 == 0 and 1 or 0)
	self.m_passiveNameLbl:setTitle(g.core.config.skill_info.get(g.core.config.passive_skill_info.get(var_1_4.skill_1).passive_skill_value).curtain_name)
	self.m_passiveDescVerScrollLbl:getChild("title"):enableRich()
	self.m_passiveDescVerScrollLbl:setTitle((g.core.utils.String.formatPassiveSkillDesc(var_1_4.skill_1)))
	self.m_passiveChangeController:setSelectedIndex(var_1_1:isSkillChangeFromLastStage() and 1 or 0)
	self.m_enterTransition:play()
end

return PetAdvSuccessPopComp
