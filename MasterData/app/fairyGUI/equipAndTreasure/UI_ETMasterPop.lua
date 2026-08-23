local var_0_0 = {}

var_0_0.URL = "ui://xoarmyu7osjsj"

function var_0_0:__ctor()
	self.m_tabController = self:getController("tab")
	self.m_levelController = self:getController("level")
	self.m_showResonanceController = self:getController("showResonance")
	self.m_popPanel = self:getChild("popPanel")
	self.m_tab1Comp = self:getChild("tab1Comp")
	self.m_tab2Comp = self:getChild("tab2Comp")
	self.m_tab3Comp = self:getChild("tab3Comp")
	self.m_tab4Comp = self:getChild("tab4Comp")
	self.m_tab5Comp = self:getChild("tab5Comp")
	self.m_topTab = self:getChild("topTab")
	self.m_curLevelComp = self:getChild("curLevelComp")
	self.m_curLevelAttr1 = self:getChild("curLevelAttr1")
	self.m_curLevelAttr2 = self:getChild("curLevelAttr2")
	self.m_curLevelAttr3 = self:getChild("curLevelAttr3")
	self.m_curLevelAttr4 = self:getChild("curLevelAttr4")
	self.m_nextLevelComp = self:getChild("nextLevelComp")
	self.m_nextLevelAttr1 = self:getChild("nextLevelAttr1")
	self.m_nextLevelAttr2 = self:getChild("nextLevelAttr2")
	self.m_nextLevelAttr3 = self:getChild("nextLevelAttr3")
	self.m_nextLevelAttr4 = self:getChild("nextLevelAttr4")
	self.m_conditionText = self:getChild("conditionText")
	self.m_resultText = self:getChild("resultText")
	self.m_tipTxt = self:getChild("tipTxt")
	self.m_item1 = self:getChild("item1")
	self.m_item2 = self:getChild("item2")
	self.m_item3 = self:getChild("item3")
	self.m_item4 = self:getChild("item4")
	self.m_strengthBtn = self:getChild("strengthBtn")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TabCtrl = {
	page2 = 2,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}
var_0_0.LevelCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowResonanceCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
