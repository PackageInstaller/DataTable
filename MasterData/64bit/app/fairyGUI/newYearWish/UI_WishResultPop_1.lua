local var_0_0 = {}

var_0_0.URL = "ui://vpe6pr94fsoa0"

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
	page2 = 6,
	page1 = 1,
	page0 = 0
}

return var_0_0
