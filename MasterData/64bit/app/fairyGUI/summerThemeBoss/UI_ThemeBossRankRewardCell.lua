local var_0_0 = {}

var_0_0.URL = "ui://44qiyyomft7s9bnoh0"

function var_0_0:__ctor()
	self.m_numController = self:getController("num")
	self.m_haveBgController = self:getController("haveBg")
	self.m_numTxt = self:getChild("numTxt")
	self.m_awardList = self:getChild("awardList")
end

var_0_0.NumCtrl = {
	page1 = 1,
	page0 = 0,
	page3 = 3,
	page2 = 2
}
var_0_0.HaveBgCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
