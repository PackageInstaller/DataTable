local var_0_0 = {}

var_0_0.URL = "ui://iibfqm99jnegkk2ob"

function var_0_0:__ctor()
	self.m_onlyViewController = self:getController("onlyView")
	self.m_changeBtn = self:getChild("changeBtn")
	self.m_developBtn = self:getChild("developBtn")
	self.m_viewBtn = self:getChild("viewBtn")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.OnlyViewCtrl = {
	onlyView = 1,
	normal = 0
}

return var_0_0
