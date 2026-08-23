local var_0_0 = {}

var_0_0.URL = "ui://454a48jprlqv1spemji"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_popPanel = self:getChild("popPanel")
	self.m_list = self:getChild("list")
	self.m_clickArea = self:getChild("clickArea")
	self.m_oneKeyBuyBtn = self:getChild("oneKeyBuyBtn")
	self.m_progress = self:getChild("progress")
	self.m_content = self:getChild("content")
end

var_0_0.StateCtrl = {
	进行中 = 0,
	已完成 = 1
}

return var_0_0
