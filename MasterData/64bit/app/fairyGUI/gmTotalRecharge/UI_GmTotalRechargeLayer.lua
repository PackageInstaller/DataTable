local var_0_0 = {}

var_0_0.URL = "ui://p5a8ifc3frlf0"

function var_0_0:__ctor()
	self.m_showTabController = self:getController("showTab")
	self.m_tabTypeController = self:getController("tabType")
	self.m_bgLoader = self:getChild("bgLoader")
	self.m_knightPic = self:getChild("knightPic")
	self.m_effComp = self:getChild("effComp")
	self.m_titleLoader = self:getChild("titleLoader")
	self.m_list = self:getChild("list")
	self.m_repeatBtn = self:getChild("repeatBtn")
	self.m_picLoader = self:getChild("picLoader")
	self.m_qualityLoader = self:getChild("qualityLoader")
	self.m_knightNameTxt = self:getChild("knightNameTxt")
	self.m_smallQualityLoader = self:getChild("smallQualityLoader")
	self.m_skinNameTxt = self:getChild("skinNameTxt")
	self.m_lookSkinAreaComp = self:getChild("lookSkinAreaComp")
	self.m_skinGroup = self:getChild("skinGroup")
	self.m_rechargeTaskBtn = self:getChild("rechargeTaskBtn")
	self.m_drawCardTaskBtn = self:getChild("drawCardTaskBtn")
	self.m_timeTxt = self:getChild("timeTxt")
	self.m_topBarComp = self:getChild("topBarComp")
	self.m_enterTransition = self:getTransition("enter")
end

var_0_0.ShowTabCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.TabTypeCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
