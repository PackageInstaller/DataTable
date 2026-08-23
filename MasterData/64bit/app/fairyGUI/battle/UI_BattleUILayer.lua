local var_0_0 = {}

var_0_0.URL = "ui://dj6vjom2hcfpf"

function var_0_0:__ctor()
	self.m_skipTIpController = self:getController("skipTIp")
	self.m_bgNode = self:getChild("bgNode")
	self.m_shmcComp = self:getChild("shmcComp")
	self.m_roundComp = self:getChild("roundComp")
	self.m_warBandComp = self:getChild("warBandComp")
	self.m_controlComp = self:getChild("controlComp")
	self.m_uniteComp = self:getChild("uniteComp")
	self.m_succubaComp = self:getChild("succubaComp")
	self.m_conditionComp = self:getChild("conditionComp")
	self.m_buffInfoPlaceHolder = self:getChild("buffInfoPlaceHolder")
	self.m_skillPlaceHolder1 = self:getChild("skillPlaceHolder1")
	self.m_skillPlaceHolder2 = self:getChild("skillPlaceHolder2")
	self.m_unitePlaceHolder = self:getChild("unitePlaceHolder")
	self.m_headerComp = self:getChild("headerComp")
	self.m_bossHpComp = self:getChild("bossHpComp")
	self.m_bossPlace = self:getChild("bossPlace")
	self.m_debugComp = self:getChild("debugComp")
	self.m_criSprPlaceHolder = self:getChild("criSprPlaceHolder")
	self.m_skipTipText = self:getChild("skipTipText")
	self.m_bossReward = self:getChild("bossReward")
	self.m_autoNode = self:getChild("autoNode")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.SkipTIpCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
