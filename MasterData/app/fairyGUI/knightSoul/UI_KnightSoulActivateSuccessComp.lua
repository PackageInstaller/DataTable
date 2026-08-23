local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ullw08s"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_honorNum = self:getChild("honorNum")
	self.m_needKnightList = self:getChild("needKnightList")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_attributes = self:getChild("attributes")
end

return var_0_0
