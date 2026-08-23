local var_0_0 = {}

var_0_0.URL = "ui://foyq921su8224r"

function var_0_0:__ctor()
	self.m_isLightController = self:getController("isLight")
	self.m_passCount = self:getChild("passCount")
	self.m_buffDesc = self:getChild("buffDesc")
end

var_0_0.IsLightCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
