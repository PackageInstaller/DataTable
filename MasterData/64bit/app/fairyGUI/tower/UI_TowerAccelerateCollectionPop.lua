local var_0_0 = {}

var_0_0.URL = "ui://foyq921sfu8o2b"

function var_0_0:__ctor()
	self.m_isFreeController = self:getController("isFree")
	self.m_popPanel = self:getChild("popPanel")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_lastCount = self:getChild("lastCount")
	self.m_rewardList = self:getChild("rewardList")
	self.m_selectBtn = self:getChild("selectBtn")
	self.m_resComp = self:getChild("resComp")
	self.m_content = self:getChild("content")
end

var_0_0.IsFreeCtrl = {
	page2 = 3,
	page1 = 1,
	page0 = 0
}

return var_0_0
