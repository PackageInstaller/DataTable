local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wgech3k"

function var_0_0:__ctor()
	self.m_stateAward1Controller = self:getController("stateAward1")
	self.m_stateAward2Controller = self:getController("stateAward2")
	self.m_typeController = self:getController("type")
	self.m_normalAward = self:getChild("normalAward")
	self.m_buyAward = self:getChild("buyAward")
	self.m_descTxt = self:getChild("descTxt")
	self.m_normalAwardTouch = self:getChild("normalAwardTouch")
	self.m_buyAwardTouch = self:getChild("buyAwardTouch")
	self.m_lvTxt = self:getChild("lvTxt")
	self.m_denji = self:getChild("denji")
	self.m_dungeonStageTxt = self:getChild("dungeonStageTxt")
	self.m_zhuxian = self:getChild("zhuxian")
	self.m_wushTxt = self:getChild("wushTxt")
	self.m_heiyuan = self:getChild("heiyuan")
	self.m_normalEffHolder = self:getChild("normalEffHolder")
	self.m_buyEffHolder = self:getChild("buyEffHolder")
	self.m_mysteryTxt = self:getChild("mysteryTxt")
	self.m_mijing = self:getChild("mijing")
end

var_0_0.StateAward1Ctrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.StateAward2Ctrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.TypeCtrl = {
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0,
	page4 = 4
}

return var_0_0
