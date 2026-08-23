local EquipSuitMagicalSkillComp = class("EquipSuitMagicalSkillComp", require("app.fairyGUI.equipAndTreasure.UI_EquipSuitMagicalSkillComp"))

function EquipSuitMagicalSkillComp:ctor()
	self._skillTips = {}

	self.m_skillIcon:addClickListener(handler(self, self._onSkillClick))
end

function EquipSuitMagicalSkillComp:updateSuitSKill(arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = g.core.config.skill_info.get(g.core.config.passive_skill_info.get(arg_2_1).passive_skill_value)

	self.m_skillIcon:updateIcon({
		skillId = var_2_0.id
	})
	self.m_skillDesc:updateSkillDesc({
		enableRich = true,
		name = var_2_0.curtain_name,
		desc = g.core.utils.String.formatPassiveSkillDesc(var_2_0.id)
	})

	self._skillTip = {
		skillId = var_2_0.id,
		suitId = arg_2_2,
		stage = arg_2_3
	}
end

function EquipSuitMagicalSkillComp:_onSkillClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.EquipMagicalSkillDescTip").new(self._skillTip), {
		touchDisappear = true
	})
end

return EquipSuitMagicalSkillComp
