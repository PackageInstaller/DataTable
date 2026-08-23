local var_0_0 = {}

var_0_0.URL = "ui://z48x0zjhofaj1g"

function var_0_0:__ctor()
	self.m_isOpenController = self:getController("isOpen")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_eff = self:getChild("eff")
	self.m_leftTxt = self:getChild("leftTxt")
	self.m_maxTxt = self:getChild("maxTxt")
	self.m_title = self:getChild("title")
	self.m_descTxt = self:getChild("descTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_redPointComp = self:getChild("redPointComp")
end

return var_0_0
