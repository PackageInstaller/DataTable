local var_0_0 = {}

var_0_0.URL = "ui://3ryajb8dq71dlgic8e"

function var_0_0:__ctor()
	self.m_isMultController = self:getController("isMult")
	self.m_list = self:getChild("list")
	self.m_arrowNode = self:getChild("arrowNode")
	self.m_ratioText = self:getChild("ratioText")
	self.m_loaderBtn = self:getChild("loaderBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsMultCtrl = {
	normal = 0,
	mult = 1
}

return var_0_0
