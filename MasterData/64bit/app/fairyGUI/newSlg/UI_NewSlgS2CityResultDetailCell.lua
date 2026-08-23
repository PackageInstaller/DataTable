local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9o3jb9693u"

function var_0_0:__ctor()
	self.m_is_winController = self:getController("is_win")
	self.m_indexTypeController = self:getController("indexType")
	self.m_Comp_rank = self:getChild("Comp_rank")
	self.m_allianceIcon = self:getChild("allianceIcon")
	self.m_allianceName = self:getChild("allianceName")
	self.m_leaderName = self:getChild("leaderName")
	self.m_Icon_win = self:getChild("Icon_win")
end

var_0_0.Is_winCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IndexTypeCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}

return var_0_0
