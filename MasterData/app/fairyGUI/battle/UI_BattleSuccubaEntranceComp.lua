local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2oe6dd7"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_effNode = self:getChild("effNode")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.QualityCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1,
	page3 = 3
}

return var_0_0
