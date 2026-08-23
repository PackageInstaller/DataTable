local var_0_0 = {}

var_0_0.URL = "ui://2qeh40nkq285mibx4"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_faildDescController = self:getController("faildDesc")
	self.m_upgradeHideController = self:getController("upgradeHide")
	self.m_campIcon = self:getChild("campIcon")
	self.m_redImg = self:getChild("redImg")
	self.m_victory = self:getChild("victory")
	self.m_failDot = self:getChild("failDot")
	self.m_upgradeComp = self:getChild("upgradeComp")
	self.m_failTitle = self:getChild("failTitle")
	self.m_defeat = self:getChild("defeat")
	self.m_failEnterTransition = self:getTransition("failEnter")
	self.m_comEnterTransition = self:getTransition("comEnter")
	self.m_redImgEnterTransition = self:getTransition("redImgEnter")
end

return var_0_0
