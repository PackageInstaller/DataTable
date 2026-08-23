local PetSkillDescComp = class("PetSkillDescComp", require("app.fairyGUI.tip.UI_PetSkillDescComp"))
local var_0_1 = g.core.config.passive_skill_info
local var_0_2 = g.core.config.skill_info
local var_0_3 = g.core.model.User.petsData
local var_0_4 = g.core.model.User.knightsData
local var_0_5 = {
	isActive = 0,
	notActive = 1
}

function PetSkillDescComp:ctor()
	self._skillsDescData = {}
	self._skillType = 0

	self.m_descList:setIniter()
	self.m_descList:setItemRendererAsync1(handler(self, self._onItemRenderer), 0.1, true)
end

function PetSkillDescComp:updateComp(arg_2_1)
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

	if not arg_2_1.isForceStyle then
		if var_2_0.skill_type == 6 then
			self:updateActiveSkill(arg_2_1)
		elseif var_2_0.skill_type == 14 then
			if arg_2_1.skillType == 113 then
				self:updateLinkSkill(arg_2_1)
			elseif arg_2_1.skillType == 117 then
				self:updatePassiveSkill(arg_2_1)
			end
		elseif var_2_0.skill_type == 7 and arg_2_1.skillType == 117 then
			self:updatePassiveSkill(arg_2_1)
		end
	else
		self.m_skillIcon.m_levelShowTypeController:setSelectedIndex(1)
	end
end

function PetSkillDescComp:updateActiveSkill(arg_3_1)
	self._skillsDescData = {}

	local var_3_0 = arg_3_1.customSkillArray

	if not arg_3_1.customSkillArray then
		local var_3_1, var_3_2 = var_0_3:getPetByAdvanceId(arg_3_1.petAdvId):getActiveSkillArr()

		var_3_0 = var_3_2
	end

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		local var_3_3 = {}
		local var_3_4 = var_0_2.get(var_0_1.get(iter_3_1.skillId).passive_skill_value)

		var_3_3.text = g.core.utils.String.formatPassiveSkillDesc(var_3_4.id)
		var_3_3.level = g.core.lang:get(201302, {
			level = var_3_4.level,
			star = iter_3_1.talentLevel
		})
		var_3_3.state = var_0_5.notActive

		if iter_3_1.value >= iter_3_1.talentLevel then
			var_3_3.state = var_0_5.isActive
		end

		if arg_3_1.star and arg_3_1.star >= iter_3_1.talentLevel then
			var_3_3.state = var_0_5.isActive
		end

		table.insert(self._skillsDescData, var_3_3)
	end

	self.m_descList:setNumItems1(#self._skillsDescData)
end

function PetSkillDescComp:updatePassiveSkill(arg_4_1)
	self._skillsDescData = {}

	local var_4_0 = arg_4_1.customSkillArray

	if not arg_4_1.customSkillArray then
		local var_4_1, var_4_2 = var_0_3:getPetByAdvanceId(arg_4_1.petAdvId):getPassiveArr()

		var_4_0 = var_4_2
	end

	local var_4_3 = 0

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_4 = {}
		local var_4_5 = var_0_2.get(var_0_1.get(iter_4_1.skillId).passive_skill_value)

		var_4_4.text = g.core.utils.String.formatSkillDesc(var_4_5.id)
		var_4_4.level = iter_4_0 == 1 and g.core.lang:get(201304, {
			level = var_4_5.level,
			advanceLevel = iter_4_1.talentLevel
		}) or g.core.lang:get(201305, {
			level = var_4_5.level,
			advanceLevel = iter_4_1.talentLevel
		})
		var_4_4.state = var_0_5.notActive

		if iter_4_1.value >= iter_4_1.talentLevel then
			var_4_4.state = var_0_5.isActive
		end

		if arg_4_1.stage and arg_4_1.stage >= iter_4_1.talentLevel then
			var_4_4.state = var_0_5.isActive
		end

		if var_4_3 ~= iter_4_1.skillId then
			var_4_3 = iter_4_1.skillId

			table.insert(self._skillsDescData, var_4_4)
		end
	end

	self.m_descList:setNumItems1(#self._skillsDescData)
end

function PetSkillDescComp:updateLinkSkill(arg_5_1)
	self._skillsDescData = {}

	local var_5_0 = {
		text = g.core.utils.String.formatPassiveSkillDesc(arg_5_1.skillId)
	}
	local var_5_1 = var_0_3:getPetByAdvanceId(arg_5_1.petAdvId)

	var_5_0.level = g.core.lang:get(201312, {
		name = var_0_4:getKnightByAdvanceId((var_5_1:getLinkKnightAdvId())):getName()
	})
	var_5_0.state = var_0_5.notActive

	if var_5_1:isLinkActivated() then
		var_5_0.state = var_0_5.isActive
	end

	table.insert(self._skillsDescData, var_5_0)
	self.m_descList:setNumItems1(#self._skillsDescData)
end

function PetSkillDescComp:_onItemRenderer(arg_6_1, arg_6_2)
	if self._skillsDescData[arg_6_1 + 1] then
		arg_6_2:updateCell(self._skillsDescData[arg_6_1 + 1])
	end
end

return PetSkillDescComp
