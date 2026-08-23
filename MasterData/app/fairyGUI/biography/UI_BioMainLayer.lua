local var_0_0 = {}

var_0_0.URL = "ui://kgq5r794v5bgibmw"

function var_0_0:__ctor()
	self.m_arrowShowController = self:getController("arrowShow")
	self.m_movieComp = self:getChild("movieComp")
	self.m_bgEffectComp = self:getChild("bgEffectComp")
	self.m_topBar = self:getChild("topBar")
	self.m_landName = self:getChild("landName")
	self.m_chapterProg = self:getChild("chapterProg")
	self.m_leftBtn = self:getChild("leftBtn")
	self.m_rightBtn = self:getChild("rightBtn")
	self.m_sweepBtn = self:getChild("sweepBtn")
	self.m_landPart = self:getChild("landPart")
	self.m_playTimesComp = self:getChild("playTimesComp")
	self.m_chatComp = self:getChild("chatComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
