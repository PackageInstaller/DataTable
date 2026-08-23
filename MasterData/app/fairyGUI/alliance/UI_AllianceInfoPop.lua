local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lcxo9t1b"

function var_0_0:__ctor()
	self.m_isFullNumController = self:getController("isFullNum")
	self.m_isSuggestController = self:getController("isSuggest")
	self.m_hasSuggestController = self:getController("hasSuggest")
	self.m_isLeaderController = self:getController("isLeader")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_flag = self:getChild("flag")
	self.m_level = self:getChild("level")
	self.m_allianceName = self:getChild("allianceName")
	self.m_suggestText = self:getChild("suggestText")
	self.m_userName = self:getChild("userName")
	self.m_lookUserBtn = self:getChild("lookUserBtn")
	self.m_guildNum = self:getChild("guildNum")
	self.m_lookGuildBtn = self:getChild("lookGuildBtn")
	self.m_fightValue = self:getChild("fightValue")
	self.m_applyCond = self:getChild("applyCond")
	self.m_declareText = self:getChild("declareText")
	self.m_applyBtn = self:getChild("applyBtn")
end

var_0_0.IsFullNumCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsSuggestCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasSuggestCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLeaderCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
