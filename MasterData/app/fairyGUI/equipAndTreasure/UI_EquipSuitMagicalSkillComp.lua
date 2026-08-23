local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7ek02dq"

function var_0_0:__ctor()
	self.m_showInfoController = self:getController("showInfo")
	self.m_title = self:getChild("title")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_skillDesc = self:getChild("skillDesc")
	self.m_skillGroup = self:getChild("skillGroup")
end

var_0_0.ShowInfoCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
