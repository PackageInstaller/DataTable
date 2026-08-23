local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepkb6qibn9"

function var_0_0:__ctor()
	self.m_isShowInfoController = self:getController("isShowInfo")
	self.m_nameTypeController = self:getController("nameType")
	self.m_hideSkinController = self:getController("hideSkin")
	self.m_isShowWeddingController = self:getController("isShowWedding")
	self.m_imgEmpty = self:getChild("imgEmpty")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_weddingLoader = self:getChild("weddingLoader")
	self.m_leaderLoader = self:getChild("leaderLoader")
	self.m_elementLoader = self:getChild("elementLoader")
	self.m_weddingEff = self:getChild("weddingEff")
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
	hide = 0,
	show = 1
}
var_0_0.NameTypeCtrl = {
	towRow = 2,
	hide = 0,
	oneRow = 1
}
var_0_0.HideSkinCtrl = {
	hide = 1,
	show = 0
}
var_0_0.IsShowWeddingCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
