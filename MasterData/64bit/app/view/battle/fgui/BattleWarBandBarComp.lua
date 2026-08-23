local BattleConst = require("app.view.battle.const.BattleConst")
local BattlePath = require("app.view.battle.BattlePath")
local BattleWarBandBarComp = class("BattleWarBandBarComp", require("app.fairyGUI.battle.UI_BattleWarBandBarComp"))

function BattleWarBandBarComp:ctor()
	self._warBandValue = 0
	self._battleData = nil
end

function BattleWarBandBarComp:initData(arg_2_1)
	self._battleData = arg_2_1
	self._warBandValue = arg_2_1:getWarBandValue(1)

	self.m_valueBar:setFillAmount(self._warBandValue / 100)

	local var_2_0 = arg_2_1:getWarBandMaster(1)

	if var_2_0 and var_2_0.knight then
		self:setVisible(true)
		self:setWarBandIcon(var_2_0.knight.knightCfg.res_id)
	else
		self:setVisible(false)
	end
end

function BattleWarBandBarComp:setWarBandIcon(arg_3_1)
	self.m_maskIcon:setIcon((BattlePath.getBossIconPath(arg_3_1)))
end

function BattleWarBandBarComp:setWarBandValue(arg_4_1)
	self._warBandValue = arg_4_1

	self.m_valueBar:setFillAmount(self._warBandValue / 100)
end

function BattleWarBandBarComp:addWarBandValue(arg_5_1)
	self.m_effBarFull:removeAllEffect()
	self.m_effIconFull:removeAllEffect()
	self.m_effBarFull:removeAllEffect()
	self.m_effIconFulldown:removeAllEffect()

	if self._warBandValue + arg_5_1 >= 100 then
		self.m_effBarFull:addEffectSpine({
			isLoop = true,
			remove = false,
			name = "eff_ui_battleWarBand_barfull"
		})
		self.m_effIconFull:addEffectSpine({
			name = "eff_ui_battleWarBand_iconfull",
			remove = false,
			anim = "up",
			isLoop = true
		})
		self.m_effIconFulldown:addEffectSpine({
			name = "eff_ui_battleWarBand_iconfull",
			remove = false,
			anim = "down",
			isLoop = true
		})
	end

	if self._warBandValue < 100 and self._warBandValue + arg_5_1 >= 100 then
		self.m_effIconLight:addEffectSpine({
			name = "eff_ui_battleWarBand_iconlight",
			remove = true,
			anim = "play",
			isLoop = false
		})
	end

	self._warBandValue = self._warBandValue + arg_5_1

	if self._warBandValue < 0 then
		self._warBandValue = 0
	end

	if self._warBandValue > 100 then
		self._warBandValue = 100
	end

	self.m_valueBar:setFillAmount(self._warBandValue / 100)
end

function BattleWarBandBarComp:updateGrayStatue()
	local var_6_0 = self._battleData:getWarBandMaster(1)

	if var_6_0 and var_6_0.knight and var_6_0.knight.isDead then
		self.m_isGrayController:setSelectedIndex(1)
	else
		self.m_isGrayController:setSelectedIndex(0)
	end
end

return BattleWarBandBarComp
