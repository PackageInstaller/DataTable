local var_0_0 = {}

var_0_0.URL = "ui://z48x0zjhrlzz0"

function var_0_0:__ctor()
	self.m_bgEff = self:getChild("bgEff")
	self.m_title = self:getChild("title")
	self.m_descTxt = self:getChild("descTxt")
	self.m_dungeonList = self:getChild("dungeonList")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

return var_0_0
