local var_0_0 = {}

var_0_0.URL = "ui://9n9qtghbcfzbmibvy"

function var_0_0:__ctor()
	self.m_showBgController = self:getController("showBg")
	self.m_snapShotStateController = self:getController("snapShotState")
	self.m_indexRank = self:getChild("indexRank")
	self.m_userIcon = self:getChild("userIcon")
	self.m_userNameText = self:getChild("userNameText")
	self.m_serverNameText = self:getChild("serverNameText")
	self.m_allianceNameText = self:getChild("allianceNameText")
	self.m_damageText = self:getChild("damageText")
end

return var_0_0
