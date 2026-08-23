local var_0_0 = {}

var_0_0.URL = "ui://q8j59504ojr06a"

function var_0_0:__ctor()
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_floorTxt = self:getChild("floorTxt")
	self.m_effComp = self:getChild("effComp")
	self.m_backTransition = self:getTransition("back")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
