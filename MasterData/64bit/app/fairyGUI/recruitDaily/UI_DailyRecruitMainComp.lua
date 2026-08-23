local var_0_0 = {}

var_0_0.URL = "ui://3w60uerptdy21h"

function var_0_0:__ctor()
	self.m_isEffectPlayingController = self:getController("isEffectPlaying")
	self.m_isFullLevelController = self:getController("isFullLevel")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_showSpine = self:getChild("showSpine")
	self.m_bubbleComp = self:getChild("bubbleComp")
	self.m_levelBtn = self:getChild("levelBtn")
	self.m_levelMaxBtn = self:getChild("levelMaxBtn")
	self.m_tipBtn = self:getChild("tipBtn")
	self.m_previewBtn = self:getChild("previewBtn")
	self.m_oneBtn = self:getChild("oneBtn")
	self.m_tenBtn = self:getChild("tenBtn")
	self.m_effectLight = self:getChild("effectLight")
	self.m_effectTitle = self:getChild("effectTitle")
	self.m_effectBtn = self:getChild("effectBtn")
	self.m_effectNode1 = self:getChild("effectNode1")
	self.m_effectLevel = self:getChild("effectLevel")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
