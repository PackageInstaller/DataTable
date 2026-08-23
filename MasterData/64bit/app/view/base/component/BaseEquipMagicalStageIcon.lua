local BaseEquipMagicalStageIcon = class("BaseEquipMagicalStageIcon", require("app.fairyGUI.base_new.UI_BaseEquipMagicalStageIcon"))

function BaseEquipMagicalStageIcon:ctor()
	self._effCircle = nil
	self._effDiamond = nil
	self._effActivity = nil
end

function BaseEquipMagicalStageIcon:_playCircleEff(arg_2_1)
	self.m_effCircle:setVisible(true)
	self.m_effDiamond:setVisible(false)

	local var_2_0 = self.m_equipQualityController:getSelectedIndex() == 0 and "eff_ui_equip_circle" or "eff_ui_equip_circleMR"

	if not self._effCircle then
		self._effCircle = self.m_effCircle:addEffectSpine({
			remove = false,
			isLoop = true,
			name = var_2_0,
			anim = arg_2_1
		})
	elseif self._effCircle:getResId() ~= var_2_0 then
		self.m_effCircle:removeAllEffect()

		self._effCircle = self.m_effCircle:addEffectSpine({
			remove = false,
			isLoop = true,
			name = var_2_0,
			anim = arg_2_1
		})
	end
end

function BaseEquipMagicalStageIcon:_playDiamondEff(arg_3_1)
	self.m_effCircle:setVisible(false)
	self.m_effDiamond:setVisible(true)

	local var_3_0 = self.m_equipQualityController:getSelectedIndex() == 0 and "eff_ui_equip_diamond" or "eff_ui_equip_diamondMR"

	if not self._effDiamond then
		self._effDiamond = self.m_effDiamond:addEffectSpine({
			remove = false,
			isLoop = true,
			name = var_3_0,
			anim = arg_3_1
		})
	elseif self._effDiamond:getResId() ~= var_3_0 then
		self.m_effDiamond:removeAllEffect()

		self._effDiamond = self.m_effDiamond:addEffectSpine({
			remove = false,
			isLoop = true,
			name = var_3_0,
			anim = arg_3_1
		})
	end
end

function BaseEquipMagicalStageIcon:playActiveEff()
	if self.m_equipTypeController:getSelectedIndex() == g.core.const.ConstMgr.EquipConst.EQUIP_TYPE.ATTACK then
		self:_playDiamondEff("play")
	else
		self:_playCircleEff("play")
	end
end

function BaseEquipMagicalStageIcon:playNextActiveEff()
	if self.m_equipTypeController:getSelectedIndex() == g.core.const.ConstMgr.EquipConst.EQUIP_TYPE.ATTACK then
		self:_playDiamondEff("play2")
	else
		self:_playCircleEff("play2")
	end
end

function BaseEquipMagicalStageIcon:hideEff()
	self.m_effDiamond:setVisible(false)
	self.m_effCircle:setVisible(false)
end

function BaseEquipMagicalStageIcon:playMagicalStageUpEff()
	local var_7_0 = self.m_equipQualityController:getSelectedIndex() == 0 and "eff_ui_equip_activity" or "eff_ui_equip_activityMR"
	local var_7_1 = self.m_equipTypeController:getSelectedIndex() == 0 and "play_diamond" or "play_circle"

	if not self._effActivity then
		self._effActivity = self.m_effActivity:addEffectSpine({
			remove = true,
			isLoop = false,
			name = var_7_0,
			anim = var_7_1
		})
	elseif self._effActivity:getResId() ~= var_7_0 then
		self.m_effActivity:removeAllEffect()

		self._effActivity = self.m_effActivity:addEffectSpine({
			remove = true,
			isLoop = false,
			name = var_7_0,
			anim = var_7_1
		})
	end
end

return BaseEquipMagicalStageIcon
