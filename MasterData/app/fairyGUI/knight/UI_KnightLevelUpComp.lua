local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivv5fkcu"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_propList = self:getChild("propList")
	self.m_levelUpBtn = self:getChild("levelUpBtn")
	self.m_addNumComp = self:getChild("addNumComp")
	self.m_maxLevelUpText = self:getChild("maxLevelUpText")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.StyleCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
