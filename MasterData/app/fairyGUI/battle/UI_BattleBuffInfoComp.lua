local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2m3et9f"

function var_0_0:__ctor()
	self.m_showController = self:getController("show")
	self.m_buffList = self:getChild("buffList")
	self.m_debuffList = self:getChild("debuffList")
	self.m_name = self:getChild("name")
	self.m_desText = self:getChild("desText")
end

var_0_0.ShowCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
