local var_0_0 = {}

var_0_0.URL = "ui://2r646mayqufe1i"

function var_0_0:__ctor()
	self.m_isBindController = self:getController("isBind")
	self.m_popPanel = self:getChild("popPanel")
	self.m_btnBind = self:getChild("btnBind")
	self.m_btnReward = self:getChild("btnReward")
	self.m_btnExChange = self:getChild("btnExChange")
	self.m_tipText = self:getChild("tipText")
	self.m_helpBtn = self:getChild("helpBtn")
	self.m_content = self:getChild("content")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsBindCtrl = {
	none = 0,
	bindAndRecv = 3,
	bind = 1
}

return var_0_0
