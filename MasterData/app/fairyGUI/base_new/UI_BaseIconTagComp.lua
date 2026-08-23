local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepl72okk2vj"

function var_0_0:__ctor()
	self.m_tagTypeController = self:getController("tagType")
	self.m_probText = self:getChild("probText")
	self.m_levelText = self:getChild("levelText")
	self.m_itemSpecialUseLoader = self:getChild("itemSpecialUseLoader")
end

var_0_0.TagTypeCtrl = {
	page2 = 2,
	page8 = 8,
	page1 = 1,
	page0 = 0,
	page7 = 7,
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3
}

return var_0_0
