local var_0_0 = {}

var_0_0.URL = "ui://vhnpxv25wbwb8p"

function var_0_0:__ctor()
	self.m_canGetController = self:getController("canGet")
	self.m_mirrorIcon = self:getChild("mirrorIcon")
	self.m_awardList = self:getChild("awardList")
	self.m_rewardBtn = self:getChild("rewardBtn")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_enterEffect = self:getChild("enterEffect")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.CanGetCtrl = {
	canGet = 1,
	none = 0
}

return var_0_0
