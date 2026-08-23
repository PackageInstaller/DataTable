local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfsf2w1r"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_hasUserController = self:getController("hasUser")
	self.m_isCrossController = self:getController("isCross")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_nameText = self:getChild("nameText")
	self.m_starComp = self:getChild("starComp")
	self.m_timeText = self:getChild("timeText")
	self.m_descText = self:getChild("descText")
	self.m_powerText = self:getChild("powerText")
	self.m_userIconComp = self:getChild("userIconComp")
	self.m_userNameText = self:getChild("userNameText")
	self.m_serverText = self:getChild("serverText")
	self.m_userGroup = self:getChild("userGroup")
	self.m_awardIcon1 = self:getChild("awardIcon1")
	self.m_awardIcon2 = self:getChild("awardIcon2")
	self.m_award2Group = self:getChild("award2Group")
	self.m_clickLoader = self:getChild("clickLoader")
	self.m_clickGroup = self:getChild("clickGroup")
end

return var_0_0
