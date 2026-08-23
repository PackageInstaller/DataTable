local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnpljl1v5dsse"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_starController = self:getController("star")
	self.m_star1 = self:getChild("star1")
	self.m_star2 = self:getChild("star2")
	self.m_star3 = self:getChild("star3")
	self.m_star4 = self:getChild("star4")
	self.m_star5 = self:getChild("star5")
	self.m_inputTxt = self:getChild("inputTxt")
	self.m_placeHolderTxt = self:getChild("placeHolderTxt")
	self.m_laterBtn = self:getChild("laterBtn")
	self.m_submitBtn = self:getChild("submitBtn")
end

var_0_0.StateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.StarCtrl = {
	page2 = 2,
	page5 = 5,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page3 = 3
}

return var_0_0
