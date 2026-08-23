local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepl57ykk2ua"

function var_0_0:__ctor()
	self.m_maxLengthController = self:getController("maxLength")
	self.m_fontColorController = self:getController("fontColor")
	self.m_fontSizeController = self:getController("fontSize")
	self.m_showClearBtnController = self:getController("showClearBtn")
	self.m_icon = self:getChild("icon")
	self.m_lable = self:getChild("lable")
	self.m_inputText = self:getChild("inputText")
	self.m_clearBtn = self:getChild("clearBtn")
end

var_0_0.MaxLengthCtrl = {
	["0(无限制)"] = 0,
	["10"] = 3,
	["6"] = 1,
	["8"] = 2
}
var_0_0.FontColorCtrl = {
	A6 = 3,
	A3 = 2,
	A2 = 0,
	A1 = 1
}
var_0_0.FontSizeCtrl = {
	["20"] = 0,
	["22"] = 1,
	["18"] = 4,
	["24"] = 2,
	["26"] = 3
}
var_0_0.ShowClearBtnCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
