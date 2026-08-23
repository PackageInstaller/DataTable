local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnk1qqrcq"

function var_0_0:__ctor()
	self.m_isEnoughController = self:getController("isEnough")
	self.m_showSumController = self:getController("showSum")
	self.m_finishTitleComp = self:getChild("finishTitleComp")
	self.m_awardIcon = self:getChild("awardIcon")
end

var_0_0.IsEnoughCtrl = {
	体力不足 = 3,
	足够 = 1,
	次数不足 = 0
}
var_0_0.ShowSumCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
