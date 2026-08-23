local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnsinkgic2q"

function var_0_0:__ctor()
	self.m_posTypeController = self:getController("posType")
	self.m_menuList = self:getChild("menuList")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.PosTypeCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
