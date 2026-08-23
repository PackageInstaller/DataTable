local var_0_0 = {}

var_0_0.URL = "ui://vpe6pr94sdp12i"

function var_0_0:__ctor()
	self.m_viewTypeController = self:getController("viewType")
	self.m_touchArea = self:getChild("touchArea")
	self.m_decoration4 = self:getChild("decoration4")
	self.m_closeTouch = self:getChild("closeTouch")
	self.m_ribbon = self:getChild("ribbon")
	self.m_decoration3 = self:getChild("decoration3")
	self.m_decoration1 = self:getChild("decoration1")
	self.m_unsignBtn = self:getChild("unsignBtn")
	self.m_viewComp = self:getChild("viewComp")
	self.m_decoration2 = self:getChild("decoration2")
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
