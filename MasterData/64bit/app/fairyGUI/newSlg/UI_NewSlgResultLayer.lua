local var_0_0 = {}

var_0_0.URL = "ui://pwjd9dt9e1al68t1"

function var_0_0:__ctor()
	self.m_typeController = self:getController("type")
	self.m_infoComp = self:getChild("infoComp")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_newSeasonComp = self:getChild("newSeasonComp")
	self.m_curSesonList = self:getChild("curSesonList")
	self.m_shopBtn = self:getChild("shopBtn")
	self.m_seasonRankBtn = self:getChild("seasonRankBtn")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.TypeCtrl = {
	page1 = 1,
	page0 = 0
}

return var_0_0
