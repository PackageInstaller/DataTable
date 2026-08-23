local SpiritHelpCellMoreComp = class("SpiritHelpCellMoreComp", require("app.fairyGUI.spiritHelp.UI_SpiritHelpCellMoreComp"))

function SpiritHelpCellMoreComp:ctor()
	self._doingData = nil

	self.m_mindBtn:addClickListener(handler(self, self._onClickCheck))
end

function SpiritHelpCellMoreComp:_onClickCheck()
	self._doingData:setMind((self.m_mindBtn:isSelected()))
end

function SpiritHelpCellMoreComp:_changeNum()
	return
end

function SpiritHelpCellMoreComp:updateHelpMoreComp(arg_4_1)
	self.m_addComp:initMinMaxNum({
		max = arg_4_1:getMaxCount(),
		cur = arg_4_1:getCurCount(),
		callback = handler(self, self._changeNum)
	})
	self.m_hasTipController:setSelectedIndex(arg_4_1:hasHelpBtn())
	self.m_mindBtn:setSelected(arg_4_1:isMind())
end

return SpiritHelpCellMoreComp
