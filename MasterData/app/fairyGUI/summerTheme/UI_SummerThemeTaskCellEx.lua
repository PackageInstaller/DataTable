local var_0_0 = {}

var_0_0.URL = "ui://99hn30599mdbkk2zm"

function var_0_0:__ctor()
	self.m_drawStateController = self:getController("drawState")
	self.m_name = self:getChild("name")
	self.m_descText = self:getChild("descText")
	self.m_destinNumText = self:getChild("destinNumText")
	self.m_curProgressText = self:getChild("curProgressText")
	self.m_receiveBtn = self:getChild("receiveBtn")
	self.m_iconImg = self:getChild("iconImg")
	self.m_progComp = self:getChild("progComp")
end

var_0_0.DrawStateCtrl = {
	前往 = 1,
	任务未达到开启时间 = 4,
	未开启 = 0,
	可领取 = 2,
	已领取 = 3
}

return var_0_0
