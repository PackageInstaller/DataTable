local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ulj2cj4c"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_typeController = self:getController("type")
	self.m_rankList = self:getChild("rankList")
	self.m_rankTxt = self:getChild("rankTxt")
	self.m_bookNumTxt = self:getChild("bookNumTxt")
	self.m_honorNumTxt = self:getChild("honorNumTxt")
	self.m_topBarComp = self:getChild("topBarComp")
end

return var_0_0
