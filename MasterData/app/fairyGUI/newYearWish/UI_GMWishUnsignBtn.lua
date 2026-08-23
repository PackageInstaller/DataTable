local var_0_0 = {}

var_0_0.URL = "ui://vpe6pr94sdp12m"

function var_0_0:__ctor()
	self.m_viewTypeController = self:getController("viewType")
	self.m_unsignBg = self:getChild("unsignBg")
	self.m_effComp = self:getChild("effComp")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ViewTypeCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}

return var_0_0
