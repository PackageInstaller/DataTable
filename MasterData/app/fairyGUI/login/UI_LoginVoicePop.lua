local var_0_0 = {}

var_0_0.URL = "ui://xigti88ceypq4v"

function var_0_0:__ctor()
	self.m_voiceController = self:getController("voice")
	self.m_popPanel = self:getChild("popPanel")
	self.m_chinaVoiceArea = self:getChild("chinaVoiceArea")
	self.m_content = self:getChild("content")
end

var_0_0.VoiceCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
