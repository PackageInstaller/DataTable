local var_0_0 = {}

var_0_0.URL = "ui://qa3xcguq854lg1v"

function var_0_0:__ctor()
	self.m_limitStateController = self:getController("limitState")
	self.m_btn = self:getChild("btn")
	self.m_CDPic = self:getChild("CDPic")
	self.m_CDText = self:getChild("CDText")
	self.m_group = self:getChild("group")
end

var_0_0.LimitStateCtrl = {
	limit = 1,
	normal = 0
}

return var_0_0
