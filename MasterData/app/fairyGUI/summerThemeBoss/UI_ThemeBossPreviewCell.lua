local var_0_0 = {}

var_0_0.URL = "ui://44qiyyomie5x3"

function var_0_0:__ctor()
	self.m_stateController = self:getController("state")
	self.m_showPosController = self:getController("showPos")
	self.m_barImg = self:getChild("barImg")
	self.m_awardList = self:getChild("awardList")
	self.m_scoreText = self:getChild("scoreText")
	self.m_getArea = self:getChild("getArea")
	self.m_getBtn = self:getChild("getBtn")
end

var_0_0.StateCtrl = {
	已领取 = 0,
	不可领取 = 2,
	null = 4,
	可领取 = 1
}
var_0_0.ShowPosCtrl = {
	dowm = 1,
	up = 0
}

return var_0_0
