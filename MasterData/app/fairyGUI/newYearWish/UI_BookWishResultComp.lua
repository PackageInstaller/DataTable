local var_0_0 = {}

var_0_0.URL = "ui://vpe6pr94nb767w"

function var_0_0:__ctor()
	self.m_viewTypeController = self:getController("viewType")
	self.m_numTxt = self:getChild("numTxt")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_awardList = self:getChild("awardList")
	self.m_giftList = self:getChild("giftList")
	self.m_descShareComp1 = self:getChild("descShareComp1")
	self.m_descShareComp2 = self:getChild("descShareComp2")
	self.m_descComp1 = self:getChild("descComp1")
	self.m_descComp2 = self:getChild("descComp2")
end

var_0_0.ViewTypeCtrl = {
	page0 = 0,
	page2 = 7,
	page1 = 1
}

return var_0_0
