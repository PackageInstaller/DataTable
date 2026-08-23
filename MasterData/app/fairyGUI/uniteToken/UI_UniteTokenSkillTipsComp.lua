local var_0_0 = {}

var_0_0.URL = "ui://3yl23vbxqxmy1h"

function var_0_0:__ctor()
	self.m_isPopController = self:getController("isPop")
	self.m_title = self:getChild("title")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_nameText = self:getChild("nameText")
	self.m_roundText = self:getChild("roundText")
	self.m_costText = self:getChild("costText")
	self.m_skillList = self:getChild("skillList")
	self.m_formatDownBtn = self:getChild("formatDownBtn")
	self.m_tokenDevBtn = self:getChild("tokenDevBtn")
	self.m_downText = self:getChild("downText")
	self.m_devText = self:getChild("devText")
	self.m_btnGroup = self:getChild("btnGroup")
end

var_0_0.IsPopCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
