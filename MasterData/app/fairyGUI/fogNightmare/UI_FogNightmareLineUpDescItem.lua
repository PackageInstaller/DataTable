local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ofs62rrpe"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_title = self:getChild("title")
end

var_0_0.IsActiveCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
