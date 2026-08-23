local var_0_0 = {}

var_0_0.URL = "ui://akds0szaeh7w14"

function var_0_0:__ctor()
	self.m_holdComp = self:getChild("holdComp")
	self.m_redComp1 = self:getChild("redComp1")
	self.m_redComp2 = self:getChild("redComp2")
	self.m_redComp3 = self:getChild("redComp3")
	self.m_redComp4 = self:getChild("redComp4")
	self.m_redComp5 = self:getChild("redComp5")
	self.m_blueComp1 = self:getChild("blueComp1")
	self.m_blueComp2 = self:getChild("blueComp2")
	self.m_blueComp3 = self:getChild("blueComp3")
	self.m_blueComp4 = self:getChild("blueComp4")
	self.m_blueComp5 = self:getChild("blueComp5")
	self.m_redResult = self:getChild("redResult")
	self.m_blueResult = self:getChild("blueResult")
	self.m_enterEffect = self:getChild("enterEffect")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
