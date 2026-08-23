local var_0_0 = {}

var_0_0.URL = "ui://vpe6pr94sdp12l"

function var_0_0:__ctor()
	self.m_viewTypeController = self:getController("viewType")
	self.m_diban2 = self:getChild("diban2")
	self.m_diban1 = self:getChild("diban1")
	self.m_zidi2 = self:getChild("zidi2")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_zidi1 = self:getChild("zidi1")
	self.m_numTxt = self:getChild("numTxt")
	self.m_ribbon = self:getChild("ribbon")
	self.m_rewardTxt = self:getChild("rewardTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_giftList = self:getChild("giftList")
	self.m_descShareComp1 = self:getChild("descShareComp1")
	self.m_descShareComp2 = self:getChild("descShareComp2")
	self.m_descComp1 = self:getChild("descComp1")
	self.m_descComp2 = self:getChild("descComp2")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ViewTypeCtrl = {
	page0 = 0,
	page2 = 7,
	page1 = 1
}

return var_0_0
