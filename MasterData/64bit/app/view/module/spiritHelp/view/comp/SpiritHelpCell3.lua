local var_0_0 = g.core.const.ConstMgr.SpiritHelpConst
local SpiritHelpCell3 = class("SpiritHelpCell3", require("app.fairyGUI.spiritHelp.UI_SpiritHelpCell3"))
local var_0_2 = 159

function SpiritHelpCell3:ctor()
	self.getSharedTrans(self, "enter_right", "CommonShortCellList", self)

	self._doingData = nil

	self.m_mindBtn:addClickListener(handler(self, self._onClickCheck))
end

function SpiritHelpCell3:_onClickCheck()
	self._doingData:setMind((self.m_mindBtn:isSelected()))
end

function SpiritHelpCell3:playAllSelectEffect()
	self.m_mainComp:playAllSelectEffect()
end

function SpiritHelpCell3:updateHelpCell(arg_4_1)
	self._doingData = arg_4_1

	self.m_mainComp:updateHelpCell(arg_4_1)
	self.m_stateController:setSelectedIndex(arg_4_1:getState())

	if arg_4_1:getState() == var_0_0.STATE.NORMAL then
		self:setHeight(var_0_2)
		self:updateHelpMoreView(arg_4_1)
	else
		self:setHeight(self.m_mainComp:getHeight())
	end
end

function SpiritHelpCell3:updateHelpMoreView(arg_5_1)
	self.m_helpTipText:setText(arg_5_1:getHelpTipText())
	self.m_mindBtn:setSelected(arg_5_1:isMind())
end

return SpiritHelpCell3
