local var_0_0 = {}

var_0_0.URL = "ui://99hn30599mdb1v"

function var_0_0:__ctor()
	self.m_drawStateController = self:getController("drawState")
	self.m_name = self:getChild("name")
	self.m_descText = self:getChild("descText")
	self.m_destinNumText = self:getChild("destinNumText")
	self.m_curProgressText = self:getChild("curProgressText")
	self.m_awardList = self:getChild("awardList")
	self.m_receiveBtn = self:getChild("receiveBtn")
	self.m_lockDesc = self:getChild("lockDesc")
end

var_0_0.DrawStateCtrl = {
	可领取 = 2,
	前往 = 1,
	未开启 = 0,
	任务未达到开启时间 = 7,
	已领取 = 3
}

return var_0_0
