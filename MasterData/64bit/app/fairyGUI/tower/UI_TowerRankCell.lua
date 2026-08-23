local var_0_0 = {}

var_0_0.URL = "ui://foyq921sz0z92"

function var_0_0:__ctor()
	self.m_isShowBgController = self:getController("isShowBg")
	self.m_isSelfController = self:getController("isSelf")
	self.m_indexRank = self:getChild("indexRank")
	self.m_IconComp = self:getChild("IconComp")
	self.m_userName = self:getChild("userName")
	self.m_serverName = self:getChild("serverName")
	self.m_power = self:getChild("power")
	self.m_passStage = self:getChild("passStage")
end

var_0_0.IsShowBgCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsSelfCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
