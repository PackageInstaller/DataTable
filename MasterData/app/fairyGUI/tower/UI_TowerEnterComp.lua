local var_0_0 = {}

var_0_0.URL = "ui://foyq921sp07s6t"

function var_0_0:__ctor()
	self.m_difficultyController = self:getController("difficulty")
	self.m_titleTxt1 = self:getChild("titleTxt1")
	self.m_descTxt = self:getChild("descTxt")
	self.m_descTimeTxt = self:getChild("descTimeTxt")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_subTitleTxt = self:getChild("subTitleTxt")
	self.m_titleComp = self:getChild("titleComp")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_t0Transition = self:getTransition("t0")
end

var_0_0.DifficultyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
