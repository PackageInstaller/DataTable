local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivf2y1fg"

function var_0_0:__ctor()
	self.m_stageStateController = self:getController("stageState")
	self.m_desLabel = self:getChild("desLabel")
	self.m_awardList = self:getChild("awardList")
	self.m_blitzBtn = self:getChild("blitzBtn")
	self.m_acqBtn = self:getChild("acqBtn")
end

var_0_0.StageStateCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
