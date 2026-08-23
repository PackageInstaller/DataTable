local var_0_0 = {}

var_0_0.URL = "ui://c84aee4vkhhl2e"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_isHideBtnGroupController = self:getController("isHideBtnGroup")
	self.m_comp1 = self:getChild("comp1")
	self.m_comp2 = self:getChild("comp2")
	self.m_comp3 = self:getChild("comp3")
	self.m_comp4 = self:getChild("comp4")
	self.m_comp5 = self:getChild("comp5")
	self.m_five = self:getChild("five")
	self.m_oneShowComp = self:getChild("oneShowComp")
	self.m_twentyComp = self:getChild("twentyComp")
	self.m_topDescTxt = self:getChild("topDescTxt")
	self.m_shareComp = self:getChild("shareComp")
	self.m_costIcon = self:getChild("costIcon")
	self.m_costNumText = self:getChild("costNumText")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_continueBtn = self:getChild("continueBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
