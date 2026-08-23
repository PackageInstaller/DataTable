local var_0_0 = {}

var_0_0.URL = "ui://a2qtbzwvlnw30"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_nameText = self:getChild("nameText")
	self.m_effBg = self:getChild("effBg")
	self.m_contentComp = self:getChild("contentComp")
	self.m_reportBtn = self:getChild("reportBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_progComp = self:getChild("progComp")
	self.m_playTimesComp = self:getChild("playTimesComp")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
