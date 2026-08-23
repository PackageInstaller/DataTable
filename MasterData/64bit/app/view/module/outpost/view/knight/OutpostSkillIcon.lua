local var_0_0 = g.core.config.outpost_skill_info
local var_0_1 = g.core.config.outpost_passive_info
local OutpostSkillIcon = class("OutpostSkillIcon", require("app.fairyGUI.outpost.UI_OutpostSkillIcon"))

function OutpostSkillIcon:ctor()
	self.knightStruct = nil
	self._skillCfg = nil
	self._isPassive = false

	self:addClickListener(handler(self, self._onSkillClick))
end

function OutpostSkillIcon:updateSkill(arg_2_1, arg_2_2, arg_2_3)
	if arg_2_1 == 0 then
		self.m_isEmptyController:setSelectedIndex(1)

		return
	else
		self.m_isEmptyController:setSelectedIndex(0)
	end

	self._isPassive = arg_2_3
	self.knightStruct = arg_2_2

	if arg_2_3 then
		local var_2_0 = var_0_1.get(arg_2_1)

		self._skillCfg = var_2_0

		self:setIcon((g.core.common.Path:getSkillIconById(var_2_0.icon)))
		self.m_levelText:setText(var_2_0.level)
	else
		local var_2_1 = var_0_0.get(arg_2_1)

		self._skillCfg = var_2_1

		self:setIcon((g.core.common.Path:getSkillIconById(var_2_1.icon)))
		self.m_levelText:setText(var_2_1.level)
	end
end

function OutpostSkillIcon:_onSkillClick()
	if self._skillCfg then
		g.core.module.ModuleManager:pushPopup((require("app.view.module.outpost.view.knight.OutpostKnightSkillDescTip").new({
			knight = self.knightStruct,
			skill = self._skillCfg,
			isPassive = self._isPassive
		})))
	end
end

return OutpostSkillIcon
