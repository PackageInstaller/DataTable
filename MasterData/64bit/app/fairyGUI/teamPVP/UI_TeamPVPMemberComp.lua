local var_0_0 = {}

var_0_0.URL = "ui://akds0szaf4704"

function var_0_0:__ctor()
	self.m_isCaptainController = self:getController("isCaptain")
	self.m_isHelpController = self:getController("isHelp")
	self.m_hasPlayerController = self:getController("hasPlayer")
	self.m_isReadyController = self:getController("isReady")
	self.m_isNpcController = self:getController("isNpc")
	self.m_collideArea = self:getChild("collideArea")
	self.m_knightHolder = self:getChild("knightHolder")
	self.m_buffEff = self:getChild("buffEff")
	self.m_npcNameTxt = self:getChild("npcNameTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_fightValue = self:getChild("fightValue")
	self.m_rankLoader = self:getChild("rankLoader")
	self.m_testPos = self:getChild("testPos")
	self.m_showGroup = self:getChild("showGroup")
end

return var_0_0
