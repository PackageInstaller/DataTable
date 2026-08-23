local var_0_0 = {}

var_0_0.URL = "ui://18k9xvs2lrblst15uj"

function var_0_0:__ctor()
	self.m_rankingController = self:getController("ranking")
	self.m_showDescController = self:getController("showDesc")
end

var_0_0.RankingCtrl = {
	page2 = 2,
	page5 = 5,
	page1 = 1,
	page4 = 4,
	page0 = 0,
	page6 = 6,
	page3 = 3,
	page7 = 7
}
var_0_0.ShowDescCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
