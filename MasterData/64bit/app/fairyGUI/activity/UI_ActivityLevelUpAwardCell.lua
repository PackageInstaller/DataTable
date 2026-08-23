local var_0_0 = {}

var_0_0.URL = "ui://zr5xrl9wk9cik"

function var_0_0:__ctor()
	self.m_drawStateController = self:getController("drawState")
	self.m_name = self:getChild("name")
	self.m_destinNumText = self:getChild("destinNumText")
	self.m_curProgressText = self:getChild("curProgressText")
	self.m_awardList = self:getChild("awardList")
	self.m_receiveBtn = self:getChild("receiveBtn")
	self.m_hasDrawComp = self:getChild("hasDrawComp")
end

var_0_0.DrawStateCtrl = {
	可领取 = 1,
	前往 = 0,
	已领取 = 2
}

return var_0_0
