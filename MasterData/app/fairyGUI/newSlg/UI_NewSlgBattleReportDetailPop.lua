local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9lh7n8c8"

function var_0_0:__ctor()
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_chooseComp = self:getChild("chooseComp")
	self.m_list = self:getChild("list")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
