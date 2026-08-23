local var_0_0 = {}

var_0_0.URL = "ui://h35b870br7471y"

function var_0_0:__ctor()
	self.m_isShowApplyController = self:getController("isShowApply")
	self.m_hasAllianceController = self:getController("hasAlliance")
	self.m_guildIcon = self:getChild("guildIcon")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_idTxt = self:getChild("idTxt")
	self.m_copyBtn = self:getChild("copyBtn")
	self.m_copyTouchComp = self:getChild("copyTouchComp")
	self.m_chatBtn = self:getChild("chatBtn")
	self.m_leaderNameTxt = self:getChild("leaderNameTxt")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_memberSizeTxt = self:getChild("memberSizeTxt")
	self.m_fightValueTxt = self:getChild("fightValueTxt")
	self.m_limitLevelTxt = self:getChild("limitLevelTxt")
	self.m_auditTxt = self:getChild("auditTxt")
	self.m_allianceName = self:getChild("allianceName")
	self.m_lookAllianceBtn = self:getChild("lookAllianceBtn")
	self.m_declarationTxt = self:getChild("declarationTxt")
	self.m_applyBtn = self:getChild("applyBtn")
end

return var_0_0
