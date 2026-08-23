local var_0_0 = {}

var_0_0.URL = "ui://3ggec6qrt5kt5s"

function var_0_0:__ctor()
	self.m_bgDiLoader = self:getChild("bgDiLoader")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_effectBg = self:getChild("effectBg")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_magicalHolder = self:getChild("magicalHolder")
	self.m_weddingKnight = self:getChild("weddingKnight")
	self.m_effectIcon = self:getChild("effectIcon")
	self.m_effHolder = self:getChild("effHolder")
	self.m_picBgLoader = self:getChild("picBgLoader")
	self.m_titleTxt = self:getChild("titleTxt")
	self.m_openTransition = self:getTransition("open")
end

return var_0_0
