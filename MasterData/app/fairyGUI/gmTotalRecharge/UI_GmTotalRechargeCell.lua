local var_0_0 = {}

var_0_0.URL = "ui://p5a8ifc3aop2ap"

function var_0_0:__ctor()
	self.m_drawStateController = self:getController("drawState")
	self.m_descTxt = self:getChild("descTxt")
	self.m_curProgressTxt = self:getChild("curProgressTxt")
	self.m_demandProgressText = self:getChild("demandProgressText")
	self.m_progressComp = self:getChild("progressComp")
	self.m_awardList = self:getChild("awardList")
	self.m_receiveBtn = self:getChild("receiveBtn")
	self.m_maskLoader = self:getChild("maskLoader")
	self.m_canGetEffDad = self:getChild("canGetEffDad")
end

var_0_0.DrawStateCtrl = {
	前往 = 2,
	已领取 = 3,
	可领取 = 1
}

return var_0_0
