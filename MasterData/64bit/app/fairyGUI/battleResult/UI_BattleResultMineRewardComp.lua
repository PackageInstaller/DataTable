local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nknhv1ibu5"

function var_0_0:__ctor()
	self.m_otherHpTxt = self:getChild("otherHpTxt")
	self.m_myHpTxt = self:getChild("myHpTxt")
	self.m_otherShield = self:getChild("otherShield")
	self.m_myShield = self:getChild("myShield")
	self.m_myHpDownTxt = self:getChild("myHpDownTxt")
	self.m_myGroup = self:getChild("myGroup")
	self.m_otherHpDownTxt = self:getChild("otherHpDownTxt")
	self.m_otherGroup = self:getChild("otherGroup")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
