local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88odexu9rrro"

function var_0_0:__ctor()
	self.m_styleController = self:getController("style")
	self.m_isUnlockController = self:getController("isUnlock")
	self.m_uniteTxtImage = self:getChild("uniteTxtImage")
	self.m_petBg = self:getChild("petBg")
	self.m_uniteBg = self:getChild("uniteBg")
	self.m_changeBtnArtifact = self:getChild("changeBtnArtifact")
	self.m_changeBtnPet = self:getChild("changeBtnPet")
	self.m_changeBtnSuccuba = self:getChild("changeBtnSuccuba")
	self.m_uniteBtn1 = self:getChild("uniteBtn1")
	self.m_uniteBtn2 = self:getChild("uniteBtn2")
	self.m_uniteBtn3 = self:getChild("uniteBtn3")
	self.m_uniteBtn4 = self:getChild("uniteBtn4")
	self.m_petBtn1 = self:getChild("petBtn1")
	self.m_petBtn2 = self:getChild("petBtn2")
	self.m_petBtn3 = self:getChild("petBtn3")
	self.m_petBtn4 = self:getChild("petBtn4")
	self.m_petBtn5 = self:getChild("petBtn5")
	self.m_succubaComp1 = self:getChild("succubaComp1")
	self.m_succubaComp2 = self:getChild("succubaComp2")
	self.m_succubaComp3 = self:getChild("succubaComp3")
end

var_0_0.StyleCtrl = {
	pet = 1,
	uniteToken = 0,
	succuba = 2
}
var_0_0.IsUnlockCtrl = {
	unlock = 1,
	lock = 0
}

return var_0_0
