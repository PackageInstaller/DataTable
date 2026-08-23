local var_0_0 = {}

var_0_0.URL = "ui://ltl1fuv2eajl1u"

function var_0_0:__ctor()
	self.m_isCurSpinnerController = self:getController("isCurSpinner")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_bigAwardIcon = self:getChild("bigAwardIcon")
	self.m_descTxt = self:getChild("descTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_awardList = self:getChild("awardList")
end

return var_0_0
