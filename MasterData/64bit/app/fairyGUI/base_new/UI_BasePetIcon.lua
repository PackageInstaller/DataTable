local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepj03c178bhdz"

function var_0_0:__ctor()
	self.m_isShowInfoController = self:getController("isShowInfo")
	self.m_nameTypeController = self:getController("nameType")
	self.m_imgEmpty = self:getChild("imgEmpty")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_starBg = self:getChild("starBg")
	self.m_starComp = self:getChild("starComp")
	self.m_advanceBg = self:getChild("advanceBg")
	self.m_infoGroup = self:getChild("infoGroup")
	self.m_numText = self:getChild("numText")
	self.m_advanceText = self:getChild("advanceText")
	self.m_grayGraph = self:getChild("grayGraph")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_contentGroup = self:getChild("contentGroup")
	self.m_effectNode = self:getChild("effectNode")
end

var_0_0.IsShowInfoCtrl = {
	show = 1,
	hide = 0
}
var_0_0.NameTypeCtrl = {
	towRow = 2,
	hide = 0,
	oneRow = 1
}

return var_0_0
