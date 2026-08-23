local var_0_0 = {}

var_0_0.URL = "ui://kvb3zneplu7agic2n"

function var_0_0:__ctor()
	self.m_hideLevelController = self:getController("hideLevel")
	self.m_baseIcon = self:getChild("baseIcon")
	self.m_levelBg = self:getChild("levelBg")
	self.m_levelText = self:getChild("levelText")
end

var_0_0.HideLevelCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
