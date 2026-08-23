local var_0_0 = {}

var_0_0.URL = "ui://7x1mja7yjd9r5ibhg"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_styleController = self:getController("style")
	self.m_Txt_dialog = self:getChild("Txt_dialog")
	self.m_Btn_confirm3 = self:getChild("Btn_confirm3")
	self.m_Btn_confirm1 = self:getChild("Btn_confirm1")
	self.m_Btn_confirm2 = self:getChild("Btn_confirm2")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.StyleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
