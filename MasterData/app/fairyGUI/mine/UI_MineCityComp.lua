local var_0_0 = {}

var_0_0.URL = "ui://oblaamohfjnui"

function var_0_0:__ctor()
	self.m_hasGuildController = self:getController("hasGuild")
	self.m_fullController = self:getController("full")
	self.m_typeController = self:getController("type")
	self.m_svrTypeController = self:getController("svrType")
	self.m_isCapitalController = self:getController("isCapital")
	self.m_stateController = self:getController("state")
	self.m_buildIcon = self:getChild("buildIcon")
	self.m_guildNameTxt = self:getChild("guildNameTxt")
	self.m_svrNameTxt = self:getChild("svrNameTxt")
	self.m_guild = self:getChild("guild")
	self.m_multipleEffComp = self:getChild("multipleEffComp")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_playerNumTxt = self:getChild("playerNumTxt")
	self.m_cityNameTxt = self:getChild("cityNameTxt")
	self.m_bubComp = self:getChild("bubComp")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_gatherImg = self:getChild("gatherImg")
	self.m_flagEffComp = self:getChild("flagEffComp")
	self.m_clickComp = self:getChild("clickComp")
end

return var_0_0
