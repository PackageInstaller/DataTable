local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7lbh7cc"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_upScoreController = self:getController("upScore")
	self.m_selectIndexController = self:getController("selectIndex")
	self.m_popPanel = self:getChild("popPanel")
	self.m_totalScoreTxt = self:getChild("totalScoreTxt")
	self.m_curScoreTxt = self:getChild("curScoreTxt")
	self.m_tmpScoreTxt = self:getChild("tmpScoreTxt")
	self.m_upScoreFlag = self:getChild("upScoreFlag")
	self.m_attrComp1 = self:getChild("attrComp1")
	self.m_attrComp2 = self:getChild("attrComp2")
	self.m_attrComp3 = self:getChild("attrComp3")
	self.m_attrComp4 = self:getChild("attrComp4")
	self.m_attrComp5 = self:getChild("attrComp5")
	self.m_attrComp6 = self:getChild("attrComp6")
	self.m_costItemList = self:getChild("costItemList")
	self.m_purifyBtn = self:getChild("purifyBtn")
	self.m_content = self:getChild("content")
end

var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.UpScoreCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 2
}
var_0_0.SelectIndexCtrl = {
	page1 = 1,
	page0 = 0,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2
}

return var_0_0
