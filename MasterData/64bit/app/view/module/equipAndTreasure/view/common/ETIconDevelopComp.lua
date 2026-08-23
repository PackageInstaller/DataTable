local var_0_0 = g.core.common.Path
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local BaseEquipIcon = require("app.view.base.icon.BaseEquipIcon")
local ETIconDevelopComp = class("ETIconDevelopComp", require("app.fairyGUI.equipAndTreasure.UI_ETIconDevelopComp"))

function ETIconDevelopComp:ctor()
	self._state = 0
	self._effectName = "eff_ui_lineup_iconcell_1"

	self:getController("button"):addEventListener(fgui.UIEventType.Changed, handler(self, self._onButtonChange))
	BaseEquipIcon.ctor(self)
	self:setQualityEffectEnable(true)
end

function ETIconDevelopComp:setQuality(arg_2_1, arg_2_2, arg_2_3)
	self:updateEquipQualityEffect(arg_2_1, arg_2_3)

	if self._quality == arg_2_1 and arg_2_1 ~= var_0_1.NONE then
		return
	end

	self._quality = arg_2_1

	local var_2_0, var_2_1, var_2_2 = var_0_0:getLineUpQualityBg(arg_2_1)

	self.m_qualityBg:setURL(var_2_0)
	self.m_qualitySelectBgLeft:setURL(var_2_1)
	self.m_qualitySelectBgRight:setURL(var_2_2)
end

function ETIconDevelopComp:_onButtonChange()
	local var_3_0 = self:getController("button"):getSelectedIndex()

	if var_3_0 == 1 and self._state ~= var_3_0 then
		self._effectName = "eff_ui_lineup_iconcell_" .. math.clamp(self._quality, var_0_1.NONE, var_0_1.MAX_QUALITY) + 1

		self.m_effectHolder:addEffectSpine({
			scale = 1,
			isLoop = false,
			remove = true,
			name = self._effectName
		})
	end

	self._state = var_3_0
end

function ETIconDevelopComp:playUpgradeAnim()
	self._effectName = "eff_ui_lineup_iconcell_" .. math.clamp(self._quality, var_0_1.NONE, var_0_1.MAX_QUALITY) + 1

	self.m_effectHolder:addEffectSpine({
		scale = 1,
		isLoop = false,
		remove = true,
		name = self._effectName
	})
end

function ETIconDevelopComp:setResonanceLevel(arg_5_1)
	if arg_5_1 then
		self.m_showResonanceController:setSelectedIndex(1)
		self.m_resonanceLevelComp:setResonanceLevel(arg_5_1)
	else
		self.m_showResonanceController:setSelectedIndex(0)
	end
end

return ETIconDevelopComp
