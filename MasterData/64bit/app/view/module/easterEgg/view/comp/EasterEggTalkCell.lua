local EasterEggTalkCell = class("EasterEggTalkCell", require("app.fairyGUI.easterEgg.UI_EasterEggTalkCell"))

function EasterEggTalkCell:ctor()
	self._clickCall = nil
	self._index = 0

	self.m_clickComp:addClickListener(handler(self, self._onSelectIndex))
	self.getSharedTrans(self, "enter_left", "CommonLongCellList", self)
end

function EasterEggTalkCell:update(arg_2_1, arg_2_2)
	self._index = arg_2_1.index

	self.m_talkText:setText(arg_2_1.talkStr)

	self._clickCall = arg_2_2
end

function EasterEggTalkCell:_onSelectIndex()
	if self._clickCall then
		self._clickCall(self._index)
	end
end

return EasterEggTalkCell
