local var_0_0 = {}

var_0_0.URL = "ui://kvb3znephjpc1emigaz"

function var_0_0:__ctor()
	self.m_emptyController = self:getController("empty")
	self.m_addEnableController = self:getController("addEnable")
	self.m_bindEmptyController = self:getController("bindEmpty")
	self.m_isLockController = self:getController("isLock")
	self.m_draggingBgImg = self:getChild("draggingBgImg")
	self.m_knightClickAreaComp = self:getChild("knightClickAreaComp")
	self.m_lockIcon = self:getChild("lockIcon")
	self.m_addBtn = self:getChild("addBtn")
	self.m_knightIconLbl = self:getChild("knightIconLbl")
	self.m_linkLvTxt = self:getChild("linkLvTxt")
	self.m_lvGroup = self:getChild("lvGroup")
	self.m_bindKnightLoader = self:getChild("bindKnightLoader")
	self.m_lvWordGroup = self:getChild("lvWordGroup")
	self.m_starComp = self:getChild("starComp")
	self.m_leftQualityLoader = self:getChild("leftQualityLoader")
	self.m_elementLoader = self:getChild("elementLoader")
	self.m_leaderLoader = self:getChild("leaderLoader")
	self.m_effDadComp = self:getChild("effDadComp")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_levelTransition = self:getTransition("level")
end

var_0_0.EmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.AddEnableCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.BindEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLockCtrl = {
	lock = 1,
	normal = 0
}

return var_0_0
