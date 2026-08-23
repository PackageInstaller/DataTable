local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2lrblst15uj"

function var_0_0:__ctor()
	self.m_rankingController = self:getController("ranking")
	self.m_showDescController = self:getController("showDesc")
end

var_0_0.RankingCtrl = {
	page1 = 1,
	page0 = 0,
	page7 = 7,
	page6 = 6,
	page5 = 5,
	page4 = 4,
	page3 = 3,
	page2 = 2
}
var_0_0.ShowDescCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
