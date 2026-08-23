local var_0_0 = {}

var_0_0.URL = "ui://qzlsgbi1uhvyw"

function var_0_0:__ctor()
	self.m_showAITipController = self:getController("showAITip")
	self.m_mask = self:getChild("mask")
	self.m_inputTxt = self:getChild("inputTxt")
	self.m_sendBtn = self:getChild("sendBtn")
	self.m_chatList = self:getChild("chatList")
	self.m_aiTipTxt = self:getChild("aiTipTxt")
	self.m_clearBtn = self:getChild("clearBtn")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

return var_0_0
