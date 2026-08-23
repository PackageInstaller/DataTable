local var_0_0 = {}

var_0_0.URL = "ui://lom3h0lc9udx2p"

function var_0_0:__ctor()
	self.m_hasBoxController = self:getController("hasBox")
	self.m_boxNumController = self:getController("boxNum")
	self.m_isShowEffectController = self:getController("isShowEffect")
	self.m_scoreComp = self:getChild("scoreComp")
	self.m_boxOpenDesc = self:getChild("boxOpenDesc")
	self.m_boxList = self:getChild("boxList")
	self.m_openBtn = self:getChild("openBtn")
	self.m_topBar = self:getChild("topBar")
	self.m_showBoxComp = self:getChild("showBoxComp")
	self.m_boxEff = self:getChild("boxEff")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.HasBoxCtrl = {
	page0 = 0,
	page2 = 2,
	page1 = 1
}
var_0_0.BoxNumCtrl = {
	page2 = 2,
	page5 = 5,
	page1 = 1,
	page4 = 4,
	page0 = 8,
	page6 = 6,
	page3 = 3,
	page7 = 7
}
var_0_0.IsShowEffectCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
