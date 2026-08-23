local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrgmyr4v"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_infoBaseComp = self:getChild("infoBaseComp")
	self.m_attrComp = self:getChild("attrComp")
	self.m_progNumText = self:getChild("progNumText")
	self.m_tipsBtn = self:getChild("tipsBtn")
	self.m_developBtn = self:getChild("developBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.TypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
