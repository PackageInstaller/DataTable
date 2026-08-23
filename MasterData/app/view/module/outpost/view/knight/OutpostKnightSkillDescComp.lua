local OutpostKnightSkillDescComp = class("OutpostKnightSkillDescComp", require("app.fairyGUI.outpost.UI_OutpostKnightSkillDescComp"))

function OutpostKnightSkillDescComp:ctor()
	self._allDesc = {}
	self._isPassive = false

	self.m_descList:setIniter()
	self.m_descList:setItemRenderer(handler(self, self._onDescRenderer))
end

function OutpostKnightSkillDescComp:updateSkillDesc(arg_2_1, arg_2_2, arg_2_3)
	self._isPassive = arg_2_3

	self.m_skillIcon:updateSkill(arg_2_2.id, arg_2_1, arg_2_3)
	self.m_descText:setTitle((g.core.utils.String.formatCfgDescByPattern(arg_2_2.description, arg_2_2, arg_2_3 and "outpost_passive_info" or "outpost_skill_info")))

	self._allDesc = arg_2_1:getAllLvSkills(arg_2_3 and "passive_skill_1" or "skill_2")

	self.m_descList:setNumItems(#self._allDesc)
	self.m_descList:resizeToFit(#self._allDesc)
end

function OutpostKnightSkillDescComp:_onDescRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateDesc(self._allDesc[arg_3_1 + 1], self._isPassive)
end

return OutpostKnightSkillDescComp
