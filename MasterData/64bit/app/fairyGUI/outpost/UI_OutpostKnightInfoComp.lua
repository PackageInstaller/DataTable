local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5lrhf7bk"

function var_0_0:__ctor()
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_elemIcon = self:getChild("elemIcon")
	self.m_starComp = self:getChild("starComp")
	self.m_detailAttrBtn = self:getChild("detailAttrBtn")
	self.m_attrList = self:getChild("attrList")
	self.m_skill1 = self:getChild("skill1")
	self.m_skill2 = self:getChild("skill2")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
