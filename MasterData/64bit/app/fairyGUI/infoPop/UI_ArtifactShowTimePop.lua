local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnv87pgic1x"

function var_0_0:__ctor()
	self.m_isNewController = self:getController("isNew")
	self.m_isAutoFragmentBoxController = self:getController("isAutoFragmentBox")
	self.m_isShowSpcialController = self:getController("isShowSpcial")
	self.m_showTypeController = self:getController("showType")
	self.m_qualityEffectTopNode = self:getChild("qualityEffectTopNode")
	self.m_artifactItem1 = self:getChild("artifactItem1")
	self.m_artifactItem2 = self:getChild("artifactItem2")
	self.m_shareComp = self:getChild("shareComp")
	self.m_flushTopNode = self:getChild("flushTopNode")
	self.m_normalEnterTransition = self:getTransition("normalEnter")
	self.m_enter_1Transition = self:getTransition("enter_1")
	self.m_enter_2Transition = self:getTransition("enter_2")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsNewCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsAutoFragmentBoxCtrl = {
	page1 = 1,
	page0 = 0
}
var_0_0.IsShowSpcialCtrl = {
	show = 1,
	hide = 0
}
var_0_0.ShowTypeCtrl = {
	knight = 0,
	skin = 1
}

return var_0_0
