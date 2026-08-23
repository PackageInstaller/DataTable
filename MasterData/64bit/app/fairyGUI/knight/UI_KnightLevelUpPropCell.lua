local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivxayll9"

function var_0_0:__ctor()
	self.m_isMaskController = self:getController("isMask")
	self.m_icon = self:getChild("icon")
end

var_0_0.IsMaskCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
