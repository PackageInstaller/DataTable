local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8ltoz97t"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_isCaptainController = self:getController("isCaptain")
	self.m_showTickOutController = self:getController("showTickOut")
	self.m_posController = self:getController("pos")
	self.m_userPicComp = self:getChild("userPicComp")
	self.m_inviteBtn = self:getChild("inviteBtn")
	self.m_inviteGroup = self:getChild("inviteGroup")
	self.m_posTxt = self:getChild("posTxt")
	self.m_bg = self:getChild("bg")
	self.m_playInfoComp = self:getChild("playInfoComp")
	self.m_tickOutBtn = self:getChild("tickOutBtn")
	self.m_zhezhao = self:getChild("zhezhao")
end

var_0_0.IsEmptyCtrl = {
	有人 = 1,
	无人 = 0
}
var_0_0.IsCaptainCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowTickOutCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.PosCtrl = {
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
