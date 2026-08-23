local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnvzejgic33"

function var_0_0:__ctor()
	self.m_isNewController = self:getController("isNew")
	self.m_isAutoFragmentBoxController = self:getController("isAutoFragmentBox")
	self.m_isShowSpcialController = self:getController("isShowSpcial")
	self.m_showTypeController = self:getController("showType")
	self.m_qualityEffectTopNode = self:getChild("qualityEffectTopNode")
	self.m_petItem1 = self:getChild("petItem1")
	self.m_petItem2 = self:getChild("petItem2")
	self.m_shareComp = self:getChild("shareComp")
	self.m_flushTopNode = self:getChild("flushTopNode")
	self.m_normalEnterTransition = self:getTransition("normalEnter")
	self.m_enter_1Transition = self:getTransition("enter_1")
	self.m_enter_2Transition = self:getTransition("enter_2")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsNewCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsAutoFragmentBoxCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsShowSpcialCtrl = {
	hide = 0,
	show = 1
}
var_0_0.ShowTypeCtrl = {
	skin = 1,
	knight = 0
}

return var_0_0
