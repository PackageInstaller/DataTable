local var_0_0 = {}

var_0_0.URL = "ui://2r646maykb6qa"

function var_0_0:__ctor()
	self.m_sliderEnableController = self:getController("sliderEnable")
	self.m_bgmEnableController = self:getController("bgmEnable")
	self.m_effEnableController = self:getController("effEnable")
	self.m_voiceEnableController = self:getController("voiceEnable")
	self.m_bgmSlider = self:getChild("bgmSlider")
	self.m_soundBgmBtn = self:getChild("soundBgmBtn")
	self.m_effectSlider = self:getChild("effectSlider")
	self.m_soundEffBtn = self:getChild("soundEffBtn")
	self.m_voiceSlider = self:getChild("voiceSlider")
	self.m_soundVoiceBtn = self:getChild("soundVoiceBtn")
	self.m_voiceGroup = self:getChild("voiceGroup")
	self.m_pictureGroup = self:getChild("pictureGroup")
	self.m_soundMainBtn = self:getChild("soundMainBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.SliderEnableCtrl = {
	enable = 1,
	disable = 0
}
var_0_0.BgmEnableCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.EffEnableCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.VoiceEnableCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
