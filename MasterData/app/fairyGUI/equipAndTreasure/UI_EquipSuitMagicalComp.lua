local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7ek02do"

function var_0_0:__ctor()
	self.m_isDevlopController = self:getController("isDevlop")
	self.m_infoBtnController = self:getController("infoBtn")
	self.m_twoSuitTitle = self:getChild("twoSuitTitle")
	self.m_twoSuitAttrList = self:getChild("twoSuitAttrList")
	self.m_fourSuitTitle = self:getChild("fourSuitTitle")
	self.m_fourSuitAttrList = self:getChild("fourSuitAttrList")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
