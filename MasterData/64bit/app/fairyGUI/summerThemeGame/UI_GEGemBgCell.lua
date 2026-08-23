local var_0_0 = {}

var_0_0.URL = "ui://qrucqci6tocwc"

function var_0_0:__ctor()
	self.m_hideStarController = self:getController("hideStar")
	self.m_gameIdController = self:getController("gameId")
	self.m_eliEffDad = self:getChild("eliEffDad")
end

var_0_0.HideStarCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.GameIdCtrl = {
	page1 = 1,
	page0 = 0,
	page5 = 8,
	page4 = 4,
	page3 = 3,
	page2 = 2
}

return var_0_0
