local var_0_0 = g.core.utils.String
local var_0_1 = g.core.common.Color
local var_0_2 = g.core.const.ConstMgr.AllianceConst
local AllianceHallNoticeEditComp = class("AllianceHallNoticeEditComp", require("app.fairyGUI.alliance.UI_AllianceHallNoticeEditComp"))

function AllianceHallNoticeEditComp:ctor()
	self._maxWords = 0
	self._curWords = 0

	self.m_noticeInput:addEventListener(fgui.UIEventType.Changed, handler(self, self._onInputChanged))
end

function AllianceHallNoticeEditComp:updateView(arg_2_1)
	local var_2_0 = ""

	var_2_0 = self.m_noticeTypeController:getSelectedIndex() == g.core.const.ConstMgr.AllianceConst.NOTICE_TYPE.DECLARE and g.core.lang:get(428556) or g.core.lang:get(428557)

	self.m_noticeInput:setPrompt(g.core.lang:get(428555, {
		noticeType = var_2_0,
		num = arg_2_1
	}))

	self._maxWords = arg_2_1

	self.m_textNum:setText(string.format("%d/%d", var_0_0.getCharactersNum(self.m_noticeInput:getText(), 2), arg_2_1))
end

function AllianceHallNoticeEditComp:getNoticeText()
	local var_3_0 = var_0_2.INPUT_TEXT_STATE.VALID

	if self._curWords > self._maxWords then
		var_3_0 = var_0_2.INPUT_TEXT_STATE.LONG
	end

	return self.m_noticeInput:getText(), (self._curWords == 0 or nil) and var_0_2.INPUT_TEXT_STATE.EMPTY
end

function AllianceHallNoticeEditComp:_onInputChanged()
	self._curWords = var_0_0.getCharactersNum(self.m_noticeInput:getText(), 2)

	self.m_textNum:setText(string.format("%d/%d", self._curWords, self._maxWords))

	if self._curWords > self._maxWords then
		self.m_textNum:setColor(var_0_1.A4)
	else
		self.m_textNum:setColor(var_0_1.A2)
	end
end

return AllianceHallNoticeEditComp
