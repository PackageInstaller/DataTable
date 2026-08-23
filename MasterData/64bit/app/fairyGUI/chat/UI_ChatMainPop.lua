local var_0_0 = {}

var_0_0.URL = "ui://v9hfyn87dhwcby2ww"

function var_0_0:__ctor()
	self.m_showBottomController = self:getController("showBottom")
	self.m_stateController = self:getController("state")
	self.m_emptyTypeController = self:getController("emptyType")
	self.m_chatBg = self:getChild("chatBg")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_setBtn = self:getChild("setBtn")
	self.m_tabList = self:getChild("tabList")
	self.m_chatList = self:getChild("chatList")
	self.m_privateComp = self:getChild("privateComp")
	self.m_jumpBtn = self:getChild("jumpBtn")
	self.m_bottomComp = self:getChild("bottomComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.ShowBottomCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.StateCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.EmptyTypeCtrl = {
	page2 = 3,
	page1 = 1,
	page0 = 0
}

return var_0_0
