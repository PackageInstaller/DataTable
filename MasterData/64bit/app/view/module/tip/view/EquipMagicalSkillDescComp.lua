local EquipMagicalSkillDescComp = class("EquipMagicalSkillDescComp", require("app.fairyGUI.tip.UI_EquipMagicalSkillDescComp"))
local var_0_2 = g.core.config.skill_info
local BaseConst = require("app.view.base.const.BaseConst")
local var_0_5 = g.core.const.ConstMgr.SkillConst
local var_0_7 = g.core.model.User.equipmentData

function EquipMagicalSkillDescComp:ctor()
	self._skillsDescData = {}
	self._param = {}
	self._skillType = 0

	self.m_descList:setIniter()
	self.m_descList:setItemRendererAsync1(handler(self, self._onItemRenderer), 0.1, true)
end

function EquipMagicalSkillDescComp:updateComp(arg_2_1)
	if not arg_2_1 then
		return
	end

	self._param = arg_2_1

	local var_2_0 = var_0_2.get(arg_2_1.skillId)

	self.m_skillIcon:updateIcon({
		skillId = arg_2_1.skillId,
		isPassive = arg_2_1.isPassive
	})

	local var_2_1 = ""

	var_2_1 = arg_2_1.isPassive and g.core.utils.String.formatPassiveSkillDesc(arg_2_1.skillId) or g.core.utils.String.formatSkillDesc(arg_2_1.skillId)

	self.m_descText:getChild("title"):enableRich()
	self.m_descText:setTitle(var_2_1)

	self._skillType = var_2_0.skill_type

	self:_updatePassiveSkill(arg_2_1)
end

function EquipMagicalSkillDescComp:_updatePassiveSkill(arg_3_1)
	self._skillsDescData = {}

	local var_3_1 = g.core.config.equipment_suit_info.get(arg_3_1.suitId)

	for iter_3_0, iter_3_1 in pairs((var_0_7:getFourSuitSkillList(arg_3_1.suitId))) do
		local var_3_2 = {
			text = g.core.utils.String.formatPassiveSkillDesc(iter_3_1.skillId),
			level = g.core.lang:get(201671, {
				level = iter_3_1.stage
			})
		}

		if arg_3_1.stage >= iter_3_1.stage then
			var_3_2.state = var_0_5.SKILL_STATE.IS_ACTIVE or var_0_5.SKILL_STATE.NOT_ACTIVE
		end

		if var_3_2.state ~= var_0_5.SKILL_STATE.IS_ACTIVE then
			var_3_2.level = g.core.lang:get(201672, {
				name = var_3_1.name,
				level = iter_3_1.stage,
				stage = iter_3_1.stage
			})
		end

		table.insert(self._skillsDescData, var_3_2)
	end

	self.m_descList:setNumItems(#self._skillsDescData)
end

function EquipMagicalSkillDescComp:_onItemRenderer(arg_4_1, arg_4_2)
	if self._skillsDescData[arg_4_1 + 1] then
		arg_4_2:updateCell(self._skillsDescData[arg_4_1 + 1])
	end
end

return EquipMagicalSkillDescComp
