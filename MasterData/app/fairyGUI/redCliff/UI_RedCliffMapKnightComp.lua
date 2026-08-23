local var_0_0 = {}

var_0_0.URL = "ui://ugwozn2sj2geo"

function var_0_0:__ctor()
	self.m_cdTypeController = self:getController("cdType")
	self.m_isSelfController = self:getController("isSelf")
	self.m_occupyEffectDown = self:getChild("occupyEffectDown")
	self.m_knightNode = self:getChild("knightNode")
	self.m_nameText = self:getChild("nameText")
	self.m_fightText = self:getChild("fightText")
	self.m_heartComp = self:getChild("heartComp")
	self.m_hpProg = self:getChild("hpProg")
	self.m_cdTxt = self:getChild("cdTxt")
	self.m_protectEffect = self:getChild("protectEffect")
	self.m_occupyEffectUp = self:getChild("occupyEffectUp")
	self.m_protectOutTransition = self:getTransition("protectOut")
	self.m_protectInTransition = self:getTransition("protectIn")
end

return var_0_0
