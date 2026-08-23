local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcggvw6z"

function var_0_0:__ctor()
	self.m_showBgController = self:getController("showBg")
	self.m_level = self:getChild("level")
	self.m_num1 = self:getChild("num1")
	self.m_num2 = self:getChild("num2")
end

var_0_0.ShowBgCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
