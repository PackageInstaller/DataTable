local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2j5n6gr"

function var_0_0:__ctor()
	self.m_isGrayController = self:getController("isGray")
	self.m_effIconFulldown = self:getChild("effIconFulldown")
	self.m_maskIcon = self:getChild("maskIcon")
	self.m_valueBar = self:getChild("valueBar")
	self.m_effIconFull = self:getChild("effIconFull")
	self.m_effIconLight = self:getChild("effIconLight")
	self.m_effBarFull = self:getChild("effBarFull")
end

var_0_0.IsGrayCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
