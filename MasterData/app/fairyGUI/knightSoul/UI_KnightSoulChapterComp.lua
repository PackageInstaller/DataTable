local var_0_0 = {}

var_0_0.URL = "ui://kwpkf9ulu8gt1"

function var_0_0:__ctor()
	self.m_isUnlockController = self:getController("isUnlock")
	self.m_isPerfectController = self:getController("isPerfect")
	self.m_chapterIcon = self:getChild("chapterIcon")
	self.m_chapterTitle = self:getChild("chapterTitle")
	self.m_activateNum = self:getChild("activateNum")
	self.m_maxNum = self:getChild("maxNum")
	self.m_lockTip = self:getChild("lockTip")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
