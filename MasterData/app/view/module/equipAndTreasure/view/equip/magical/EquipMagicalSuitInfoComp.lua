local var_0_0 = g.core.model.User.equipmentData
local EquipMagicalSuitInfoComp = class("EquipMagicalSuitInfoComp", require("app.fairyGUI.equipAndTreasure.UI_EquipMagicalSuitInfoComp"))

function EquipMagicalSuitInfoComp:ctor()
	self._suitId = 0
	self._equip = nil
	self._skillTip = {}

	self.m_skillIcon:addClickListener(handler(self, self._onSkillClick))
end

function EquipMagicalSuitInfoComp:updateView(arg_2_1)
	self._equip = arg_2_1.equip

	local var_2_0 = self._equip:getSuitId()
	local var_2_1 = arg_2_1.suitActiveMap[var_2_0]
	local var_2_2 = var_0_0:getFourSuitSkillId(var_2_0, (math.clamp(arg_2_1.suitActiveMap[var_2_0].minStage, 0, self._equip:getMaxMagicalStage())))

	self.m_suitStage1:updateView(arg_2_1.suitActiveMap[var_2_0], self._equip)
	self.m_suitStage2:updateView(var_2_1, self._equip)
	self.m_skillGroup:setVisible(var_2_2 > 0)

	if var_2_2 > 0 then
		local var_2_3 = g.core.config.skill_info.get(g.core.config.passive_skill_info.get(var_2_2).passive_skill_value)

		self.m_skillIcon:updateIcon({
			skillId = var_2_3.id
		})
		self.m_skillDesc:updateSkillDesc({
			enableRich = true,
			name = var_2_3.curtain_name,
			desc = g.core.utils.String.formatPassiveSkillDesc(var_2_3.id)
		})
	end

	local var_2_4 = {
		isPassive = true,
		skillId = var_2_2,
		suitId = var_2_0
	}

	var_2_4.stage = var_2_1.minStage or -1
	self._skillTip = var_2_4

	self.m_skillIcon:setGrayed(self._skillTip.stage == -1)
end

function EquipMagicalSuitInfoComp:isExpand()
	return self.m_isExpandController:getSelectedIndex() == 1
end

function EquipMagicalSuitInfoComp:playShow()
	self:setVisible(true)
	self.m_showTransition:play()
end

function EquipMagicalSuitInfoComp:playHide()
	self.m_hideTransition:play(handler(self, self._onHideAnimEnd))
end

function EquipMagicalSuitInfoComp:_onSkillClick()
	g.core.module.ModuleManager:pushPopup(require("app.view.module.tip.view.EquipMagicalSkillDescTip").new(self._skillTip), {
		touchDisappear = true
	})
end

function EquipMagicalSuitInfoComp:_onHideAnimEnd()
	self:setVisible(false)
end

return EquipMagicalSuitInfoComp
