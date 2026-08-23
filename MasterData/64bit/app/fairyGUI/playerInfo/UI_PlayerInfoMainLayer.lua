local var_0_0 = {}

var_0_0.URL = "ui://1hwemy6ugc0k11"

function var_0_0:__ctor()
	self.m_isShowPetController = self:getController("isShowPet")
	self.m_hasDataController = self:getController("hasData")
	self.m_showSpine = self:getChild("showSpine")
	self.m_bottomComp = self:getChild("bottomComp")
	self.m_showComp = self:getChild("showComp")
	self.m_userComp = self:getChild("userComp")
	self.m_topBar = self:getChild("topBar")
	self.m_enterTransition = self:getTransition("enter")
	self.m_enter_1Transition = self:getTransition("enter_1")
end

var_0_0.IsShowPetCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.HasDataCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
