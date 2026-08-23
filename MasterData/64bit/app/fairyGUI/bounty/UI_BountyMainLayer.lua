local var_0_0 = {}

var_0_0.URL = "ui://1v7lxemfkte80"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_monsterComp = self:getChild("monsterComp")
	self.m_monsterList = self:getChild("monsterList")
	self.m_tempCell = self:getChild("tempCell")
	self.m_normalBtn = self:getChild("normalBtn")
	self.m_specialBtn = self:getChild("specialBtn")
	self.m_dateText = self:getChild("dateText")
	self.m_pointBtn = self:getChild("pointBtn")
	self.m_rankBtn = self:getChild("rankBtn")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_taskBtn = self:getChild("taskBtn")
	self.m_giftBtn = self:getChild("giftBtn")
	self.m_shareListLoader = self:getChild("shareListLoader")
	self.m_shareNumText = self:getChild("shareNumText")
	self.m_shareRwdIcon = self:getChild("shareRwdIcon")
	self.m_shareRedPointComp = self:getChild("shareRedPointComp")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_normalTransition = self:getTransition("normal")
	self.m_switchTransition = self:getTransition("switch")
end

return var_0_0
