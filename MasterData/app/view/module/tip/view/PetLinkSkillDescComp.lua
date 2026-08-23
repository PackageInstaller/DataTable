local PetLinkSkillDescComp = class("PetLinkSkillDescComp", require("app.fairyGUI.tip.UI_PetLinkSkillDescComp"))
local var_0_2 = g.core.config.skill_info
local var_0_3 = g.core.model.User.petsData
local var_0_4 = g.core.model.User.knightsData
local var_0_5 = {
	NOT_ACTIVE = 1,
	IS_ACTIVE = 0
}

function PetLinkSkillDescComp:ctor()
	self._skillsDescData = {}
	self._skillType = 0
end

function PetLinkSkillDescComp:updateComp(arg_2_1)
	local var_2_0 = var_0_2.get(arg_2_1.skillId)

	self.m_skillIcon:updateIcon({
		skillId = arg_2_1.skillId,
		skillExtraData = arg_2_1.skillExtraData
	})

	local var_2_1 = ""

	var_2_1 = arg_2_1.isPassive and g.core.utils.String.formatPassiveSkillDesc(arg_2_1.skillId) or g.core.utils.String.formatSkillDesc(arg_2_1.skillId)

	self.m_descText:getChild("title"):enableRich()
	self.m_descText:setTitle(var_2_1)

	self._skillType = var_2_0.skill_type

	self:updateLinkSkill(arg_2_1)
end

function PetLinkSkillDescComp:updateLinkSkill(arg_3_1)
	self._skillsDescData = {}

	local var_3_0 = {
		text = g.core.utils.String.formatPassiveSkillDesc(arg_3_1.skillId)
	}
	local var_3_1 = var_0_3:getPetByAdvanceId(arg_3_1.petAdvId)

	var_3_0.level = g.core.lang:get(201312, {
		name = var_0_4:getKnightByAdvanceId((var_3_1:getLinkKnightAdvId())):getName()
	})

	self.m_levelText:setText(var_3_0.level)

	var_3_0.state = var_0_5.NOT_ACTIVE

	if var_3_1:isLinkActivated() then
		var_3_0.state = var_0_5.IS_ACTIVE
	end

	table.insert(self._skillsDescData, var_3_0)
end

function PetLinkSkillDescComp:_onItemRenderer(arg_4_1, arg_4_2)
	if self._skillsDescData[arg_4_1 + 1] then
		arg_4_2:updateCell(self._skillsDescData[arg_4_1 + 1])
	end
end

return PetLinkSkillDescComp
