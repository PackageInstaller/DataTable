local var_0_0 = g.core.model.User.spiritHelpData
local SpiritHelpBattleSpeedSlider = class("SpiritHelpBattleSpeedSlider", require("app.fairyGUI.spiritHelp.UI_SpiritHelpBattleSpeedSlider"))
local var_0_2 = 306

function SpiritHelpBattleSpeedSlider:ctor()
	self._lineList = {}
	self._isChanged = false

	self:addEventListener(fgui.UIEventType.Changed, handler(self, self._onSpeedChanged))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self:addEventListener(fgui.UIEventType.TouchEnd, handler(self, self.onSpeedChangedEnd))
	self:getChild("grip"):addEventListener(fgui.UIEventType.TouchEnd, handler(self, self.onSpeedChangedEnd))
end

function SpiritHelpBattleSpeedSlider:_onTouchBegin(arg_2_1)
	arg_2_1:captureTouch()
end

function SpiritHelpBattleSpeedSlider:_onClickSpeedCheck()
	var_0_0:setHasBattleSpeed((self.m_speedBtn:isSelected()))
end

function SpiritHelpBattleSpeedSlider:updateView()
	local var_4_0 = var_0_0:getMaxBattleSpeed()

	self:_updateLine(var_4_0)
	self:setMin(0)
	self:setMax(var_4_0 - 1)

	local var_4_1 = var_0_0:getBattleSpeed()

	self.m_speedText:setText(var_4_1)
	self:setValue(var_4_1 - 1)
end

function SpiritHelpBattleSpeedSlider:_updateLine(arg_5_1)
	for iter_5_0 = 1, math.max(#self._lineList, arg_5_1 - 2) do
		local var_5_0 = self._lineList[iter_5_0]

		if not self._lineList[iter_5_0] then
			var_5_0 = fgui.GLoader:create()

			var_5_0:setAutoSize(true)
			var_5_0:setURL("ui://spiritHelp/pic_fengexian")

			self._lineList[iter_5_0] = var_5_0

			self.m_linePlace:addChild(var_5_0)
		end

		if iter_5_0 <= arg_5_1 - 2 then
			var_5_0:setX(var_0_2 / (arg_5_1 - 1) * iter_5_0)
			var_5_0:setVisible(true)
		else
			var_5_0:setVisible(false)
		end
	end
end

function SpiritHelpBattleSpeedSlider:_onSpeedChanged()
	self._isChanged = true

	self.m_speedText:setText(math.floor(self:getValue() + 0.5) + 1)
	self:dispatchCompEvent("slider_speed_change_ing")
end

function SpiritHelpBattleSpeedSlider:onSpeedChangedEnd()
	if self._isChanged then
		self._isChanged = false
	else
		return
	end

	local var_7_0 = math.floor(self:getValue() + 0.5)

	self:setValue(var_7_0)

	local var_7_1 = var_7_0 + 1

	self.m_speedText:setText(var_7_0 + 1)

	local var_7_2 = var_0_0:getBattleSpeed()

	var_0_0:setBattleSpeed(var_7_1)
	self:dispatchCompEvent("slider_speed_change_end")

	if var_7_2 ~= var_7_1 then
		self.m_effectPlace:addEffectSpine({
			name = "eff_ui_spiritHelp_mainLayer",
			remove = true,
			isLoop = false,
			anim = var_7_1 < var_7_2 and "slow" or "quick"
		})
	end
end

return SpiritHelpBattleSpeedSlider
