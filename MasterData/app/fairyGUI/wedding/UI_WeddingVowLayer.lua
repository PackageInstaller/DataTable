local var_0_0 = {}

var_0_0.URL = "ui://14huq3sfvged12"

function var_0_0:__ctor()
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_movieComp = self:getChild("movieComp")
	self.m_handEffect = self:getChild("handEffect")
	self.m_guidePlace = self:getChild("guidePlace")
	self.m_knightComp = self:getChild("knightComp")
	self.m_dialogComp = self:getChild("dialogComp")
	self.m_asmrComp = self:getChild("asmrComp")
	self.m_touchComp = self:getChild("touchComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
