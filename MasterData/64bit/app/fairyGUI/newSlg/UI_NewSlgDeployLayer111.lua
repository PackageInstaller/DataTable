local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jhdt68oy"

function var_0_0:__ctor()
	self.m_typeNameTxt = self:getChild("typeNameTxt")
	self.m_coreComp = self:getChild("coreComp")
	self.m_slotComp = self:getChild("slotComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
