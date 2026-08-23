local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepfc69ag"

function var_0_0:__ctor()
	self.m_levelController = self:getController("level")
	self.m_icon = self:getChild("icon")
end

var_0_0.LevelCtrl = {
	page9 = 9,
	page8 = 8,
	page7 = 7,
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2,
	page1 = 1,
	page0 = 0
}

return var_0_0
