local var_0_0 = g.core.common.Color.A2
local var_0_2 = {
	0,
	6,
	8,
	10
}
local var_0_3 = {
	g.core.common.Color.A2,
	g.core.common.Color.A1,
	g.core.common.Color.A3,
	g.core.common.Color.A6,
	g.core.common.Color.A9
}
local var_0_4 = {
	20,
	22,
	24,
	26,
	18
}
local BaseInputTextComp = class("BaseInputTextComp", require("app.fairyGUI.base_new.UI_BaseInputTextComp"))

function BaseInputTextComp:ctor(arg_1_1)
	self._showCleatBtn = false
	self._clearCall = nil
	self._defaultTxt = self.m_lable:getText()
	self._maxLimit = var_0_2[self.m_maxLengthController:getSelectedIndex() + 1]
	self._chooseColor = var_0_3[self.m_fontColorController:getSelectedIndex() + 1]
	self._fontSize = var_0_4[self.m_fontSizeController:getSelectedIndex() + 1]

	self.m_lable:setColor(var_0_0)

	if self._maxLimit and self._maxLimit ~= 0 then
		self.m_inputText:setMaxLength(self._maxLimit)
	end

	self.m_inputText:setFontSize(self._fontSize)
	self.m_inputText:setColor(self._chooseColor)
	g.core.utils.Tools.setInputTextFont(self.m_inputText)
	self.m_inputText:addEventListener(fgui.UIEventType.Submit, handler(self, self._onInputTextEnd))
	self.m_inputText:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem))
	self.m_inputText:addEventListener(fgui.UIEventType.Changed, handler(self, self._onInputTextChanged))
	self.m_inputText:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onInputTextBegin))
	self.m_clearBtn:addClickListener(handler(self, self._onClickClearBtn))
end

function BaseInputTextComp:setShowClearBtn(arg_2_1, arg_2_2)
	self._showCleatBtn = arg_2_1
	self._clearCall = arg_2_2
end

function BaseInputTextComp:_onInputTextEnd()
	self:judgeLegal(false)
end

function BaseInputTextComp:_onClickItem()
	if self._callBack then
		self._callBack()
	end
end

function BaseInputTextComp:_onInputTextChanged()
	self:_changeLableVisible()
end

function BaseInputTextComp:_onInputTextBegin()
	self.m_lable:setVisible(false)
end

function BaseInputTextComp:judgeLegal(arg_7_1)
	print("judgeLegal")

	local var_7_0 = true
	local var_7_1 = self.m_inputText:getText()
	local var_7_2

	if string.find(var_7_1, "^%s+$") or var_7_1 == "" then
		var_7_2 = g.core.lang:get(2068)
		var_7_0 = false
	elseif g.core.utils.Black:isMatchText(var_7_1) then
		var_7_2 = g.core.lang:get(2070)
		var_7_0 = false
	elseif self._maxLimit ~= 0 and string.utf8len(var_7_1) > self._maxLimit then
		var_7_2 = g.core.lang:get(2069, {
			num = self._maxLimit
		})
		var_7_0 = false
	end

	if not var_7_0 and arg_7_1 ~= false then
		g.core.module.ModuleManager:tip(var_7_2)
	end

	self:_changeLableVisible()

	return var_7_0
end

function BaseInputTextComp:getInputStr()
	return self.m_inputText:getText()
end

function BaseInputTextComp:setInputStr(arg_9_1)
	self.m_inputText:setText(arg_9_1)

	if arg_9_1 and arg_9_1 == "" then
		self.m_lable:setVisible(true)
	end
end

function BaseInputTextComp:setClickCbk(arg_10_1)
	self._callBack = arg_10_1
end

function BaseInputTextComp:setPrompt(arg_11_1)
	self._defaultTxt = arg_11_1

	self.m_lable:setText(arg_11_1)
end

function BaseInputTextComp:setMaxLength(arg_12_1)
	self._maxLimit = arg_12_1

	self.m_inputText:setMaxLength(arg_12_1)
end

function BaseInputTextComp:_changeLableVisible()
	local var_13_0 = self.m_inputText:getText() == ""

	self.m_lable:setVisible(var_13_0 and true or false)

	if self._showCleatBtn then
		self.m_showClearBtnController:setSelectedIndex(var_13_0 and 0 or 1)
	else
		self.m_showClearBtnController:setSelectedIndex(0)
	end
end

function BaseInputTextComp:_onClickClearBtn()
	self.m_inputText:setText("")
	self.m_lable:setVisible(true)
	self.m_showClearBtnController:setSelectedIndex(0)

	if self._clearCall then
		self._clearCall()
	end
end

return BaseInputTextComp
