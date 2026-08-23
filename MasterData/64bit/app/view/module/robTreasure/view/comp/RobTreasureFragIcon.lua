local RobTreasureFragIcon = class("RobTreasureFragIcon", require("app.fairyGUI.robTreasure.UI_RobTreasureFragIcon"))
local var_0_1 = g.core.common.Path

function RobTreasureFragIcon:ctor()
	self._index = nil
	self._enterTrans = self:getSharedTrans("enter", "CommonSelected", self.m_selectedImg)
	self._backTrans = self:getSharedTrans("back", "CommonSelected", self.m_selectedImg)
	self.m_buttonController = self:getController("button")

	self.m_buttonController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onChanged))
end

function RobTreasureFragIcon:updateComp(arg_2_1)
	self._index = arg_2_1.index
	self._fragData = g.core.common.Goods:convert(arg_2_1)

	self.m_quality:setURL(var_0_1:getBaseIconQualityBg(self._fragData.quality))
	self.m_treasureIcon:setURL(self._fragData.icon)

	if self._fragData.size > 0 then
		self:setTouchable(false)
		self.m_numText:setText(self._fragData.size .. "/1")
		self.m_ctrlController:setSelectedIndex(0)
		self:setSelected(false)
	else
		self:setTouchable(true)
		self.m_numText:setText(g.core.lang:get(304008))
		self.m_ctrlController:setSelectedIndex(1)
	end
end

function RobTreasureFragIcon:_onFragClick()
	if self._fragData.size <= 0 and self._index then
		self:dispatchCompEvent("RobTreasure_selectedTreasureFrag", self._index)
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(304007))
	end
end

function RobTreasureFragIcon:_onChanged()
	if self.m_buttonController:getSelectedIndex() == 0 then
		self._backTrans:play()
	else
		self._enterTrans:play()
		self:_onFragClick()
	end
end

function RobTreasureFragIcon:showEffect()
	self.m_effectHolder:addEffectSpine({
		scale = 1,
		isLoop = false,
		name = "eff_ui_transistor_fuse_01"
	})
end

return RobTreasureFragIcon
