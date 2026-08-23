local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7frwp3e"

function var_0_0:__ctor()
	self.m_colorCtrlController = self:getController("colorCtrl")
	self.m_titleComp = self:getChild("titleComp")
	self.m_attrName1 = self:getChild("attrName1")
	self.m_attrType11 = self:getChild("attrType11")
	self.m_attrValue11 = self:getChild("attrValue11")
	self.m_attrType12 = self:getChild("attrType12")
	self.m_attrValue12 = self:getChild("attrValue12")
	self.m_attrName2 = self:getChild("attrName2")
	self.m_attrType21 = self:getChild("attrType21")
	self.m_attrValue21 = self:getChild("attrValue21")
	self.m_attrType22 = self:getChild("attrType22")
	self.m_attrValue22 = self:getChild("attrValue22")
	self.m_attrName3 = self:getChild("attrName3")
	self.m_attrType31 = self:getChild("attrType31")
	self.m_attrValue31 = self:getChild("attrValue31")
	self.m_attrType32 = self:getChild("attrType32")
	self.m_attrValue32 = self:getChild("attrValue32")
end

var_0_0.ColorCtrlCtrl = {
	["1件激活"] = 1,
	都没激活 = 0,
	["3件激活"] = 3,
	["2件激活"] = 2
}

return var_0_0
