local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ullw08v"

function var_0_0:__ctor()
	self.m_hasAllController = self:getController("hasAll")
	self.m_hasBookController = self:getController("hasBook")
	self.m_hasHonorController = self:getController("hasHonor")
	self.m_allAttrList = self:getChild("allAttrList")
	self.m_bookAttrList = self:getChild("bookAttrList")
	self.m_honorAttrList = self:getChild("honorAttrList")
end

return var_0_0
