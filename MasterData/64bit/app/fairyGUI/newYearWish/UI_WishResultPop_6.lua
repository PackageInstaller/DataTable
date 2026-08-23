local var_0_0 = {}

var_0_0.URL = "ui://vpe6pr94av756m"

function var_0_0:__ctor()
	self.m_viewTypeController = self:getController("viewType")
	self.m_closeTouch = self:getChild("closeTouch")
	self.m_viewComp = self:getChild("viewComp")
	self.m_unsignBtn = self:getChild("unsignBtn")
	self.m_shareBtnComp = self:getChild("shareBtnComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.ViewTypeCtrl = {
	page1 = 1,
	page0 = 0,
	page2 = 6
}

return var_0_0
