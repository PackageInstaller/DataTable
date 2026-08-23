local var_0_0 = {}

var_0_0.URL = "ui://nz3msl46ltyfgibyn"

function var_0_0:__ctor()
	self.m_actionMask = self:getChild("actionMask")
	self.m_groupBgLoader = self:getChild("groupBgLoader")
	self.m_groupBgLoaderEff = self:getChild("groupBgLoaderEff")
	self.m_effectNode = self:getChild("effectNode")
	self.m_knightComp1 = self:getChild("knightComp1")
	self.m_knightComp2 = self:getChild("knightComp2")
	self.m_knightComp3 = self:getChild("knightComp3")
	self.m_knightComp4 = self:getChild("knightComp4")
	self.m_knightComp5 = self:getChild("knightComp5")
	self.m_groupLoader = self:getChild("groupLoader")
	self.m_jumpBtn = self:getChild("jumpBtn")
	self.m_teamIconTransition = self:getTransition("teamIcon")
	self.m_bgTransition = self:getTransition("bg")
	self.m_ssr1Transition = self:getTransition("ssr1")
	self.m_ssr2Transition = self:getTransition("ssr2")
end

return var_0_0
