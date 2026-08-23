local var_0_0 = {}

var_0_0.URL = "ui://9n9qtghbk8ln1m"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_mgrStateController = self:getController("mgrState")
	self.m_showTipsController = self:getController("showTips")
	self.m_dikuaiLoader = self:getChild("dikuaiLoader")
	self.m_buildIcon = self:getChild("buildIcon")
	self.m_groupIcon = self:getChild("groupIcon")
	self.m_descTxt = self:getChild("descTxt")
	self.m_controlAddGroup = self:getChild("controlAddGroup")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_lvTxt = self:getChild("lvTxt")
	self.m_siteInfoList = self:getChild("siteInfoList")
	self.m_enemyFightComp = self:getChild("enemyFightComp")
	self.m_mgrComp = self:getChild("mgrComp")
	self.m_mgrKnightComp = self:getChild("mgrKnightComp")
	self.m_emptyHolder = self:getChild("emptyHolder")
	self.m_buffComp1 = self:getChild("buffComp1")
	self.m_buffComp2 = self:getChild("buffComp2")
	self.m_tipsTxt = self:getChild("tipsTxt")
	self.m_tipsGroup = self:getChild("tipsGroup")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
