local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jhdt68oy"

function var_0_0:__ctor()
	self.m_touchBg = self:getChild("touchBg")
	self.m_mainCityComp = self:getChild("mainCityComp")
	self.m_embryoList = self:getChild("embryoList")
	self.m_bgImage = self:getChild("bgImage")
	self.m_canLineupLIst = self:getChild("canLineupLIst")
	self.m_filterBtn = self:getChild("filterBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_showListTransition = self:getTransition("showList")
	self.m_hideListTransition = self:getTransition("hideList")
end

return var_0_0
