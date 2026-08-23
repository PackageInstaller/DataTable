local var_0_0 = {}

var_0_0.URL = "ui://gntkqnnjkvbj2"

function var_0_0:__ctor()
	self.m_areaController = self:getController("area")
	self.m_areaBg = self:getChild("areaBg")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_tissueLoader = self:getChild("tissueLoader")
	self.m_tissueNameTxt = self:getChild("tissueNameTxt")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_curNumTxt = self:getChild("curNumTxt")
	self.m_totalNumTxt = self:getChild("totalNumTxt")
end

var_0_0.AreaCtrl = {
	针刺 = 6,
	十字 = 5,
	白色 = 4,
	橙色 = 3,
	红色 = 2,
	蓝色 = 1,
	放大 = 0
}

return var_0_0
