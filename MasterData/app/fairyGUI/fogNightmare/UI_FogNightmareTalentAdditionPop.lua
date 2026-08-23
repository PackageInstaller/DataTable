local var_0_0 = {}

var_0_0.URL = "ui://8l5kh88ou8jrrriz"

function var_0_0:__ctor()
	self.m_showTipsController = self:getController("showTips")
	self.m_bgPanel = self:getChild("bgPanel")
	self.m_txt = self:getChild("txt")
	self.m_infoComp = self:getChild("infoComp")
	self.m_tipBtn = self:getChild("tipBtn")
	self.m_tipBubbleTxt = self:getChild("tipBubbleTxt")
	self.m_tipBubbleGroup = self:getChild("tipBubbleGroup")
	self.m_content = self:getChild("content")
end

var_0_0.ShowTipsCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
