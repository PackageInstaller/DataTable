local var_0_0 = {}

var_0_0.URL = "ui://6ljwas8lkpbi8k"

function var_0_0:__ctor()
	self.m_bottomContentController = self:getController("bottomContent")
	self.m_placeCell_1 = self:getChild("placeCell_1")
	self.m_placeCell_2 = self:getChild("placeCell_2")
	self.m_placeCell_3 = self:getChild("placeCell_3")
	self.m_placeCell_4 = self:getChild("placeCell_4")
	self.m_placeCell_5 = self:getChild("placeCell_5")
	self.m_placeCell_6 = self:getChild("placeCell_6")
	self.m_uniteTokenList = self:getChild("uniteTokenList")
	self.m_petList = self:getChild("petList")
	self.m_succubaList = self:getChild("succubaList")
	self.m_uniteBtn = self:getChild("uniteBtn")
	self.m_petBtn = self:getChild("petBtn")
	self.m_succubaBtn = self:getChild("succubaBtn")
	self.m_powerTxt = self:getChild("powerTxt")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.BottomContentCtrl = {
	succuba = 4,
	pet = 1,
	uniteToken = 0
}

return var_0_0
