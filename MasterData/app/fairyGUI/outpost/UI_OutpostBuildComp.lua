local var_0_0 = {}

var_0_0.URL = "ui://ziwfw8v5rcutq"

function var_0_0:__ctor()
	self.m_isLockController = self:getController("isLock")
	self.m_buildController = self:getController("build")
	self.m_canLevelUpController = self:getController("canLevelUp")
	self.m_buildIcon = self:getChild("buildIcon")
	self.m_buildIconMask = self:getChild("buildIconMask")
	self.m_buildNameTxt = self:getChild("buildNameTxt")
	self.m_unlockEffectNode = self:getChild("unlockEffectNode")
	self.m_throwNode = self:getChild("throwNode")
	self.m_avatarList = self:getChild("avatarList")
	self.m_arrowTransition = self:getTransition("arrow")
end

return var_0_0
