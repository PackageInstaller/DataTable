local var_0_0 = {}

var_0_0.URL = "ui://14huq3sff3yy1o"

function var_0_0:__ctor()
	self.m_speakerController = self:getController("speaker")
	self.m_isAniController = self:getController("isAni")
	self.m_dialogStyleController = self:getController("dialogStyle")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_dialogTxt = self:getChild("dialogTxt")
	self.m_dialogTxt1 = self:getChild("dialogTxt1")
	self.m_effectSpeaker = self:getChild("effectSpeaker")
	self.m_dialogComp = self:getChild("dialogComp")
	self.m_asmrTxt = self:getChild("asmrTxt")
	self.m_asmrTipTxt = self:getChild("asmrTipTxt")
	self.m_asmrTipGroup = self:getChild("asmrTipGroup")
	self.m_continueTxt = self:getChild("continueTxt")
	self.m_continueGroup = self:getChild("continueGroup")
	self.m_touchBg = self:getChild("touchBg")
	self.m_eff = self:getChild("eff")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
