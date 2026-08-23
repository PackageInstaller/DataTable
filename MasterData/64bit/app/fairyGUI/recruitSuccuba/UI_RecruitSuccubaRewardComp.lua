local var_0_0 = {}

var_0_0.URL = "ui://0vs2yqm8v6xlc"

function var_0_0:__ctor()
	self.m_qualityController = self:getController("quality")
	self.m_showTypeController = self:getController("showType")
	self.m_effDown = self:getChild("effDown")
	self.m_effDownIdle = self:getChild("effDownIdle")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_effUp = self:getChild("effUp")
	self.m_effIdle = self:getChild("effIdle")
	self.m_sizeText = self:getChild("sizeText")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
