local var_0_0 = {}

var_0_0.URL = "ui://0xhekt5ig73zn"

function var_0_0:__ctor()
	self.m_selIndexController = self:getController("selIndex")
	self.m_title = self:getChild("title")
	self.m_confirmBtn = self:getChild("confirmBtn")
	self.m_selComp1 = self:getChild("selComp1")
	self.m_selComp2 = self:getChild("selComp2")
	self.m_selComp3 = self:getChild("selComp3")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
