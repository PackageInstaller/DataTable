local var_0_0 = {}

var_0_0.URL = "ui://671qywx2c9i119"

function var_0_0:__ctor()
	self.m_isMaxController = self:getController("isMax")
	self.m_stageNodeTxt = self:getChild("stageNodeTxt")
	self.m_starComp = self:getChild("starComp")
	self.m_attrComp = self:getChild("attrComp")
	self.m_talentName = self:getChild("talentName")
	self.m_descText = self:getChild("descText")
	self.m_costNumComp = self:getChild("costNumComp")
	self.m_advanceBtn = self:getChild("advanceBtn")
	self.m_emptyComp = self:getChild("emptyComp")
	self.m_touchTalent = self:getChild("touchTalent")
end

return var_0_0
