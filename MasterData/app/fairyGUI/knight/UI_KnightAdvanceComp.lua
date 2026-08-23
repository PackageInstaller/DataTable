local var_0_0 = {}

var_0_0.URL = "ui://1rxs0yivjyr411"

function var_0_0:__ctor()
	self.m_isFullController = self:getController("isFull")
	self.m_isLevelEnoughController = self:getController("isLevelEnough")
	self.m_isOneKeyAdvanceController = self:getController("isOneKeyAdvance")
	self.m_progBar = self:getChild("progBar")
	self.m_valueDescText = self:getChild("valueDescText")
	self.m_skillDescText = self:getChild("skillDescText")
	self.m_matList = self:getChild("matList")
	self.m_limitTxt = self:getChild("limitTxt")
	self.m_resource1 = self:getChild("resource1")
	self.m_resource2 = self:getChild("resource2")
	self.m_advBtn = self:getChild("advBtn")
	self.m_newAdvBtn = self:getChild("newAdvBtn")
	self.m_oneKeyAdvance = self:getChild("oneKeyAdvance")
	self.m_enterTransition = self:getTransition("enter")
	self.m_backTransition = self:getTransition("back")
end

var_0_0.IsFullCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsLevelEnoughCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsOneKeyAdvanceCtrl = {
	等级足够 = 1,
	等级不足 = 0
}

return var_0_0
