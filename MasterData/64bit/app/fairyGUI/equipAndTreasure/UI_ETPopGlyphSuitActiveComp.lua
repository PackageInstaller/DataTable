local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7f7jc8t"

function var_0_0:__ctor()
	self.m_addAttNumController = self:getController("addAttNum")
	self.m_glyCompInfo = self:getChild("glyCompInfo")
	self.m_preText = self:getChild("preText")
	self.m_curText = self:getChild("curText")
	self.m_suitAttrList = self:getChild("suitAttrList")
	self.m_Group = self:getChild("Group")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.AddAttNumCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
