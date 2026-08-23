local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99u7kxkk2ph"

function var_0_0:__ctor()
	self.m_haloBtn = self:getChild("haloBtn")
	self.m_assctNum = self:getChild("assctNum")
	self.m_touchBg = self:getChild("touchBg")
	self.m_knight4 = self:getChild("knight4")
	self.m_knight1 = self:getChild("knight1")
	self.m_knight5 = self:getChild("knight5")
	self.m_knight2 = self:getChild("knight2")
	self.m_knight6 = self:getChild("knight6")
	self.m_knight3 = self:getChild("knight3")
	self.m_bottomComp = self:getChild("bottomComp")
	self.m_nameComp = self:getChild("nameComp")
	self.m_nameGroup = self:getChild("nameGroup")
	self.m_changeComp = self:getChild("changeComp")
	self.m_checkInterchangeBtn = self:getChild("checkInterchangeBtn")
	self.m_useBtn = self:getChild("useBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
