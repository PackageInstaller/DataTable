local var_0_0 = {}

var_0_0.URL = "ui://qa3xcguqerx14"

function var_0_0:__ctor()
	self.m_itemTypeController = self:getController("itemType")
	self.m_onlineStateController = self:getController("onlineState")
	self.m_forbiddenOprateController = self:getController("forbiddenOprate")
	self.m_giftTypeController = self:getController("giftType")
	self.m_isCrossServerController = self:getController("isCrossServer")
	self.m_icon = self:getChild("icon")
	self.m_iconLoader = self:getChild("iconLoader")
	self.m_levelTxt = self:getChild("levelTxt")
	self.m_nameTxt = self:getChild("nameTxt")
	self.m_onlineStateTxt = self:getChild("onlineStateTxt")
	self.m_offlineStateTxt = self:getChild("offlineStateTxt")
	self.m_powerTxt = self:getChild("powerTxt")
	self.m_guildTxt = self:getChild("guildTxt")
	self.m_refuseBtn = self:getChild("refuseBtn")
	self.m_agreeBtn = self:getChild("agreeBtn")
	self.m_addTipBtn = self:getChild("addTipBtn")
	self.m_blackDelBtn = self:getChild("blackDelBtn")
	self.m_giftLoader = self:getChild("giftLoader")
	self.m_homeBtn = self:getChild("homeBtn")
	self.m_chatBtn = self:getChild("chatBtn")
	self.m_infoPopBtn = self:getChild("infoPopBtn")
	self.m_serverNameTxt = self:getChild("serverNameTxt")
	self.m_inTransition = self:getTransition("in")
	self.m_outTransition = self:getTransition("out")
end

var_0_0.ItemTypeCtrl = {
	page2 = 1,
	page1 = 3,
	page0 = 0,
	page3 = 2
}
var_0_0.OnlineStateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.ForbiddenOprateCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.GiftTypeCtrl = {
	page0 = 0,
	page1 = 1
}
var_0_0.IsCrossServerCtrl = {
	page0 = 0,
	page1 = 1
}

return var_0_0
