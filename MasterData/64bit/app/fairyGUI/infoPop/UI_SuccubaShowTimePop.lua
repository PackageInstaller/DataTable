local var_0_0 = {}

var_0_0.URL = "ui://pcyz87bnwspz1v5dsrr"

function var_0_0:__ctor()
	self.m_isNewController = self:getController("isNew")
	self.m_isAutoFragmentBoxController = self:getController("isAutoFragmentBox")
	self.m_isPlayShowController = self:getController("isPlayShow")
	self.m_bgLoader1 = self:getChild("bgLoader1")
	self.m_bgLoader2 = self:getChild("bgLoader2")
	self.m_qualityEffectNode = self:getChild("qualityEffectNode")
	self.m_lineBg1 = self:getChild("lineBg1")
	self.m_lineBg2 = self:getChild("lineBg2")
	self.m_spineComp1 = self:getChild("spineComp1")
	self.m_qualityEffectNode1 = self:getChild("qualityEffectNode1")
	self.m_qualityLightNode1 = self:getChild("qualityLightNode1")
	self.m_nameBgLoader1 = self:getChild("nameBgLoader1")
	self.m_qualityGLoader1 = self:getChild("qualityGLoader1")
	self.m_nameTxt1 = self:getChild("nameTxt1")
	self.m_nameGroup1 = self:getChild("nameGroup1")
	self.m_spineGroup1 = self:getChild("spineGroup1")
	self.m_spineComp2 = self:getChild("spineComp2")
	self.m_qualityEffectNode2 = self:getChild("qualityEffectNode2")
	self.m_qualityLightNode2 = self:getChild("qualityLightNode2")
	self.m_nameBgLoader2 = self:getChild("nameBgLoader2")
	self.m_qualityGLoader2 = self:getChild("qualityGLoader2")
	self.m_nameTxt2 = self:getChild("nameTxt2")
	self.m_nameGroup2 = self:getChild("nameGroup2")
	self.m_spineGroup2 = self:getChild("spineGroup2")
	self.m_bgRightLoader = self:getChild("bgRightLoader")
	self.m_bgTipLoader = self:getChild("bgTipLoader")
	self.m_qualityEffectTopNode = self:getChild("qualityEffectTopNode")
	self.m_shareComp = self:getChild("shareComp")
	self.m_fragIcon = self:getChild("fragIcon")
	self.m_autoFragmentTxt = self:getChild("autoFragmentTxt")
	self.m_fragGroup = self:getChild("fragGroup")
	self.m_flushTopNode = self:getChild("flushTopNode")
	self.m_knightMovieComp = self:getChild("knightMovieComp")
	self.m_effectComp = self:getChild("effectComp")
	self.m_skipBtn = self:getChild("skipBtn")
	self.m_normalEnterTransition = self:getTransition("normalEnter")
	self.m_enter_2Transition = self:getTransition("enter_2")
	self.m_enter_1Transition = self:getTransition("enter_1")
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
var_0_0.IsPlayShowCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
