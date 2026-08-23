local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepmdfj1a"

function var_0_0:__ctor()
	self.m_titleTypeController = self:getController("titleType")
	self.m_showCloseController = self:getController("showClose")
	self.m_showHelpController = self:getController("showHelp")
	self.m_leftTitle = self:getChild("leftTitle")
	self.m_help = self:getChild("help")
	self.m_closeBtn = self:getChild("closeBtn")
	self.m_openTransition = self:getTransition("open")
	self.m_closeTransition = self:getTransition("close")
end

var_0_0.TitleTypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowCloseCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ShowHelpCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
