local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ulamy95"

function var_0_0:__ctor()
	self.m_bookStatusController = self:getController("bookStatus")
	self.m_bookName = self:getChild("bookName")
	self.m_starComp = self:getChild("starComp")
	self.m_honorNum = self:getChild("honorNum")
	self.m_honorGroup = self:getChild("honorGroup")
	self.m_attribute1 = self:getChild("attribute1")
	self.m_attribute2 = self:getChild("attribute2")
	self.m_attribute3 = self:getChild("attribute3")
	self.m_attribute4 = self:getChild("attribute4")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
