local SpiritHelpCell1 = class("SpiritHelpCell1", require("app.fairyGUI.spiritHelp.UI_SpiritHelpCell1"))

function SpiritHelpCell1:ctor()
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)

	self._doingData = nil

	self.m_doCheckBtn:addClickListener(handler(self, self._onClickCheck))
	self.m_lockLoader:addEventListener(fgui.UIEventType.Click, handler(self, self._onClickLock))
end

function SpiritHelpCell1:_onClickLock()
	if self._doingData:isTip() then
		g.core.module.ModuleManager:tip(self._doingData:getTipStr())
	end
end

function SpiritHelpCell1:playAllSelectEffect()
	if self.m_stateController:getSelectedIndex() == 0 and not self.m_doCheckBtn:isSelected() then
		self.m_effectPlace:addEffectSpine({
			remove = true,
			anim = "choice",
			isLoop = false,
			name = "eff_ui_spiritHelp_mainLayer"
		})
	else
		self.m_effectPlace:removeAllEffect()
	end
end

function SpiritHelpCell1:_onClickCheck()
	local var_4_0 = self.m_doCheckBtn:isSelected()

	self._doingData:setSelect(var_4_0)

	if var_4_0 then
		self.m_effectPlace:addEffectSpine({
			remove = true,
			anim = "choice",
			isLoop = false,
			name = "eff_ui_spiritHelp_mainLayer"
		})
	end

	local var_4_1 = self._doingData:getCountCostItem()

	if var_4_1 and next(var_4_1) then
		self:dispatchCompEvent("change_count_refresh")
	end

	self:dispatchCompEvent("sub_select_change")
end

function SpiritHelpCell1:updateHelpCell(arg_5_1)
	self._doingData = arg_5_1

	self.m_title:setText(arg_5_1:getInfo().name)
	self.m_desc:setText(arg_5_1:getInfo().desc)
	self.m_doCheckBtn:setSelected(arg_5_1:isSelect())
	self.m_stateController:setSelectedIndex(arg_5_1:getState())
end

return SpiritHelpCell1
