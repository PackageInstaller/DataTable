local var_0_0 = {}

var_0_0.URL = "ui://npkz19upnhd72"

function var_0_0:__ctor()
	self.m_isUseController = self:getController("isUse")
	self.m_dressPicLoader = self:getChild("dressPicLoader")
	self.m_dressNameText = self:getChild("dressNameText")
end

var_0_0.IsUseCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
