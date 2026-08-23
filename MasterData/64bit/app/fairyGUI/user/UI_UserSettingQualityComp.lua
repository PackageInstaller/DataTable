local var_0_0 = {}

var_0_0.URL = "ui://2r646maykb6qb"

function var_0_0:__ctor()
	self.m_hideLangController = self:getController("hideLang")
	self.m_btnLow = self:getChild("btnLow")
	self.m_btnMid = self:getChild("btnMid")
	self.m_btnHigh = self:getChild("btnHigh")
	self.m_pictureGroup = self:getChild("pictureGroup")
	self.m_btnFirstSkipCG = self:getChild("btnFirstSkipCG")
	self.m_btnSkipCG = self:getChild("btnSkipCG")
	self.m_btnCG = self:getChild("btnCG")
	self.m_jumpCGGroup = self:getChild("jumpCGGroup")
	self.m_btnFirstSkipTween = self:getChild("btnFirstSkipTween")
	self.m_btnSkipTween = self:getChild("btnSkipTween")
	self.m_btnTween = self:getChild("btnTween")
	self.m_jumpTweenGroup = self:getChild("jumpTweenGroup")
	self.m_btnFirstSkipSpSkill = self:getChild("btnFirstSkipSpSkill")
	self.m_btnSkipSpSkill = self:getChild("btnSkipSpSkill")
	self.m_btnSpSkill = self:getChild("btnSpSkill")
	self.m_supperSkillGroup = self:getChild("supperSkillGroup")
	self.m_btnFirstSkipSpShow = self:getChild("btnFirstSkipSpShow")
	self.m_btnSkipSpShow = self:getChild("btnSkipSpShow")
	self.m_btnSpShow = self:getChild("btnSpShow")
	self.m_spShowGroup = self:getChild("spShowGroup")
	self.m_btnFirstSkipSuccubaShow = self:getChild("btnFirstSkipSuccubaShow")
	self.m_btnSkipSuccubaShow = self:getChild("btnSkipSuccubaShow")
	self.m_btnSuccubaShow = self:getChild("btnSuccubaShow")
	self.m_succubaShowGroup = self:getChild("succubaShowGroup")
	self.m_btnFPSLow = self:getChild("btnFPSLow")
	self.m_btnFPSHigh = self:getChild("btnFPSHigh")
	self.m_fpsGroup = self:getChild("fpsGroup")
	self.m_inviteSwitchBtn = self:getChild("inviteSwitchBtn")
	self.m_inviteSet = self:getChild("inviteSet")
	self.m_inviteGroup = self:getChild("inviteGroup")
	self.m_viewSwitchBtn = self:getChild("viewSwitchBtn")
	self.m_viewSet = self:getChild("viewSet")
	self.m_viewGroup = self:getChild("viewGroup")
	self.m_languageList = self:getChild("languageList")
	self.m_loadingtext = self:getChild("loadingtext")
	self.m_languageGroup = self:getChild("languageGroup")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.HideLangCtrl = {
	show = 0,
	hide = 1
}

return var_0_0
