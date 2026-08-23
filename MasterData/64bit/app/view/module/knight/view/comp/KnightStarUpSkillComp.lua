local var_0_0 = g.core.config.skill_info
local var_0_1 = g.core.config.passive_skill_info
local KnightStarUpSkillComp = class("KnightStarUpSkillComp", require("app.fairyGUI.knight.UI_KnightStarUpSkillComp"))

function KnightStarUpSkillComp:ctor()
	self._skillTip = nil
	self._skillId = 0

	self.m_skillIcon:addClickListener(handler(self, self._onSkillClick))
end

function KnightStarUpSkillComp:updateSkill(arg_2_1)
	self._skillTip = arg_2_1
	self._skillId = arg_2_1.skillId

	local var_2_0

	if arg_2_1.isPassive then
		self._skillId = var_0_1.get(self._skillId).passive_skill_value
		var_2_0 = {}
	end

	var_2_0.name = var_0_0.get(self._skillId).curtain_name

	self.m_skillName:setText(g.core.lang:get(201029, var_2_0))
	self.m_skillIcon:setGrayed(not (arg_2_1.isActive ~= false))
	self.m_skillIcon:updateIcon({
		skillId = self._skillId
	})
end

function KnightStarUpSkillComp:_onSkillClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.KnightSkillDescTip").new(self._skillTip), {
		touchDisappear = true
	})
end

return KnightStarUpSkillComp
