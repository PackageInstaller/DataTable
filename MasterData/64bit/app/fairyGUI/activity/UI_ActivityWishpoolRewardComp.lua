local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wrqeoec"

function var_0_0:__ctor()
	self.m_showTypeController = self:getController("showType")
	self.m_isNewController = self:getController("isNew")
	self.m_hasLinkController = self:getController("hasLink")
	self.m_effDown = self:getChild("effDown")
	self.m_effDownIdle = self:getChild("effDownIdle")
	self.m_bgItemLoader = self:getChild("bgItemLoader")
	self.m_bgItemFrag = self:getChild("bgItemFrag")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_itemIcon = self:getChild("itemIcon")
	self.m_linkComp = self:getChild("linkComp")
	self.m_effUp = self:getChild("effUp")
	self.m_effIdle = self:getChild("effIdle")
	self.m_miniIcon = self:getChild("miniIcon")
	self.m_sizeText = self:getChild("sizeText")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_enter0Transition = self:getTransition("enter0")
	self.m_enter1Transition = self:getTransition("enter1")
	self.m_enter2Transition = self:getTransition("enter2")
	self.m_switchTransition = self:getTransition("switch")
end

var_0_0.ShowTypeCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}
var_0_0.IsNewCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasLinkCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
