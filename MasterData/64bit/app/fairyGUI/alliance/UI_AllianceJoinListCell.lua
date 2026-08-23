local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lctba7p"

function var_0_0:__ctor()
	self.m_isFullNumController = self:getController("isFullNum")
	self.m_hasSuggestController = self:getController("hasSuggest")
	self.m_isApplyController = self:getController("isApply")
	self.m_level = self:getChild("level")
	self.m_name = self:getChild("name")
	self.m_suggestText = self:getChild("suggestText")
	self.m_flag = self:getChild("flag")
	self.m_guildNumText = self:getChild("guildNumText")
	self.m_fightValueText = self:getChild("fightValueText")
	self.m_joinCondText = self:getChild("joinCondText")
end

var_0_0.IsFullNumCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasSuggestCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsApplyCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
