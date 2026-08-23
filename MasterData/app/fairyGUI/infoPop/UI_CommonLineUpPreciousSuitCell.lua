local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnv90elgich6"

function var_0_0:__ctor()
	self.m_lineupController = self:getController("lineup")
	self.m_skillIcon = self:getChild("skillIcon")
	self.m_qualityIcon = self:getChild("qualityIcon")
	self.m_starComp = self:getChild("starComp")
	self.m_gotoComp = self:getChild("gotoComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_stageTxt = self:getChild("stageTxt")
end

var_0_0.LineupCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
