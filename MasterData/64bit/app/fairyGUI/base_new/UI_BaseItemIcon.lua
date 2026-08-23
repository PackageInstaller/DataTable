local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepvfn1ibks"

function var_0_0:__ctor()
	self.m_isShowNumController = self:getController("isShowNum")
	self.m_nameTypeController = self:getController("nameType")
	self.m_isFragController = self:getController("isFrag")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_effectBg = self:getChild("effectBg")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_weddingKnight = self:getChild("weddingKnight")
	self.m_effectIcon = self:getChild("effectIcon")
	self.m_fragGLoader = self:getChild("fragGLoader")
	self.m_numText = self:getChild("numText")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_grayGraph = self:getChild("grayGraph")
	self.m_contentGroup = self:getChild("contentGroup")
	self.m_effectNode = self:getChild("effectNode")
end

var_0_0.IsShowNumCtrl = {
	hide = 1,
	show = 0
}
var_0_0.NameTypeCtrl = {
	oneRow = 1,
	hide = 0,
	twoRow = 2
}
var_0_0.IsFragCtrl = {
	frag = 1,
	normal = 0
}

return var_0_0
