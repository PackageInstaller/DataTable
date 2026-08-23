local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9jhdt68oy"

function var_0_0:__ctor()
	self.m_isExpandController = self:getController("isExpand")
	self.m_mainCityComp = self:getChild("mainCityComp")
	self.m_embryoList = self:getChild("embryoList")
	self.m_touchBg = self:getChild("touchBg")
	self.m_bgImage = self:getChild("bgImage")
	self.m_canLineupList = self:getChild("canLineupList")
	self.m_filterBtn = self:getChild("filterBtn")
	self.m_emptyText = self:getChild("emptyText")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_showListTransition = self:getTransition("showList")
	self.m_hideListTransition = self:getTransition("hideList")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.IsExpandCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
