local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wtbcp6k"

function var_0_0:__ctor()
	self.m_awardStateController = self:getController("awardState")
	self.m_stepTxt = self:getChild("stepTxt")
	self.m_progressValueTxt = self:getChild("progressValueTxt")
	self.m_progressComp = self:getChild("progressComp")
	self.m_awardEff = self:getChild("awardEff")
	self.m_redPointComp = self:getChild("redPointComp")
end

var_0_0.AwardStateCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
