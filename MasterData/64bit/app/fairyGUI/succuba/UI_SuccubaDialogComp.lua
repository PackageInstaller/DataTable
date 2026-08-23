local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1wspz47"

function var_0_0:__ctor()
	self.m_speakerController = self:getController("speaker")
	self.m_isAniController = self:getController("isAni")
	self.m_dialogStyleController = self:getController("dialogStyle")
	self.m_isShowLeveController = self:getController("isShowLeve")
	self.m_isShowContinueController = self:getController("isShowContinue")
	self.m_levelComp = self:getChild("levelComp")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_dialogTxt = self:getChild("dialogTxt")
	self.m_eff = self:getChild("eff")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
	self.m_switchTransition = self:getTransition("switch")
	self.m_hideTransition = self:getTransition("hide")
	self.m_continueTransition = self:getTransition("continue")
end

return var_0_0
