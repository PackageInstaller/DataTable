local var_0_0 = {}

var_0_0.URL = "ui://2egchbz1xku32u"

function var_0_0:__ctor()
	self.m_isFullController = self:getController("isFull")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_effOutput = self:getChild("effOutput")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_title1 = self:getChild("title1")
end

var_0_0.IsFullCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
