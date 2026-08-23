local var_0_0 = {}

var_0_0.URL = "ui://kvb3znepehjk9v"

function var_0_0:__ctor()
	self.m_isEmptyController = self:getController("isEmpty")
	self.m_canLineUpController = self:getController("canLineUp")
	self.m_isLockController = self:getController("isLock")
	self.m_isWeddingController = self:getController("isWedding")
	self.m_isOtherController = self:getController("isOther")
	self.m_addPic = self:getChild("addPic")
	self.m_addText = self:getChild("addText")
	self.m_knightIcon = self:getChild("knightIcon")
	self.m_qualityBg = self:getChild("qualityBg")
	self.m_stageText = self:getChild("stageText")
	self.m_stageGroup = self:getChild("stageGroup")
	self.m_starComp = self:getChild("starComp")
	self.m_qualitySelectBgLeft = self:getChild("qualitySelectBgLeft")
	self.m_qualitySelectBgRight = self:getChild("qualitySelectBgRight")
	self.m_unLockText = self:getChild("unLockText")
	self.m_weddingLoader = self:getChild("weddingLoader")
	self.m_effectHolder = self:getChild("effectHolder")
	self.m_redPointComp = self:getChild("redPointComp")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsEmptyCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.CanLineUpCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLockCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsWeddingCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsOtherCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
