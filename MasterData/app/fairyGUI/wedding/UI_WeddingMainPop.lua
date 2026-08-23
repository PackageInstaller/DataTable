local var_0_0 = {}

var_0_0.URL = "ui://14huq3sfhob80"

function var_0_0:__ctor()
	self.m_bgComp = self:getChild("bgComp")
	self.m_passiveIcon = self:getChild("passiveIcon")
	self.m_tip0 = self:getChild("tip0")
	self.m_tip1 = self:getChild("tip1")
	self.m_tip2 = self:getChild("tip2")
	self.m_tip3 = self:getChild("tip3")
	self.m_userSignComp = self:getChild("userSignComp")
	self.m_knightSignComp = self:getChild("knightSignComp")
	self.m_condComp = self:getChild("condComp")
	self.m_weddingBtn = self:getChild("weddingBtn")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
