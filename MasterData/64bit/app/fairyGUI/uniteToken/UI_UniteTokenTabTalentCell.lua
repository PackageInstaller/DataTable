local var_0_0 = {}

var_0_0.URL = "ui://3yl23vbxj4mi1p"

function var_0_0:__ctor()
	self.m_isActiveController = self:getController("isActive")
	self.m_title = self:getChild("title")
	self.m_desc = self:getChild("desc")
end

var_0_0.IsActiveCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
